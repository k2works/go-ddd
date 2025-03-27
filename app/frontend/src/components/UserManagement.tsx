import React, { useState } from 'react';
import UserList from './UserList';
import UserDetail from './UserDetail';
import UserForm from './UserForm';
import { useAuth } from '../contexts/AuthContext';

type View = 'list' | 'detail' | 'create' | 'edit';

const UserManagement: React.FC = () => {
  const [view, setView] = useState<View>('list');
  const [selectedUserId, setSelectedUserId] = useState<string | null>(null);
  const { user } = useAuth();

  // Check if user is admin
  const isAdmin = user?.role === 'admin';

  if (!isAdmin) {
    return (
      <div className="card">
        <h2>Access Denied</h2>
        <p>You need administrator privileges to access user management.</p>
      </div>
    );
  }

  const handleUserSelect = (userId: string) => {
    setSelectedUserId(userId);
    setView('detail');
  };

  const handleCreateUser = () => {
    setSelectedUserId(null);
    setView('create');
  };

  const handleEditUser = (userId: string) => {
    setSelectedUserId(userId);
    setView('edit');
  };

  const handleBackToList = () => {
    setView('list');
    setSelectedUserId(null);
  };

  const handleUserSaved = () => {
    setView('list');
    setSelectedUserId(null);
  };

  return (
    <div className="user-management">
      {view === 'list' && (
        <>
          <div className="actions">
            <button onClick={handleCreateUser} className="button">
              Create New User
            </button>
          </div>
          <UserList onUserSelect={handleUserSelect} />
        </>
      )}

      {view === 'detail' && selectedUserId && (
        <UserDetail 
          userId={selectedUserId} 
          onBack={handleBackToList}
          onEdit={() => handleEditUser(selectedUserId)}
        />
      )}

      {view === 'create' && (
        <UserForm
          onSuccess={handleUserSaved}
          onCancel={handleBackToList}
        />
      )}

      {view === 'edit' && selectedUserId && (
        <UserForm
          userId={selectedUserId}
          onSuccess={handleUserSaved}
          onCancel={handleBackToList}
        />
      )}
    </div>
  );
};

export default UserManagement;