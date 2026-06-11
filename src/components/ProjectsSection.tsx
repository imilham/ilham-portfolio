import { motion } from 'motion/react';
import { Code, ExternalLink } from 'lucide-react';

const projects = [
  {
    title: 'E-Commerce Mobile App',
    description: 'Full-featured shopping app with real-time inventory, payment integration, and order tracking. Built with Flutter and Firebase.',
    image: '🛍️',
    tags: ['Flutter', 'Firebase', 'Stripe API'],
    github: '#',
    demo: '#',
  },
  {
    title: 'Healthcare Management System',
    description: 'HIPAA-compliant patient management platform with appointment scheduling and secure medical records.',
    image: '🏥',
    tags: ['Flutter', 'Node.js', 'PostgreSQL'],
    github: '#',
    demo: '#',
  },
  {
    title: 'Social Media Platform',
    description: 'Instagram-like social app with real-time messaging, stories, and advanced content recommendation engine.',
    image: '📱',
    tags: ['Flutter', 'GraphQL', 'AWS'],
    github: '#',
    demo: '#',
  },
  {
    title: 'Fitness Tracking App',
    description: 'Comprehensive fitness tracker with workout plans, nutrition tracking, and AI-powered coaching.',
    image: '💪',
    tags: ['Flutter', 'TensorFlow', 'REST API'],
    github: '#',
    demo: '#',
  },
  {
    title: 'Real Estate Platform',
    description: 'Property listing and virtual tour platform with 3D visualization and mortgage calculator.',
    image: '🏠',
    tags: ['Flutter', 'Laravel', 'Maps API'],
    github: '#',
    demo: '#',
  },
  {
    title: 'Task Management Tool',
    description: 'Collaborative project management tool with kanban boards, time tracking, and team analytics.',
    image: '✅',
    tags: ['Flutter', 'React', 'MongoDB'],
    github: '#',
    demo: '#',
  },
];

export function ProjectsSection() {
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
            {projects.map((project, index) => (
              <motion.div
                key={index}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.4, delay: index * 0.1 }}
                className="bg-[#121216] border border-[#1A1A22] rounded-xl overflow-hidden hover:border-[#AB4AFF] transition-all group"
              >
                {/* Image Placeholder */}
                <div className="aspect-video bg-gradient-to-br from-[#1A1A22] to-[#121216] flex items-center justify-center text-7xl border-b border-[#1A1A22] group-hover:from-[#AB4AFF]/10 group-hover:to-[#121216] transition-all">
                  {project.image}
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
                    <a
                      href={project.github}
                      className="flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors"
                    >
                      <Code className="w-5 h-5" />
                      <span className="text-sm">Code</span>
                    </a>
                    <a
                      href={project.demo}
                      className="flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors"
                    >
                      <ExternalLink className="w-5 h-5" />
                      <span className="text-sm">Demo</span>
                    </a>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        </motion.div>
      </div>
    </section>
  );
}
