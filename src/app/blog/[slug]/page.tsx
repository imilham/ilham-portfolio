import { BlogPost } from '../../../views/BlogPost';
import { loadData } from '../../../data/store';

export const revalidate = 60;

export default async function BlogPostPage({ params }: { params: { slug: string } }) {
  const data = await loadData();
  return <BlogPost initialData={data} slug={params.slug} />;
}
