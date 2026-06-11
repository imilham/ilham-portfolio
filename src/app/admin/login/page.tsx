"use client";

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { ArrowLeft, Lock } from 'lucide-react';
import Link from 'next/link';
import { auth } from '../../../lib/firebase';
import { signInWithEmailAndPassword, onAuthStateChanged } from 'firebase/auth';

export default function AdminLogin() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  useEffect(() => {
    // If already logged in, redirect to admin
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      if (user) {
        router.push('/admin');
      }
    });
    return () => unsubscribe();
  }, [router]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      await signInWithEmailAndPassword(auth, username, password);
      // Let the onAuthStateChanged listener handle the redirect
    } catch (err: any) {
      setError(err.message || 'Invalid email or password');
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#0A0A0C] flex flex-col items-center justify-center p-6 text-[#F4F4F6]">
      <div className="w-full max-w-md">
        <Link 
          href="/"
          className="inline-flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors mb-8"
        >
          <ArrowLeft size={16} />
          Back to Portfolio
        </Link>

        <div className="bg-[#121216] border border-[#1A1A22] rounded-2xl p-8 shadow-2xl">
          <div className="flex flex-col items-center mb-8">
            <div className="w-12 h-12 bg-[#1A1A22] rounded-full flex items-center justify-center mb-4">
              <Lock className="text-[#AB4AFF]" size={24} />
            </div>
            <h1 className="text-2xl font-bold">Admin Access</h1>
            <p className="text-[#8A8A93] text-sm mt-2 text-center">
              Sign in with your Firebase Auth credentials to manage your portfolio.
            </p>
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            {error && (
              <div className="p-3 bg-red-500/10 border border-red-500/20 text-red-400 rounded-lg text-sm text-center">
                {error}
              </div>
            )}
            
            <div>
              <label className="block text-sm font-medium text-[#8A8A93] mb-2">Email</label>
              <input
                type="email"
                required
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                className="w-full px-4 py-3 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:ring-1 focus:ring-[#AB4AFF] transition-all outline-none text-[#F4F4F6]"
                placeholder="admin@example.com"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-[#8A8A93] mb-2">Password</label>
              <input
                type="password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full px-4 py-3 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:ring-1 focus:ring-[#AB4AFF] transition-all outline-none text-[#F4F4F6]"
                placeholder="••••••••"
              />
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full py-3 bg-[#AB4AFF] text-white font-medium rounded-xl hover:bg-[#9A3FEE] transition-all disabled:opacity-70 disabled:cursor-not-allowed mt-4"
            >
              {loading ? 'Authenticating...' : 'Sign In'}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
}
