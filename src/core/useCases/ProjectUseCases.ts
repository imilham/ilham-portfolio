import { Project } from '../entities/Project';
import { IProjectRepository } from '../repositories/IProjectRepository';

export class ProjectUseCases {
  constructor(private projectRepository: IProjectRepository) {}

  async getAllProjects(): Promise<Project[]> {
    return this.projectRepository.findAll();
  }

  async getProjectById(id: string): Promise<Project | null> {
    return this.projectRepository.findById(id);
  }

  async createProject(projectData: Omit<Project, 'id' | 'createdAt' | 'updatedAt'>): Promise<Project> {
    return this.projectRepository.create(projectData);
  }

  async updateProject(id: string, projectData: Partial<Project>): Promise<Project | null> {
    return this.projectRepository.update(id, projectData);
  }

  async deleteProject(id: string): Promise<boolean> {
    return this.projectRepository.delete(id);
  }
}
