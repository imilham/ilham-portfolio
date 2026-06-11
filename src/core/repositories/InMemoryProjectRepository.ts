import { Project } from '../entities/Project';
import { IProjectRepository } from '../repositories/IProjectRepository';

export class InMemoryProjectRepository implements IProjectRepository {
  private projects: Project[] = [];

  async findAll(): Promise<Project[]> {
    return [...this.projects];
  }

  async findById(id: string): Promise<Project | null> {
    const project = this.projects.find(p => p.id === id);
    return project ? { ...project } : null;
  }

  async create(projectData: Omit<Project, 'id' | 'createdAt' | 'updatedAt'>): Promise<Project> {
    const newProject = new Project(
      Math.random().toString(36).substring(2, 9),
      projectData.title,
      projectData.description,
      projectData.imageUrl,
      projectData.projectUrl,
      projectData.tags,
      new Date(),
      new Date()
    );
    this.projects.push(newProject);
    return { ...newProject };
  }

  async update(id: string, projectData: Partial<Project>): Promise<Project | null> {
    const index = this.projects.findIndex(p => p.id === id);
    if (index === -1) return null;

    const existingProject = this.projects[index];
    const updatedProject = {
      ...existingProject,
      ...projectData,
      updatedAt: new Date()
    };
    
    this.projects[index] = updatedProject as Project;
    return { ...updatedProject } as Project;
  }

  async delete(id: string): Promise<boolean> {
    const initialLength = this.projects.length;
    this.projects = this.projects.filter(p => p.id !== id);
    return this.projects.length !== initialLength;
  }
}
