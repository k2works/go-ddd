import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './components/App';
import { AuthProvider } from './contexts/AuthContext';
import './styles/global.css';
import './styles/auth.css';

// Create root element
const rootElement = document.getElementById('root');
if (!rootElement) throw new Error('Failed to find the root element');
const root = createRoot(rootElement);

// Render the App component
root.render(
  <React.StrictMode>
    <AuthProvider>
      <App />
    </AuthProvider>
  </React.StrictMode>
);
