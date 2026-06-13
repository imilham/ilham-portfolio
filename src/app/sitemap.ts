import { MetadataRoute } from 'next';
import { loadData } from '../data/store';

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const data = await loadData();
  const siteUrl = "https://imilham.com";

  const baseSitemap: MetadataRoute.Sitemap = [
    {
      url: siteUrl,
      lastModified: new Date(),
      changeFrequency: 'weekly',
      priority: 1,
    },
    {
      url: `${siteUrl}/blog`,
      lastModified: new Date(),
      changeFrequency: 'weekly',
      priority: 0.8,
    },
  ];

  const blogPosts: MetadataRoute.Sitemap = data.blog
    .filter(post => post.published)
    .map((post) => ({
      url: `${siteUrl}/blog/${post.slug}`,
      lastModified: new Date(post.publishedAt),
      changeFrequency: 'monthly',
      priority: 0.6,
    }));

  return [...baseSitemap, ...blogPosts];
}
