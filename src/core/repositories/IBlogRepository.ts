import { BlogPost } from '../entities/BlogPost';

export interface IBlogRepository {
  findAll(onlyPublished?: boolean): Promise<BlogPost[]>;
  findById(id: string): Promise<BlogPost | null>;
  create(blogPost: Omit<BlogPost, 'id' | 'createdAt' | 'updatedAt'>): Promise<BlogPost>;
  update(id: string, blogPostData: Partial<BlogPost>): Promise<BlogPost | null>;
  delete(id: string): Promise<boolean>;
}
