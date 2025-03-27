import React, { useState, useEffect } from 'react';
import { UsersApi, Configuration } from '../api';
import { useAuth } from '../contexts/AuthContext';

interface UserDetailProps {
  userId: string;
  onBack: () => void;
  onEdit?: (userId: string) => void;
}

const UserDetail: React.FC<UserDetailProps> = ({ userId, onBack, onEdit }) => {
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const [role, setRole] = useState<string>('');
  const [status, setStatus] = useState<string>('');
  const [updateMessage, setUpdateMessage] = useState<string | null>(null);
  const { token } = useAuth();

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const configuration = new Configuration({
          basePath: 'http://localhost:9090/api/v1',
          accessToken: token || undefined
        });
        const api = new UsersApi(configuration);

        const response = await api.usersIdGet(userId);
        setUser(response.data);
        setRole(response.data.role || '');
        setStatus(response.data.status || '');
        setLoading(false);
      } catch (err) {
        console.error('Error fetching user:', err);
        setError('Failed to fetch user details. Please try again later.');
        setLoading(false);
      }
    };

    fetchUser();
  }, [userId, token]);

  const handleRoleUpdate = async () => {
    try {
      const configuration = new Configuration({
        basePath: 'http://localhost:9090/api/v1',
        accessToken: token || undefined
      });
      const api = new UsersApi(configuration);

      const response = await api.usersIdRolePut(userId, { role });
      setUser(response.data);
      setUpdateMessage('Role updated successfully');
      setTimeout(() => setUpdateMessage(null), 3000);
    } catch (err) {
      console.error('Error updating role:', err);
      setError('Failed to update role. Please try again later.');
    }
  };

  const handleStatusUpdate = async () => {
    try {
      const configuration = new Configuration({
        basePath: 'http://localhost:9090/api/v1',
        accessToken: token || undefined
      });
      const api = new UsersApi(configuration);

      const response = await api.usersIdStatusPut(userId, { status });
      setUser(response.data);
      setUpdateMessage('Status updated successfully');
      setTimeout(() => setUpdateMessage(null), 3000);
    } catch (err) {
      console.error('Error updating status:', err);
      setError('Failed to update status. Please try again later.');
    }
  };

  if (loading) {
    return <div className="loading">Loading user details...</div>;
  }

  if (error) {
    return (
      <div>
        <div className="error">{error}</div>
        <button onClick={onBack} className="button">Back to User List</button>
      </div>
    );
  }

  if (!user) {
    return (
      <div>
        <div className="card">User not found.</div>
        <button onClick={onBack} className="button">Back to User List</button>
      </div>
    );
  }

  return (
    <div className="user-detail">
      <h2 className="card-title">User Details</h2>
      {updateMessage && <div className="success-message">{updateMessage}</div>}
      <div className="card">
        <h3>{user.username}</h3>
        <p>Email: {user.email}</p>
        <p>ID: {user.id}</p>

        <div className="form-group">
          <label htmlFor="role">Role:</label>
          <select 
            id="role" 
            value={role} 
            onChange={(e) => setRole(e.target.value)}
          >
            <option value="user">User</option>
            <option value="admin">Admin</option>
          </select>
          <button onClick={handleRoleUpdate} className="button">Update Role</button>
        </div>

        <div className="form-group">
          <label htmlFor="status">Status:</label>
          <select 
            id="status" 
            value={status} 
            onChange={(e) => setStatus(e.target.value)}
          >
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
            <option value="locked">Locked</option>
          </select>
          <button onClick={handleStatusUpdate} className="button">Update Status</button>
        </div>
      </div>
      <div className="button-group">
        <button onClick={onBack} className="button">Back to User List</button>
        {onEdit && (
          <button onClick={() => onEdit(userId)} className="button">Edit User</button>
        )}
      </div>
    </div>
  );
};

export default UserDetail;
