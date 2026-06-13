import { Metadata } from 'next';
import { BlogPost } from '../../../views/BlogPost';
import { loadData } from '../../../data/store';

export const revalidate = 60;

export async function generateMetadata({ params }: { params: { slug: string } }): Promise<Metadata> {
  const data = await loadData();
  const post = data.blog.find((p) => p.slug === params.slug);
  
  if (!post) {
    return {
      title: 'Post Not Found',
    };
  }

  const siteUrl = "https://imilham.com";
  const url = `${siteUrl}/blog/${post.slug}`;

  return {
    title: post.title,
    description: post.excerpt,
    openGraph: {
      title: post.title,
      description: post.excerpt,
      url,
      type: 'article',
      publishedTime: post.publishedAt,
      authors: [data.profile.name],
      images: [
        {
          url: post.coverImage || data.profile.heroPhoto || "/og-image.png",
          width: 1200,
          height: 630,
          alt: post.title,
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: post.title,
      description: post.excerpt,
      images: [post.coverImage || data.profile.heroPhoto || "/og-image.png"],
    },
  };
}

export default async function BlogPostPage({ params }: { params: { slug: string } }) {
  const data = await loadData();
  return <BlogPost initialData={data} slug={params.slug} />;
}
