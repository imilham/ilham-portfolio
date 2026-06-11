import { useState, useEffect } from 'react';
import { SiteData, loadData } from '../data/store';

export function useSiteData(initialData?: SiteData | null) {
  const [data, setData] = useState<SiteData | null>(initialData || null);
  const [loading, setLoading] = useState(!initialData);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    let isMounted = true;

    async function fetchData() {
      try {
        if (!initialData) setLoading(true);
        const fetchedData = await loadData();
        if (isMounted) {
          setData(fetchedData);
          setError(null);
        }
      } catch (err) {
        if (isMounted) {
          setError(err instanceof Error ? err : new Error('Failed to fetch data'));
        }
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    }

    fetchData();

    return () => {
      isMounted = false;
    };
  }, []);

  return { data, loading, error };
}
