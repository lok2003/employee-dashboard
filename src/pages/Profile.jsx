import { useState } from "react";

export default function Profile() {
  const [profile, setProfile] = useState({
    firstName: "Admin",
    lastName: "User",
    email: "admin@example.com",
    phone: "+91 98765 43210",
    department: "Administration",
    role: "Administrator"
  });
  const [saved, setSaved] = useState(false);

  const update = (e) => {
    setSaved(false);
    setProfile({ ...profile, [e.target.name]: e.target.value });
  };

  const save = (e) => {
    e.preventDefault();
    setSaved(true);
  };

  return (
    <div>
      <div className="page-header">
        <div>
          <p className="eyebrow">ACCOUNT</p>
          <h1>My Profile</h1>
          <p>View and update your account information.</p>
        </div>
      </div>

      <div className="profile-grid">
        <section className="panel profile-card">
          <span className="avatar profile-avatar">A</span>
          <h2>{profile.firstName} {profile.lastName}</h2>
          <p>{profile.role}</p>
          <span className="status active-status">Active</span>
          <div className="profile-meta">
            <div><span>Department</span><strong>{profile.department}</strong></div>
            <div><span>Email</span><strong>{profile.email}</strong></div>
          </div>
        </section>

        <form className="panel profile-form" onSubmit={save}>
          <div className="panel-heading"><div><h2>Personal Information</h2><p>Keep your profile details up to date.</p></div></div>
          <div className="form-grid">
            <div><label>First name</label><input name="firstName" value={profile.firstName} onChange={update} /></div>
            <div><label>Last name</label><input name="lastName" value={profile.lastName} onChange={update} /></div>
            <div><label>Email</label><input name="email" type="email" value={profile.email} onChange={update} /></div>
            <div><label>Phone</label><input name="phone" value={profile.phone} onChange={update} /></div>
            <div><label>Department</label><input name="department" value={profile.department} onChange={update} /></div>
            <div><label>Role</label><input name="role" value={profile.role} onChange={update} /></div>
          </div>
          <div className="form-actions">
            {saved && <span className="save-message">✓ Changes saved</span>}
            <button className="primary-button">Save Changes</button>
          </div>
        </form>
      </div>
    </div>
  );
}