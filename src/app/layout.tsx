import type { Metadata } from "next";
import localFont from "next/font/local";
import "./globals.css";

const geistSans = localFont({
  src: "./fonts/GeistVF.woff",
  variable: "--font-geist-sans",
  weight: "100 900",
});
const geistMono = localFont({
  src: "./fonts/GeistMonoVF.woff",
  variable: "--font-geist-mono",
  weight: "100 900",
});

import { loadData } from "../data/store";

export async function generateMetadata(): Promise<Metadata> {
  const data = await loadData();
  const siteUrl = "https://imilham.com";
  
  return {
    metadataBase: new URL(siteUrl),
    title: {
      default: data.profile.siteTitle || "Portfolio",
      template: `%s | ${data.profile.siteTitle || "Portfolio"}`
    },
    description: data.profile.tagline || data.profile.bio || "My personal portfolio",
    keywords: [
      "Ilham", 
      "Flutter Developer", 
      "Mobile Developer", 
      "Software Engineer",
      ...(data.profile.skills || [])
    ],
    authors: [{ name: data.profile.name }],
    creator: data.profile.name,
    openGraph: {
      type: "website",
      locale: "en_US",
      url: siteUrl,
      title: data.profile.siteTitle || "Portfolio",
      description: data.profile.tagline || "My personal portfolio",
      siteName: data.profile.siteTitle || "Portfolio",
      images: [
        {
          url: data.profile.heroPhoto || "/og-image.png", // Fallback to a default og-image if available
          width: 1200,
          height: 630,
          alt: data.profile.siteTitle || "Portfolio",
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: data.profile.siteTitle || "Portfolio",
      description: data.profile.tagline || "My personal portfolio",
      creator: data.profile.twitter ? `@${data.profile.twitter.split('/').pop()}` : undefined,
      images: [data.profile.heroPhoto || "/og-image.png"],
    },
  };
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        {children}
      </body>
    </html>
  );
}
