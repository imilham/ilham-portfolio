"use client";

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { Lock, User } from 'lucide-react';

export default function LoginPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const router = useRouter();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);

    try {
      const res = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, password }),
      });

      const data = await res.json();

      if (data.success) {
        router.push('/admin');
        router.refresh(); // Refresh to ensure middleware catches the new cookie properly on client-side navigation
      } else {
        setError(data.error || 'Invalid credentials');
      }
    } catch (err) {
      setError('An error occurred. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#0A0A0C] text-[#F4F4F6] flex flex-col items-center justify-center p-6">
      <div className="w-full max-w-md bg-[#121216] border border-[#1A1A22] rounded-2xl p-8 shadow-2xl">
        <div className="text-center mb-8">
          <h1 className="text-2xl font-bold mb-2">Admin Portal</h1>
          <p className="text-[#8A8A93] text-sm">Please sign in to access the dashboard</p>
        </div>

        {error && (
          <div className="mb-6 p-4 bg-red-500/10 border border-red-500/20 text-red-400 text-sm rounded-xl text-center">
            {error}
          </div>
        )}

        <form onSubmit={handleLogin} className="space-y-5">
          <div>
            <label className="block text-sm font-medium text-[#8A8A93] mb-2">Username</label>
            <div className="relative">
              <User className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-[#8A8A93]" />
              <input
                type="text"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                className="w-full pl-10 pr-4 py-3 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:ring-1 focus:ring-[#AB4AFF] transition-all outline-none"
                placeholder="Enter admin username"
                required
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-[#8A8A93] mb-2">Password</label>
            <div className="relative">
              <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-[#8A8A93]" />
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full pl-10 pr-4 py-3 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:ring-1 focus:ring-[#AB4AFF] transition-all outline-none"
                placeholder="Enter password"
                required
              />
            </div>
          </div>

          <button
            type="submit"
            disabled={isLoading}
            className="w-full py-3 bg-[#AB4AFF] text-white font-medium rounded-xl hover:bg-[#9A3FEE] transition-all disabled:opacity-50 disabled:cursor-not-allowed mt-2"
          >
            {isLoading ? 'Signing in...' : 'Sign In'}
          </button>
        </form>
      </div>
    </div>
  );
}
