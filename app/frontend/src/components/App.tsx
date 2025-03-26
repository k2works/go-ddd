import React, { useState, useEffect } from 'react';
import ProductList from './ProductList';
import ProductForm from './ProductForm';
import Login from './Login';
import Register from './Register';
import Profile from './Profile';
import { useAuth } from '../contexts/AuthContext';

type Tab = 'list' | 'create' | 'login' | 'register' | 'profile';

const App: React.FC = () => {
  const [activeTab, setActiveTab] = useState<Tab>('list');
  const { isAuthenticated, user, loading } = useAuth();

  // Redirect to login if not authenticated and trying to access protected tabs
  useEffect(() => {
    if (!isAuthenticated && (activeTab === 'create' || activeTab === 'profile')) {
      setActiveTab('login');
    }
  }, [isAuthenticated, activeTab]);

  return (
    <div className="app-container">
      <header className="app-header">
        <h1>Marketplace Client</h1>
        <nav className="app-nav">
          <button 
            className={activeTab === 'list' ? 'active' : ''} 
            onClick={() => setActiveTab('list')}
          >
            Products List
          </button>
          <button 
            className={activeTab === 'create' ? 'active' : ''} 
            onClick={() => setActiveTab('create')}
          >
            Create Product
          </button>
          {isAuthenticated ? (
            <button 
              className={activeTab === 'profile' ? 'active' : ''} 
              onClick={() => setActiveTab('profile')}
            >
              Profile
            </button>
          ) : (
            <>
              <button 
                className={activeTab === 'login' ? 'active' : ''} 
                onClick={() => setActiveTab('login')}
              >
                Login
              </button>
              <button 
                className={activeTab === 'register' ? 'active' : ''} 
                onClick={() => setActiveTab('register')}
              >
                Register
              </button>
            </>
          )}
        </nav>
      </header>
      <main className="app-content">
        {loading ? (
          <div className="loading">Loading...</div>
        ) : (
          <>
            {activeTab === 'list' && <ProductList />}
            {activeTab === 'create' && (isAuthenticated ? <ProductForm /> : <Login />)}
            {activeTab === 'login' && <Login />}
            {activeTab === 'register' && <Register />}
            {activeTab === 'profile' && <Profile />}
          </>
        )}
      </main>
      <footer className="app-footer">
        <p>Marketplace Client - Powered by Electron, React, and TypeScript</p>
      </footer>
    </div>
  );
};

export default App;
