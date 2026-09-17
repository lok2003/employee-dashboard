import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { api } from "../api";

const statItems = [["totalEmployees", "Total Employees", "♙"], ["activeEmployees", "Active Employees", "✓"], ["departments", "Departments", "▦"], ["onLeave", "On Leave", "◷"]];

export default function Dashboard() {
  const [data, setData] = useState({ stats: {}, recent: [], departments: [] });
  const [error, setError] = useState("");
  useEffect(() => { api.dashboard().then(setData).catch((requestError) => setError(requestError.message)); }, []);
  return <div><div className="page-header"><div><p className="eyebrow">OVERVIEW</p><h1>Dashboard</h1><p>Live data from the employee API.</p></div><Link className="primary-button" to="/employees">+ Add Employee</Link></div>{error && <div className="form-error">{error}</div>}
    <section className="stats-grid">{statItems.map(([key, label, icon]) => <div className="stat-card" key={label}><div className="stat-top"><span className="stat-icon">{icon}</span></div><h2>{data.stats[key] ?? "-"}</h2><p>{label}</p></div>)}</section>
    <section className="dashboard-grid"><div className="panel large-panel"><div className="panel-heading"><div><h2>Recent Employees</h2><p>Latest employee records</p></div><Link to="/employees">View all →</Link></div><div className="table-wrap"><table><thead><tr><th>Employee</th><th>Department</th><th>Role</th><th>Status</th></tr></thead><tbody>{data.recent.map((employee) => <tr key={employee.id}><td><strong>{employee.name}</strong></td><td>{employee.department}</td><td>{employee.role}</td><td><span className={`status ${employee.status === "Active" ? "active-status" : "leave-status"}`}>{employee.status}</span></td></tr>)}</tbody></table>{!data.recent.length && <div className="empty-state">Loading employees...</div>}</div></div>
      <div className="panel"><div className="panel-heading"><div><h2>Departments</h2><p>Employee distribution</p></div></div><div className="department-list">{data.departments.map((department) => <div className="department-row" key={department.name}><div><span>{department.name}</span><strong>{department.count}</strong></div><div className="progress"><span style={{ width: `${Math.min(department.count * 2, 100)}%` }} /></div></div>)}</div></div></section>
  </div>;
}
