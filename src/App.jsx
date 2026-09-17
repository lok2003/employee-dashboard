import { useState } from "react";
import { Navigate, Route, Routes } from "react-router-dom";
import Navbar from "./components/Navbar";
import Sidebar from "./components/Sidebar";
import Login from "./pages/Login";
import Dashboard from "./pages/Dashboard";
import Employees from "./pages/Employees";
import Profile from "./pages/Profile";

function ProtectedLayout({ onLogout }) {
  const [sidebarOpen, setSidebarOpen] = useState(false);

  return (
    <div className="app-shell">
      <Sidebar open={sidebarOpen} onClose={() => setSidebarOpen(false)} onLogout={onLogout} />
      <div className="main-area">
        <Navbar onMenu={() => setSidebarOpen(true)} onLogout={onLogout} />
        <main className="page-content">
          <Routes>
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/employees" element={<Employees />} />
            <Route path="/profile" element={<Profile />} />
            <Route path="*" element={<Navigate to="/dashboard" replace />} />
          </Routes>
        </main>
      </div>
    </div>
  );
}

export default function App() {
  const [loggedIn, setLoggedIn] = useState(
    () => Boolean(localStorage.getItem("employeeDashboardToken"))
  );

  const login = (session) => {
    localStorage.setItem("employeeDashboardToken", session.access_token);
    localStorage.setItem("employeeDashboardUser", JSON.stringify(session.user));
    setLoggedIn(true);
  };

  const logout = () => {
    localStorage.removeItem("employeeDashboardToken");
    localStorage.removeItem("employeeDashboardUser");
    setLoggedIn(false);
  };

  if (!loggedIn) {
    return (
      <Routes>
        <Route path="*" element={<Login onLogin={login} />} />
      </Routes>
    );
  }

  return <ProtectedLayout onLogout={logout} />;
}