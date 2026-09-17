import { useState } from "react";
import { api } from "../api";

export default function Login({ onLogin }) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const submit = async (e) => {
    e.preventDefault();
    setError("");

    if (!email.trim() || !password.trim()) {
      setError("Please enter both email and password.");
      return;
    }

    setLoading(true);
    try {
      onLogin(await api.login(email.trim(), password));
    } catch (requestError) {
      setError(requestError.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-page">
      <div className="login-decoration decoration-one" />
      <div className="login-decoration decoration-two" />

      <form className="login-card" onSubmit={submit}>
        <div className="login-logo">E</div>
        <p className="eyebrow">EMPLOYEE MANAGEMENT</p>
        <h1>Welcome back</h1>
        <p className="login-subtitle">Sign in to access your dashboard.</p>

        <label>Email address</label>
        <input
          type="email"
          placeholder="admin@example.com"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />

        <div className="password-label">
          <label>Password</label>
          <button type="button" onClick={() => setShowPassword(!showPassword)}>
            {showPassword ? "Hide" : "Show"}
          </button>
        </div>
        <input
          type={showPassword ? "text" : "password"}
          placeholder="Enter your password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />

        {error && <div className="form-error">{error}</div>}

        <button className="primary-button login-button" type="submit" disabled={loading}>{loading ? "Signing in..." : "Sign in"}</button>
        <p className="demo-note">Demo account: admin@example.com / 123456</p>
      </form>
    </div>
  );
}