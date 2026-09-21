from contextlib import asynccontextmanager
from datetime import datetime, timezone
from pathlib import Path
from secrets import token_urlsafe
import sqlite3

from fastapi import Depends, FastAPI, Header, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, EmailStr, Field

DATABASE_PATH = Path("/app/data/employee_dashboard.db")
TOKENS: dict[str, int] = {}
SEED_EMPLOYEES = [
    (1001, "Arjun Kumar", "arjun@example.com", "Engineering", "Software Engineer", "Active"),
    (1002, "Priya Sharma", "priya@example.com", "HR", "HR Manager", "Active"),
    (1003, "Rahul Reddy", "rahul@example.com", "Finance", "Accountant", "On Leave"),
    (1004, "Sneha Rao", "sneha@example.com", "Design", "UI/UX Designer", "Active"),
    (1005, "Vikram Singh", "vikram@example.com", "Marketing", "Marketing Executive", "Active"),
    (1006, "Meghana Patel", "meghana@example.com", "Sales", "Sales Executive", "Active"),
]


class LoginRequest(BaseModel):
    email: EmailStr
    password: str = Field(min_length=1)


class EmployeeInput(BaseModel):
    name: str = Field(min_length=1, max_length=120)
    email: EmailStr
    department: str = Field(min_length=1, max_length=80)
    role: str = Field(min_length=1, max_length=120)
    status: str = Field(pattern="^(Active|On Leave)$")


class ProfileInput(BaseModel):
    firstName: str = Field(min_length=1, max_length=80)
    lastName: str = Field(min_length=1, max_length=80)
    email: EmailStr
    phone: str = Field(max_length=40)
    department: str = Field(min_length=1, max_length=80)
    role: str = Field(min_length=1, max_length=120)


class Employee(EmployeeInput):
    id: int


class Profile(ProfileInput):
    id: int
    status: str


def connection() -> sqlite3.Connection:
    database = sqlite3.connect(DATABASE_PATH)
    database.row_factory = sqlite3.Row
    return database


def initialize_database() -> None:
    with connection() as database:
        database.executescript("""
            CREATE TABLE IF NOT EXISTS employees (
                id INTEGER PRIMARY KEY, name TEXT NOT NULL, email TEXT NOT NULL UNIQUE,
                department TEXT NOT NULL, role TEXT NOT NULL, status TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS profiles (
                id INTEGER PRIMARY KEY, first_name TEXT NOT NULL, last_name TEXT NOT NULL,
                email TEXT NOT NULL, phone TEXT NOT NULL, department TEXT NOT NULL,
                role TEXT NOT NULL, status TEXT NOT NULL
            );
        """)
        if database.execute("SELECT COUNT(*) FROM employees").fetchone()[0] == 0:
            database.executemany("INSERT INTO employees VALUES (?, ?, ?, ?, ?, ?)", SEED_EMPLOYEES)
        if database.execute("SELECT COUNT(*) FROM profiles").fetchone()[0] == 0:
            database.execute("INSERT INTO profiles VALUES (1, 'Admin', 'User', 'admin@example.com', '+91 98765 43210', 'Administration', 'Administrator', 'Active')")


@asynccontextmanager
async def lifespan(_: FastAPI):
    initialize_database()
    yield


app = FastAPI(title="Employee Dashboard API", version="1.0.0", lifespan=lifespan)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://127.0.0.1:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def user_id(authorization: str | None = Header(default=None)) -> int:
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Authentication required")
    identity = TOKENS.get(authorization.removeprefix("Bearer ").strip())
    if identity is None:
        raise HTTPException(status_code=401, detail="Invalid or expired token")
    return identity


def profile_json(row: sqlite3.Row) -> dict:
    return {"id": row["id"], "firstName": row["first_name"], "lastName": row["last_name"], "email": row["email"], "phone": row["phone"], "department": row["department"], "role": row["role"], "status": row["status"]}


@app.get("/api/health")
def health() -> dict[str, str]:
    return {"status": "ok", "timestamp": datetime.now(timezone.utc).isoformat()}


