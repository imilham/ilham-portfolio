import { motion } from 'motion/react';
import { Code, ExternalLink } from 'lucide-react';
import { Project } from '../data/store';

interface ProjectsSectionProps {
  projects: Project[];
}

export function ProjectsSection({ projects }: ProjectsSectionProps) {
  // Only show featured projects on the home page, or show all if none are explicitly featured
  const displayProjects = projects.filter(p => p.featured).length > 0
    ? projects.filter(p => p.featured)
    : projects;

  return (
    <section id="projects" className="py-20 px-6 bg-[#0A0A0C]">
      <div className="max-w-7xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <h2 className="text-4xl lg:text-5xl font-bold mb-6">
            Featured <span className="text-[#AB4AFF]">Projects</span>
          </h2>
          <p className="text-[#8A8A93] text-lg mb-12 max-w-2xl">
            A collection of projects showcasing my expertise in mobile development,
            architecture design, and full-stack engineering.
          </p>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {displayProjects.map((project, index) => (
              <motion.div
                key={project.id}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.4, delay: index * 0.1 }}
                className="bg-[#121216] border border-[#1A1A22] rounded-xl overflow-hidden hover:border-[#AB4AFF] transition-all group"
              >
                {/* Image Placeholder or Actual Image */}
                <div className="aspect-video bg-gradient-to-br from-[#1A1A22] to-[#121216] flex items-center justify-center text-7xl border-b border-[#1A1A22] group-hover:from-[#AB4AFF]/10 group-hover:to-[#121216] transition-all relative overflow-hidden">
                  {project.image ? (
                    <img src={project.image} alt={project.title} className="w-full h-full object-cover" />
                  ) : (
                    <span className="text-4xl opacity-50">📱</span>
                  )}
                </div>

                {/* Content */}
                <div className="p-6 space-y-4">
                  <h3 className="text-xl font-bold group-hover:text-[#AB4AFF] transition-colors">
                    {project.title}
                  </h3>
                  <p className="text-[#8A8A93] text-sm leading-relaxed">
                    {project.description}
                  </p>

                  {/* Tags */}
                  <div className="flex flex-wrap gap-2">
                    {project.tags.map((tag) => (
                      <span
                        key={tag}
                        className="px-3 py-1 bg-[#1A1A22] text-[#8A8A93] text-xs rounded-full"
                      >
                        {tag}
                      </span>
                    ))}
                  </div>

                  {/* Links */}
                  <div className="flex gap-4 pt-2">
                    {project.githubUrl && project.githubUrl !== '#' && (
                      <a
                        href={project.githubUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors"
                      >
                        <Code className="w-5 h-5" />
                        <span className="text-sm">Code</span>
                      </a>
                    )}
                    {project.liveUrl && project.liveUrl !== '#' && (
                      <a
                        href={project.liveUrl}
                        target="_blank"
                        rel="noreferrer"
                        className="flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors"
                      >
                        <ExternalLink className="w-5 h-5" />
                        <span className="text-sm">Demo</span>
                      </a>
                    )}
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
          
          {displayProjects.length === 0 && (
            <p className="text-[#8A8A93]">No projects available yet.</p>
          )}
        </motion.div>
      </div>
    </section>
  );
}
