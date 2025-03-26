import React, { useState, useEffect } from 'react';
import { ProductsApi, ResponseProductResponse, Configuration } from '../api';

const ProductList: React.FC = () => {
  const [products, setProducts] = useState<ResponseProductResponse[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const configuration = new Configuration({
          basePath: 'http://localhost:9090/api/v1',
        });
        const api = new ProductsApi(configuration);

        const response = await api.productsGet();
        setProducts(response.data);
        setLoading(false);
      } catch (err) {
        console.error('Error fetching products:', err);
        setError('Failed to fetch products. Please try again later.');
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  if (loading) {
    return <div className="loading">Loading products...</div>;
  }

  if (error) {
    return <div className="error">{error}</div>;
  }

  if (products.length === 0) {
    return <div className="card">No products found.</div>;
  }

  return (
    <div>
      <h2 className="card-title">Products</h2>
      <div className="product-list">
        {products.map((product) => (
          <div key={product.id} className="card product-card">
            <h3>{product.name}</h3>
            <p className="product-price">${product.price?.toFixed(2) || '0.00'}</p>
            <p>Created: {new Date(product.createdAt || '').toLocaleDateString()}</p>
            <p>Updated: {new Date(product.updatedAt || '').toLocaleDateString()}</p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ProductList;
