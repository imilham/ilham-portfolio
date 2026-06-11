import { BlogPost } from '../entities/BlogPost';
import { IBlogRepository } from '../repositories/IBlogRepository';

export class InMemoryBlogRepository implements IBlogRepository {
  private posts: BlogPost[] = [];

  async findAll(onlyPublished: boolean = false): Promise<BlogPost[]> {
    if (onlyPublished) {
      return this.posts.filter(p => p.published);
    }
    return [...this.posts];
  }

  async findById(id: string): Promise<BlogPost | null> {
    const post = this.posts.find(p => p.id === id);
    return post ? { ...post } : null;
  }

  async create(postData: Omit<BlogPost, 'id' | 'createdAt' | 'updatedAt'>): Promise<BlogPost> {
    const newPost = new BlogPost(
      Math.random().toString(36).substring(2, 9),
      postData.title,
      postData.content,
      postData.author,
      postData.published,
      new Date(),
      new Date()
    );
    this.posts.push(newPost);
    return { ...newPost };
  }

  async update(id: string, postData: Partial<BlogPost>): Promise<BlogPost | null> {
    const index = this.posts.findIndex(p => p.id === id);
    if (index === -1) return null;

    const existingPost = this.posts[index];
    const updatedPost = {
      ...existingPost,
      ...postData,
      updatedAt: new Date()
    };
    
    this.posts[index] = updatedPost as BlogPost;
    return { ...updatedPost } as BlogPost;
  }

  async delete(id: string): Promise<boolean> {
    const initialLength = this.posts.length;
    this.posts = this.posts.filter(p => p.id !== id);
    return this.posts.length !== initialLength;
  }
}
