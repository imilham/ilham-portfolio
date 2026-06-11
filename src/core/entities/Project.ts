export class Project {
  constructor(
    public readonly id: string,
    public title: string,
    public description: string,
    public imageUrl: string,
    public projectUrl: string,
    public tags: string[],
    public createdAt: Date,
    public updatedAt: Date
  ) {}
}
