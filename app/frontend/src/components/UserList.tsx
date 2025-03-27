import React, { useState, useEffect } from 'react';
import { UsersApi, Configuration } from '../api';
import { useAuth } from '../contexts/AuthContext';

interface UserListProps {
  onUserSelect?: (userId: string) => void;
}

const UserList: React.FC<UserListProps> = ({ onUserSelect }) => {
  const [users, setUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { token } = useAuth();

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const configuration = new Configuration({
          basePath: 'http://localhost:9090/api/v1',
          accessToken: token || undefined
        });
        const api = new UsersApi(configuration);

        const response = await api.usersGet();
        setUsers(response.data);
        setLoading(false);
      } catch (err) {
        console.error('Error fetching users:', err);
        setError('Failed to fetch users. Please try again later.');
        setLoading(false);
      }
    };

    fetchUsers();
  }, [token]);

  if (loading) {
    return <div className="loading">Loading users...</div>;
  }

  if (error) {
    return <div className="error">{error}</div>;
  }

  if (users.length === 0) {
    return <div className="card">No users found.</div>;
  }

  return (
    <div>
      <h2 className="card-title">Users</h2>
      <div className="user-list">
        {users.map((user) => (
          <div 
            key={user.id} 
            className="card user-card"
            onClick={() => onUserSelect && onUserSelect(user.id)}
            style={{ cursor: onUserSelect ? 'pointer' : 'default' }}
          >
            <h3>{user.username}</h3>
            <p>Email: {user.email}</p>
            <p>Role: {user.role}</p>
            <p>Status: {user.status}</p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default UserList;
