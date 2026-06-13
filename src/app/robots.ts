import { MetadataRoute } from 'next';

export default function robots(): MetadataRoute.Robots {
  const siteUrl = "https://imilham.com";

  return {
    rules: {
      userAgent: '*',
      allow: '/',
      disallow: '/adminim/',
    },
    sitemap: `${siteUrl}/sitemap.xml`,
  };
}
