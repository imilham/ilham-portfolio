import { BlogPost } from '../entities/BlogPost';
import { IBlogRepository } from '../repositories/IBlogRepository';

export class BlogUseCases {
  constructor(private blogRepository: IBlogRepository) {}

  async getAllPosts(onlyPublished: boolean = true): Promise<BlogPost[]> {
    return this.blogRepository.findAll(onlyPublished);
  }

  async getPostById(id: string): Promise<BlogPost | null> {
    return this.blogRepository.findById(id);
  }

  async createPost(postData: Omit<BlogPost, 'id' | 'createdAt' | 'updatedAt'>): Promise<BlogPost> {
    return this.blogRepository.create(postData);
  }

  async updatePost(id: string, postData: Partial<BlogPost>): Promise<BlogPost | null> {
    return this.blogRepository.update(id, postData);
  }

  async deletePost(id: string): Promise<boolean> {
    return this.blogRepository.delete(id);
  }
}
