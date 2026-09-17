import { useEffect, useState } from "react";
import { api } from "../api";

const emptyProfile = { firstName: "", lastName: "", email: "", phone: "", department: "", role: "", status: "Active" };

export default function Profile() {
  const [profile, setProfile] = useState(emptyProfile); const [saved, setSaved] = useState(false); const [error, setError] = useState("");
  useEffect(() => { api.profile().then(setProfile).catch((requestError) => setError(requestError.message)); }, []);
  const update = (event) => { setSaved(false); setProfile({ ...profile, [event.target.name]: event.target.value }); };
  const save = async (event) => { event.preventDefault(); setError(""); try { setProfile(await api.updateProfile(profile)); setSaved(true); } catch (requestError) { setError(requestError.message); } };
  return <div><div className="page-header"><div><p className="eyebrow">ACCOUNT</p><h1>My Profile</h1><p>Profile data is loaded from the Python API.</p></div></div>{error && <div className="form-error">{error}</div>}<div className="profile-grid"><section className="panel profile-card"><span className="avatar profile-avatar">{profile.firstName.charAt(0) || "A"}</span><h2>{profile.firstName} {profile.lastName}</h2><p>{profile.role}</p><span className="status active-status">{profile.status}</span><div className="profile-meta"><div><span>Department</span><strong>{profile.department}</strong></div><div><span>Email</span><strong>{profile.email}</strong></div></div></section><form className="panel profile-form" onSubmit={save}><div className="panel-heading"><div><h2>Personal Information</h2><p>Keep your profile details up to date.</p></div></div><div className="form-grid">{[["firstName", "First name"], ["lastName", "Last name"], ["email", "Email"], ["phone", "Phone"], ["department", "Department"], ["role", "Role"]].map(([name, label]) => <div key={name}><label>{label}</label><input name={name} type={name === "email" ? "email" : "text"} value={profile[name]} onChange={update} required /></div>)}</div><div className="form-actions">{saved && <span className="save-message">✓ Changes saved</span>}<button className="primary-button">Save Changes</button></div></form></div></div>;
}
