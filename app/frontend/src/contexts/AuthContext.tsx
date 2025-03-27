import React, { createContext, useState, useContext, useEffect, ReactNode } from 'react';
import { AuthApi, User } from '../api/auth';
import { Configuration } from '../api/configuration';
import { setToken, getToken, removeToken } from '../utils/auth';

// Define the context type
interface AuthContextType {
  user: User | null;
  loading: boolean;
  error: string | null;
  login: (email: string, password: string) => Promise<void>;
  register: (email: string, password: string) => Promise<void>;
  logout: () => void;
  isAuthenticated: boolean;
  token: string | null;
}

// Create the context with a default value
const AuthContext = createContext<AuthContextType>({
  user: null,
  loading: false,
  error: null,
  login: async () => {},
  register: async () => {},
  logout: () => {},
  isAuthenticated: false,
  token: null,
});

// Custom hook to use the auth context
export const useAuth = () => useContext(AuthContext);

interface AuthProviderProps {
  children: ReactNode;
}

// Provider component
export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false);
  const [token, setAuthToken] = useState<string | null>(null);

  // Initialize API client
  const configuration = new Configuration({
    basePath: 'http://localhost:9090/api/v1',
  });
  const authApi = new AuthApi(configuration);

  // Check if user is already logged in on mount
  useEffect(() => {
    const initAuth = async () => {
      const storedToken = getToken();
      if (storedToken) {
        try {
          setAuthToken(storedToken);
          const response = await authApi.getProfile(storedToken);
          setUser(response.data.user);
          setIsAuthenticated(true);
        } catch (error) {
          console.error('Failed to get user profile:', error);
          removeToken();
          setAuthToken(null);
        }
      }
      setLoading(false);
    };

    initAuth();
  }, []);

  // Login function
  const login = async (email: string, password: string) => {
    setLoading(true);
    setError(null);
    try {
      const response = await authApi.login({ email, password });
      const { user, token } = response.data;
      setToken(token);
      setAuthToken(token);
      setUser(user);
      setIsAuthenticated(true);
    } catch (error) {
      console.error('Login failed:', error);
      setError('Invalid credentials');
      throw error;
    } finally {
      setLoading(false);
    }
  };

  // Register function
  const register = async (email: string, password: string) => {
    setLoading(true);
    setError(null);
    try {
      const response = await authApi.register({ email, password });
      const { user, token } = response.data;
      setToken(token);
      setAuthToken(token);
      setUser(user);
      setIsAuthenticated(true);
    } catch (error) {
      console.error('Registration failed:', error);
      setError('Registration failed');
      throw error;
    } finally {
      setLoading(false);
    }
  };

  // Logout function
  const logout = () => {
    removeToken();
    setAuthToken(null);
    setUser(null);
    setIsAuthenticated(false);
  };

  // Context value
  const value = {
    user,
    loading,
    error,
    login,
    register,
    logout,
    isAuthenticated,
    token,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};
