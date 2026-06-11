import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function middleware(request: NextRequest) {
  // Get the current path
  const path = request.nextUrl.pathname;

  // Protect /admin routes, but ignore the login page
  if (path.startsWith('/admin') && path !== '/admin/login') {
    const sessionCookie = request.cookies.get('admin_session');

    // If there is no valid session cookie, redirect to the login page
    if (!sessionCookie || sessionCookie.value !== 'authenticated') {
      return NextResponse.redirect(new URL('/admin/login', request.url));
    }
  }

  return NextResponse.next();
}

// Ensure the middleware only runs on specific paths
export const config = {
  matcher: ['/admin/:path*'],
};
