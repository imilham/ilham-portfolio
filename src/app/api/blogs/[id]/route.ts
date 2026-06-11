import { NextRequest, NextResponse } from 'next/server';
import { BlogUseCases } from '../../../../core/useCases/BlogUseCases';
import { InMemoryBlogRepository } from '../../../../core/repositories/InMemoryBlogRepository';

const blogRepository = new InMemoryBlogRepository();
const blogUseCases = new BlogUseCases(blogRepository);

export async function GET(request: NextRequest, { params }: { params: { id: string } }) {
  try {
    const post = await blogUseCases.getPostById(params.id);
    if (!post) return NextResponse.json({ error: 'Not Found' }, { status: 404 });
    return NextResponse.json(post);
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}

export async function PUT(request: NextRequest, { params }: { params: { id: string } }) {
  try {
    const data = await request.json();
    const updated = await blogUseCases.updatePost(params.id, data);
    if (!updated) return NextResponse.json({ error: 'Not Found' }, { status: 404 });
    return NextResponse.json(updated);
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}

export async function DELETE(request: NextRequest, { params }: { params: { id: string } }) {
  try {
    const success = await blogUseCases.deletePost(params.id);
    if (!success) return NextResponse.json({ error: 'Not Found' }, { status: 404 });
    return new NextResponse(null, { status: 204 });
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}
