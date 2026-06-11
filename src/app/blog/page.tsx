import { Blog } from '../../views/Blog';
import { loadData } from '../../data/store';

export const revalidate = 60;

export default async function BlogPage() {
  const data = await loadData();
  return <Blog initialData={data} />;
}