@app.post("/api/auth/login")
def login(payload: LoginRequest) -> dict:
    if payload.email != "admin@example.com" or payload.password != "123456":
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid email or password")
    token = token_urlsafe(32)
    TOKENS[token] = 1
    with connection() as database:
        profile_row = database.execute("SELECT * FROM profiles WHERE id = 1").fetchone()
    return {"access_token": token, "token_type": "bearer", "user": profile_json(profile_row)}


@app.get("/api/dashboard")
def dashboard(_: int = Depends(user_id)) -> dict:
    with connection() as database:
        stats = {
            "totalEmployees": database.execute("SELECT COUNT(*) FROM employees").fetchone()[0],
            "activeEmployees": database.execute("SELECT COUNT(*) FROM employees WHERE status = 'Active'").fetchone()[0],
            "departments": database.execute("SELECT COUNT(DISTINCT department) FROM employees").fetchone()[0],
            "onLeave": database.execute("SELECT COUNT(*) FROM employees WHERE status = 'On Leave'").fetchone()[0],
        }
        recent = database.execute("SELECT * FROM employees ORDER BY id DESC LIMIT 5").fetchall()
        departments = database.execute("SELECT department AS name, COUNT(*) AS count FROM employees GROUP BY department ORDER BY count DESC").fetchall()
    return {"stats": stats, "recent": [dict(row) for row in recent], "departments": [dict(row) for row in departments]}


@app.get("/api/employees", response_model=list[Employee])
def employees(_: int = Depends(user_id)) -> list[dict]:
    with connection() as database:
        return [dict(row) for row in database.execute("SELECT * FROM employees ORDER BY id").fetchall()]


@app.post("/api/employees", response_model=Employee, status_code=201)
def create_employee(payload: EmployeeInput, _: int = Depends(user_id)) -> dict:
    with connection() as database:
        try:
            cursor = database.execute("INSERT INTO employees (name, email, department, role, status) VALUES (?, ?, ?, ?, ?)", tuple(payload.model_dump().values()))
        except sqlite3.IntegrityError as error:
            raise HTTPException(status_code=409, detail="An employee with this email already exists") from error
        return dict(database.execute("SELECT * FROM employees WHERE id = ?", (cursor.lastrowid,)).fetchone())


@app.put("/api/employees/{employee_id}", response_model=Employee)
def update_employee(employee_id: int, payload: EmployeeInput, _: int = Depends(user_id)) -> dict:
    values = payload.model_dump()
    with connection() as database:
        try:
            cursor = database.execute("UPDATE employees SET name=?, email=?, department=?, role=?, status=? WHERE id=?", (*values.values(), employee_id))
        except sqlite3.IntegrityError as error:
            raise HTTPException(status_code=409, detail="An employee with this email already exists") from error
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Employee not found")
        return dict(database.execute("SELECT * FROM employees WHERE id = ?", (employee_id,)).fetchone())


@app.delete("/api/employees/{employee_id}", status_code=204)
def delete_employee(employee_id: int, _: int = Depends(user_id)) -> None:
    with connection() as database:
        cursor = database.execute("DELETE FROM employees WHERE id = ?", (employee_id,))
    if cursor.rowcount == 0:
        raise HTTPException(status_code=404, detail="Employee not found")


@app.get("/api/profile", response_model=Profile)
def profile(_: int = Depends(user_id)) -> dict:
    with connection() as database:
        return profile_json(database.execute("SELECT * FROM profiles WHERE id = 1").fetchone())


@app.put("/api/profile", response_model=Profile)
def update_profile(payload: ProfileInput, _: int = Depends(user_id)) -> dict:
    values = payload.model_dump()
    with connection() as database:
        database.execute("UPDATE profiles SET first_name=?, last_name=?, email=?, phone=?, department=?, role=? WHERE id=1", (values["firstName"], values["lastName"], values["email"], values["phone"], values["department"], values["role"]))
        return profile_json(database.execute("SELECT * FROM profiles WHERE id = 1").fetchone())
