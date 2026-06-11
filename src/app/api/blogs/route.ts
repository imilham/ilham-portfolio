import { NextRequest, NextResponse } from 'next/server';
import { BlogUseCases } from '../../../core/useCases/BlogUseCases';
import { InMemoryBlogRepository } from '../../../core/repositories/InMemoryBlogRepository';

const blogRepository = new InMemoryBlogRepository();
const blogUseCases = new BlogUseCases(blogRepository);

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const onlyPublished = searchParams.get('published') !== 'false';
    const posts = await blogUseCases.getAllPosts(onlyPublished);
    return NextResponse.json(posts);
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const data = await request.json();
    const newPost = await blogUseCases.createPost(data);
    return NextResponse.json(newPost, { status: 201 });
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}
