export class BlogPost {
  constructor(
    public readonly id: string,
    public title: string,
    public content: string,
    public author: string,
    public published: boolean,
    public createdAt: Date,
    public updatedAt: Date
  ) {}
}
