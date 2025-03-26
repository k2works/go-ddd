// Token storage and management utilities

/**
 * Store authentication token in localStorage
 * @param token - JWT token
 */
export const setToken = (token: string): void => {
  localStorage.setItem('auth_token', token);
};

/**
 * Get authentication token from localStorage
 * @returns JWT token or null if not found
 */
export const getToken = (): string | null => {
  return localStorage.getItem('auth_token');
};

/**
 * Remove authentication token from localStorage
 */
export const removeToken = (): void => {
  localStorage.removeItem('auth_token');
};

/**
 * Check if user is authenticated (token exists)
 * @returns true if authenticated, false otherwise
 */
export const isAuthenticated = (): boolean => {
  return !!getToken();
};