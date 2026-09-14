import { Link } from "react-router-dom";

const stats = [
  { label: "Total Employees", value: "128", change: "+8.2%", icon: "♙" },
  { label: "Active Employees", value: "116", change: "+5.4%", icon: "✓" },
  { label: "Departments", value: "12", change: "+1", icon: "▦" },
  { label: "On Leave", value: "12", change: "-2.1%", icon: "◷" }
];

const recent = [
  ["Arjun Kumar", "Engineering", "Software Engineer", "Active"],
  ["Priya Sharma", "HR", "HR Manager", "Active"],
  ["Rahul Reddy", "Finance", "Accountant", "On Leave"],
  ["Sneha Rao", "Design", "UI/UX Designer", "Active"],
  ["Vikram Singh", "Marketing", "Marketing Executive", "Active"]
];

export default function Dashboard() {
  return (
    <div>
      <div className="page-header">
        <div>
          <p className="eyebrow">OVERVIEW</p>
          <h1>Dashboard</h1>
          <p>Here is what is happening across your organization today.</p>
        </div>
        <Link className="primary-button" to="/employees">+ Add Employee</Link>
      </div>

      <section className="stats-grid">
        {stats.map((stat) => (
          <div className="stat-card" key={stat.label}>
            <div className="stat-top">
              <span className="stat-icon">{stat.icon}</span>
              <span className={`change ${stat.change.startsWith("-") ? "negative" : ""}`}>{stat.change}</span>
            </div>
            <h2>{stat.value}</h2>
            <p>{stat.label}</p>
          </div>
        ))}
      </section>

      <section className="dashboard-grid">
        <div className="panel large-panel">
          <div className="panel-heading">
            <div>
              <h2>Recent Employees</h2>
              <p>Latest employee records</p>
            </div>
            <Link to="/employees">View all →</Link>
          </div>
          <div className="table-wrap">
            <table>
              <thead>
                <tr><th>Employee</th><th>Department</th><th>Role</th><th>Status</th></tr>
              </thead>
              <tbody>
                {recent.map(([name, dept, role, status]) => (
                  <tr key={name}>
                    <td><strong>{name}</strong></td>
                    <td>{dept}</td>
                    <td>{role}</td>
                    <td><span className={`status ${status === "Active" ? "active-status" : "leave-status"}`}>{status}</span></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        <div className="panel">
          <div className="panel-heading">
            <div><h2>Departments</h2><p>Employee distribution</p></div>
          </div>
          <div className="department-list">
            {[
              ["Engineering", 42],
              ["Sales", 25],
              ["HR", 18],
              ["Finance", 16],
              ["Design", 15]
            ].map(([name, count]) => (
              <div className="department-row" key={name}>
                <div><span>{name}</span><strong>{count}</strong></div>
                <div className="progress"><span style={{ width: `${count}%` }} /></div>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}