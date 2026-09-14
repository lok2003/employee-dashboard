import { useMemo, useState } from "react";

const initialEmployees = [
  { id: 1001, name: "Arjun Kumar", email: "arjun@example.com", department: "Engineering", role: "Software Engineer", status: "Active" },
  { id: 1002, name: "Priya Sharma", email: "priya@example.com", department: "HR", role: "HR Manager", status: "Active" },
  { id: 1003, name: "Rahul Reddy", email: "rahul@example.com", department: "Finance", role: "Accountant", status: "On Leave" },
  { id: 1004, name: "Sneha Rao", email: "sneha@example.com", department: "Design", role: "UI/UX Designer", status: "Active" },
  { id: 1005, name: "Vikram Singh", email: "vikram@example.com", department: "Marketing", role: "Marketing Executive", status: "Active" },
  { id: 1006, name: "Meghana Patel", email: "meghana@example.com", department: "Sales", role: "Sales Executive", status: "Active" }
];

const blank = { name: "", email: "", department: "Engineering", role: "", status: "Active" };

export default function Employees() {
  const [employees, setEmployees] = useState(initialEmployees);
  const [search, setSearch] = useState("");
  const [form, setForm] = useState(blank);
  const [editingId, setEditingId] = useState(null);
  const [showForm, setShowForm] = useState(false);

  const filtered = useMemo(() => {
    const q = search.toLowerCase();
    return employees.filter((e) =>
      [e.name, e.email, e.department, e.role].some((v) => v.toLowerCase().includes(q))
    );
  }, [employees, search]);

  const update = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const save = (e) => {
    e.preventDefault();
    if (!form.name.trim() || !form.email.trim() || !form.role.trim()) return;

    if (editingId) {
      setEmployees(employees.map((item) => item.id === editingId ? { ...item, ...form } : item));
    } else {
      setEmployees([...employees, { ...form, id: Date.now() }]);
    }
    setForm(blank);
    setEditingId(null);
    setShowForm(false);
  };

  const edit = (employee) => {
    setForm({
      name: employee.name,
      email: employee.email,
      department: employee.department,
      role: employee.role,
      status: employee.status
    });
    setEditingId(employee.id);
    setShowForm(true);
  };

  const remove = (id) => {
    if (window.confirm("Delete this employee?")) {
      setEmployees(employees.filter((e) => e.id !== id));
    }
  };

  return (
    <div>
      <div className="page-header">
        <div>
          <p className="eyebrow">PEOPLE</p>
          <h1>Employees</h1>
          <p>Manage employee records, roles and departments.</p>
        </div>
        <button className="primary-button" onClick={() => {
          setForm(blank); setEditingId(null); setShowForm(true);
        }}>+ Add Employee</button>
      </div>

      {showForm && (
        <form className="panel employee-form" onSubmit={save}>
          <div className="panel-heading">
            <div><h2>{editingId ? "Edit Employee" : "Add Employee"}</h2><p>Enter the employee details below.</p></div>
            <button type="button" className="icon-close" onClick={() => setShowForm(false)}>×</button>
          </div>
          <div className="form-grid">
            <div><label>Full name</label><input name="name" value={form.name} onChange={update} required /></div>
            <div><label>Email</label><input type="email" name="email" value={form.email} onChange={update} required /></div>
            <div><label>Department</label><select name="department" value={form.department} onChange={update}>
              <option>Engineering</option><option>HR</option><option>Finance</option><option>Design</option><option>Marketing</option><option>Sales</option>
            </select></div>
            <div><label>Role</label><input name="role" value={form.role} onChange={update} required /></div>
            <div><label>Status</label><select name="status" value={form.status} onChange={update}><option>Active</option><option>On Leave</option></select></div>
          </div>
          <div className="form-actions">
            <button type="button" className="secondary-button" onClick={() => setShowForm(false)}>Cancel</button>
            <button className="primary-button">{editingId ? "Update Employee" : "Save Employee"}</button>
          </div>
        </form>
      )}

      <section className="panel">
        <div className="toolbar">
          <div>
            <h2>Employee List</h2>
            <p>{filtered.length} employees shown</p>
          </div>
          <input className="search-input" placeholder="Search employees..." value={search} onChange={(e) => setSearch(e.target.value)} />
        </div>

        <div className="table-wrap">
          <table>
            <thead><tr><th>ID</th><th>Employee</th><th>Department</th><th>Role</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
              {filtered.map((employee) => (
                <tr key={employee.id}>
                  <td>#{employee.id}</td>
                  <td><div className="employee-cell"><span className="avatar">{employee.name.charAt(0)}</span><div><strong>{employee.name}</strong><small>{employee.email}</small></div></div></td>
                  <td>{employee.department}</td>
                  <td>{employee.role}</td>
                  <td><span className={`status ${employee.status === "Active" ? "active-status" : "leave-status"}`}>{employee.status}</span></td>
                  <td><div className="action-buttons"><button onClick={() => edit(employee)}>Edit</button><button className="danger" onClick={() => remove(employee.id)}>Delete</button></div></td>
                </tr>
              ))}
            </tbody>
          </table>
          {filtered.length === 0 && <div className="empty-state">No employees found.</div>}
        </div>
      </section>
    </div>
  );
}