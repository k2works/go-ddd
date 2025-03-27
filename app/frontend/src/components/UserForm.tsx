import React, { useState, useEffect } from 'react';
import { UsersApi, Configuration } from '../api';
import { useAuth } from '../contexts/AuthContext';

interface UserFormProps {
  userId?: string;
  onSuccess: () => void;
  onCancel: () => void;
}

const UserForm: React.FC<UserFormProps> = ({ userId, onSuccess, onCancel }) => {
  const [username, setUsername] = useState<string>('');
  const [email, setEmail] = useState<string>('');
  const [password, setPassword] = useState<string>('');
  const [role, setRole] = useState<string>('user');
  const [status, setStatus] = useState<string>('active');
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [isEdit, setIsEdit] = useState<boolean>(false);
  const { token } = useAuth();

  useEffect(() => {
    if (userId) {
      setIsEdit(true);
      fetchUser();
    }
  }, [userId]);

  const fetchUser = async () => {
    if (!userId) return;

    try {
      setLoading(true);
      const configuration = new Configuration({
        basePath: 'http://localhost:9090/api/v1',
        accessToken: token || undefined
      });
      const api = new UsersApi(configuration);

      const response = await api.usersIdGet(userId);
      const userData = response.data;

      setUsername(userData.username || '');
      setEmail(userData.email || '');
      setRole(userData.role || 'user');
      setStatus(userData.status || 'active');
      setLoading(false);
    } catch (err) {
      console.error('Error fetching user:', err);
      setError('Failed to fetch user details. Please try again later.');
      setLoading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    try {
      setLoading(true);
      const configuration = new Configuration({
        basePath: 'http://localhost:9090/api/v1',
        accessToken: token || undefined
      });
      const api = new UsersApi(configuration);

      if (isEdit) {
        // Update existing user
        await api.usersIdPut(userId!, {
          username,
          email,
          password: password || undefined
        });
      } else {
        // Create new user
        await api.usersPost({
          username,
          email,
          password,
          role,
          status
        });
      }

      setLoading(false);
      onSuccess();
    } catch (err) {
      console.error('Error saving user:', err);
      setError('Failed to save user. Please try again later.');
      setLoading(false);
    }
  };

  if (loading && isEdit) {
    return <div className="loading">Loading user data...</div>;
  }

  return (
    <div className="user-form">
      <h2 className="card-title">{isEdit ? 'Edit User' : 'Create User'}</h2>
      {error && <div className="error">{error}</div>}

      <form onSubmit={handleSubmit} className="card">
        <div className="form-group">
          <label htmlFor="username">Username:</label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="email">Email:</label>
          <input
            type="email"
            id="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="password">
            Password{isEdit ? ' (leave blank to keep current)' : ''}:
          </label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required={!isEdit}
          />
        </div>

        {!isEdit && (
          <>
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
            </div>
          </>
        )}

        <div className="form-actions">
          <button type="submit" className="button" disabled={loading}>
            {loading ? 'Saving...' : 'Save'}
          </button>
          <button type="button" className="button button-secondary" onClick={onCancel}>
            Cancel
          </button>
        </div>
      </form>
    </div>
  );
};

export default UserForm;
