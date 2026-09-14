import { Link } from "react-router-dom";

export default function Navbar({ onMenu, onLogout }) {
  return (
    <header className="navbar">
      <button className="menu-button" onClick={onMenu} aria-label="Open menu">☰</button>
      <Link to="/dashboard" className="brand">Employee<span>Hub</span></Link>

      <div className="nav-actions">
        <Link to="/profile" className="user-chip">
          <span className="avatar small">A</span>
          <span className="user-name">Admin User</span>
        </Link>
        <button className="logout-button" onClick={onLogout}>Logout</button>
      </div>
    </header>
  );
}