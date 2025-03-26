import React from 'react';
import { useAuth } from '../contexts/AuthContext';

const Profile: React.FC = () => {
  const { user, logout, loading } = useAuth();

  if (loading) {
    return <div className="loading">Loading profile...</div>;
  }

  if (!user) {
    return <div className="error-message">You must be logged in to view this page.</div>;
  }

  return (
    <div className="profile-container">
      <h2>User Profile</h2>
      <div className="profile-info">
        <div className="profile-field">
          <strong>User ID:</strong> {user.id}
        </div>
        <div className="profile-field">
          <strong>Email:</strong> {user.email}
        </div>
      </div>
      <button onClick={logout} className="auth-button logout-button">
        Logout
      </button>
    </div>
  );
};

export default Profile;