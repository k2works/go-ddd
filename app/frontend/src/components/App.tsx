import React, { useState, useEffect } from 'react';
import ProductList from './ProductList';
import ProductForm from './ProductForm';

const App: React.FC = () => {
  const [activeTab, setActiveTab] = useState<'list' | 'create'>('list');

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
        </nav>
      </header>
      <main className="app-content">
        {activeTab === 'list' ? (
          <ProductList />
        ) : (
          <ProductForm />
        )}
      </main>
      <footer className="app-footer">
        <p>Marketplace Client - Powered by Electron, React, and TypeScript</p>
      </footer>
    </div>
  );
};

export default App;