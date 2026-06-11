import { NextRequest, NextResponse } from 'next/server';
import { ProjectUseCases } from '../../../core/useCases/ProjectUseCases';
import { InMemoryProjectRepository } from '../../../core/repositories/InMemoryProjectRepository';

// Initialize dependencies
// In a real app, this should be done in a dependency injection container or singleton to persist data across requests.
const projectRepository = new InMemoryProjectRepository();
const projectUseCases = new ProjectUseCases(projectRepository);

export async function GET() {
  try {
    const projects = await projectUseCases.getAllProjects();
    return NextResponse.json(projects);
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const data = await request.json();
    const newProject = await projectUseCases.createProject(data);
    return NextResponse.json(newProject, { status: 201 });
  } catch (error) {
    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }
}
