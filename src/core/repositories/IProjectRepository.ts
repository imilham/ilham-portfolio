import { Project } from '../entities/Project';

export interface IProjectRepository {
  findAll(): Promise<Project[]>;
  findById(id: string): Promise<Project | null>;
  create(project: Omit<Project, 'id' | 'createdAt' | 'updatedAt'>): Promise<Project>;
  update(id: string, projectData: Partial<Project>): Promise<Project | null>;
  delete(id: string): Promise<boolean>;
}
