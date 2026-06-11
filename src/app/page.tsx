import { Portfolio } from '../views/Portfolio';
import { loadData } from '../data/store';

export const revalidate = 60; // ISR: revalidate every 60 seconds

export default async function Home() {
  const data = await loadData();
  return <Portfolio initialData={data} />;
}
