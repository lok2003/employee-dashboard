const API_BASE = import.meta.env.VITE_API_URL || "/api";

async function request(path, options = {}) {
  const token = localStorage.getItem("employeeDashboardToken");
  const headers = { "Content-Type": "application/json", ...options.headers };
  if (token) headers.Authorization = `Bearer ${token}`;
  const response = await fetch(`${API_BASE}${path}`, { ...options, headers });
  if (!response.ok) {
    const body = await response.json().catch(() => ({}));
    throw new Error(body.detail || "The request could not be completed.");
  }
  return response.status === 204 ? null : response.json();
}

export const api = {
  login: (email, password) => request("/auth/login", { method: "POST", body: JSON.stringify({ email, password }) }),
  dashboard: () => request("/dashboard"),
  employees: () => request("/employees"),
  createEmployee: (employee) => request("/employees", { method: "POST", body: JSON.stringify(employee) }),
  updateEmployee: (id, employee) => request(`/employees/${id}`, { method: "PUT", body: JSON.stringify(employee) }),
  deleteEmployee: (id) => request(`/employees/${id}`, { method: "DELETE" }),
  profile: () => request("/profile"),
  updateProfile: (profile) => request("/profile", { method: "PUT", body: JSON.stringify(profile) })
};
