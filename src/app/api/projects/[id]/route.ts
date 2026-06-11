import { NextRequest, NextResponse } from 'next/server';
import { ProjectUseCases } from '../../../../core/useCases/ProjectUseCases';
import { InMemoryProjectRepository } from '../../../../core/repositories/InMemoryProjectRepository';

const projectRepository = new InMemoryProjectRepository();
const projectUseCases = new ProjectUseCases(projectRepository);

export async function GET(request: NextRequest, { params }: { params: { id: string } }) {
  try {
    const project = await projectUseCases.getProjectById(params.id);
    if (!project) return NextResponse.json({ error: 'Not Found' }, { status: 404 });
    return NextResponse.json(project);
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}

export async function PUT(request: NextRequest, { params }: { params: { id: string } }) {
  try {
    const data = await request.json();
    const updated = await projectUseCases.updateProject(params.id, data);
    if (!updated) return NextResponse.json({ error: 'Not Found' }, { status: 404 });
    return NextResponse.json(updated);
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}

export async function DELETE(request: NextRequest, { params }: { params: { id: string } }) {
  try {
    const success = await projectUseCases.deleteProject(params.id);
    if (!success) return NextResponse.json({ error: 'Not Found' }, { status: 404 });
    return new NextResponse(null, { status: 204 });
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}
