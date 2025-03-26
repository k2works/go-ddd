import React, { useState } from 'react';
import { ProductsApi, Configuration } from '../api';
import { useAuth } from '../contexts/AuthContext';
import { getToken } from '../utils/auth';

interface ProductFormData {
  name: string;
  description: string;
  price: string;
  sellerId: string;
}

const ProductForm: React.FC = () => {
  const { isAuthenticated } = useAuth();
  const [formData, setFormData] = useState<ProductFormData>({
    name: '',
    description: '',
    price: '',
    sellerId: '',
  });
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<boolean>(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    setSuccess(false);

    try {
      // Get authentication token
      const token = getToken();
      if (!token) {
        throw new Error('Authentication required to create products');
      }

      const configuration = new Configuration({
        basePath: 'http://localhost:9090/api/v1',
        accessToken: token
      });
      const api = new ProductsApi(configuration);

      // Convert price to number and validate
      const price = parseFloat(formData.price);
      if (isNaN(price) || price <= 0) {
        throw new Error('Price must be a positive number');
      }

      // Note: The API might expect a different request format
      // This is a simplified example and may need adjustment based on the actual API
      await api.productsPost({
        data: {
          name: formData.name,
          price: price
        }
      });

      setSuccess(true);
      setFormData({
        name: '',
        description: '',
        price: '',
        sellerId: '',
      });
    } catch (err) {
      console.error('Error creating product:', err);
      setError(err instanceof Error ? err.message : 'Failed to create product. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="card">
      <h2 className="card-title">Create New Product</h2>
      {success && (
        <div className="success-message">
          Product created successfully!
        </div>
      )}
      {error && <div className="error">{error}</div>}
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label htmlFor="name">Product Name</label>
          <input
            type="text"
            id="name"
            name="name"
            value={formData.name}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label htmlFor="description">Description</label>
          <textarea
            id="description"
            name="description"
            value={formData.description}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label htmlFor="price">Price ($)</label>
          <input
            type="number"
            id="price"
            name="price"
            value={formData.price}
            onChange={handleChange}
            step="0.01"
            min="0.01"
            required
          />
        </div>
        <div className="form-group">
          <label htmlFor="sellerId">Seller ID</label>
          <input
            type="text"
            id="sellerId"
            name="sellerId"
            value={formData.sellerId}
            onChange={handleChange}
            required
          />
        </div>
        <button type="submit" disabled={loading}>
          {loading ? 'Creating...' : 'Create Product'}
        </button>
      </form>
    </div>
  );
};

export default ProductForm;
