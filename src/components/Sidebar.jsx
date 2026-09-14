import { NavLink } from "react-router-dom";

const links = [
  { to: "/dashboard", icon: "⌂", label: "Dashboard" },
  { to: "/employees", icon: "♙", label: "Employees" },
  { to: "/profile", icon: "◉", label: "Profile" }
];

export default function Sidebar({ open, onClose, onLogout }) {
  return (
    <>
      {open && <div className="sidebar-overlay" onClick={onClose} />}
      <aside className={`sidebar ${open ? "open" : ""}`}>
        <div className="sidebar-title">
          <div className="logo-mark">E</div>
          <div>
            <strong>EmployeeHub</strong>
            <small>Management Portal</small>
          </div>
        </div>

        <nav>
          <p className="nav-heading">MAIN MENU</p>
          {links.map((link) => (
            <NavLink
              key={link.to}
              to={link.to}
              onClick={onClose}
              className={({ isActive }) => `side-link ${isActive ? "active" : ""}`}
            >
              <span className="side-icon">{link.icon}</span>
              {link.label}
            </NavLink>
          ))}
        </nav>

        <div className="sidebar-bottom">
          <button className="side-link logout-side" onClick={onLogout}>
            <span className="side-icon">↪</span>
            Logout
          </button>
        </div>
      </aside>
    </>
  );
}