import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link, Navigate } from 'react-router-dom';
import ProductList from './ProductList';
import ProductForm from './ProductForm';
import Login from './Login';
import Register from './Register';
import Profile from './Profile';
import UserManagement from './UserManagement';
import { useAuth } from '../contexts/AuthContext';

// Protected route component
const ProtectedRoute: React.FC<{ element: React.ReactNode }> = ({ element }) => {
  const { isAuthenticated, loading } = useAuth();

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  return isAuthenticated ? <>{element}</> : <Navigate to="/login" />;
};

// Admin route component
const AdminRoute: React.FC<{ element: React.ReactNode }> = ({ element }) => {
  const { isAuthenticated, user, loading } = useAuth();

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  return isAuthenticated && user?.role === 'admin' ? <>{element}</> : <Navigate to="/" />;
};

const App: React.FC = () => {
  const { isAuthenticated, loading } = useAuth();

  return (
    <Router>
      <div className="app-container">
        <header className="app-header">
          <h1>Marketplace Client</h1>
          <nav className="app-nav">
            <Link to="/" className="nav-link">Products List</Link>
            <Link to="/products/create" className="nav-link">Create Product</Link>
            {isAuthenticated ? (
              <>
                <Link to="/profile" className="nav-link">Profile</Link>
                {/* Only show User Management link for admin users */}
                <Link to="/users" className="nav-link">User Management</Link>
              </>
            ) : (
              <>
                <Link to="/login" className="nav-link">Login</Link>
                <Link to="/register" className="nav-link">Register</Link>
              </>
            )}
          </nav>
        </header>
        <main className="app-content">
          {loading ? (
            <div className="loading">Loading...</div>
          ) : (
            <Routes>
              <Route path="/" element={<ProductList />} />
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />
              <Route path="/products/create" element={<ProtectedRoute element={<ProductForm />} />} />
              <Route path="/profile" element={<ProtectedRoute element={<Profile />} />} />
              <Route path="/users/*" element={<AdminRoute element={<UserManagement />} />} />
            </Routes>
          )}
        </main>
        <footer className="app-footer">
          <p>Marketplace Client - Powered by Electron, React, and TypeScript</p>
        </footer>
      </div>
    </Router>
  );
};

export default App;
