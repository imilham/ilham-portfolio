import { motion } from 'motion/react';
import { Mail, Code, Briefcase, MessageCircle, Send } from 'lucide-react';
import { useState } from 'react';
import { Profile } from '../data/store';

interface ContactSectionProps {
  profile: Profile;
}

export function ContactSection({ profile }: ContactSectionProps) {
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    // Simulate API call
    setTimeout(() => setIsSubmitting(false), 1500);
  };

  return (
    <section id="contact" className="py-20 px-6">
      <div className="max-w-7xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-16">
            {/* Left - Contact Info */}
            <div className="space-y-8">
              <div>
                <h2 className="text-4xl lg:text-5xl font-bold mb-6">
                  Let's Work <span className="text-[#AB4AFF]">Together</span>
                </h2>
                <p className="text-[#8A8A93] text-lg leading-relaxed max-w-md">
                  I'm currently available for freelance projects and full-time opportunities.
                  Whether you have a question or just want to say hi, I'll try my best
                  to get back to you!
                </p>
              </div>

              <div className="space-y-4">
                <a
                  href={`mailto:${profile.email}`}
                  className="flex items-center gap-3 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors group"
                >
                  <div className="p-3 bg-[#121216] rounded-lg border border-[#1A1A22] group-hover:border-[#AB4AFF] transition-colors">
                    <Mail className="w-5 h-5" />
                  </div>
                  <span>{profile.email}</span>
                </a>
              </div>

              <div>
                <h4 className="font-bold mb-4 text-lg">Follow Me</h4>
                <div className="flex gap-4">
                  {profile.github && profile.github !== '#' && (
                    <a
                      href={profile.github}
                      target="_blank"
                      rel="noreferrer"
                      className="p-3 bg-[#121216] rounded-lg border border-[#1A1A22] hover:border-[#AB4AFF] hover:text-[#AB4AFF] transition-colors"
                    >
                      <Code className="w-6 h-6" />
                    </a>
                  )}
                  {profile.linkedin && profile.linkedin !== '#' && (
                    <a
                      href={profile.linkedin}
                      target="_blank"
                      rel="noreferrer"
                      className="p-3 bg-[#121216] rounded-lg border border-[#1A1A22] hover:border-[#AB4AFF] hover:text-[#AB4AFF] transition-colors"
                    >
                      <Briefcase className="w-6 h-6" />
                    </a>
                  )}
                  {profile.twitter && profile.twitter !== '#' && (
                    <a
                      href={profile.twitter}
                      target="_blank"
                      rel="noreferrer"
                      className="p-3 bg-[#121216] rounded-lg border border-[#1A1A22] hover:border-[#AB4AFF] hover:text-[#AB4AFF] transition-colors"
                    >
                      <MessageCircle className="w-6 h-6" />
                    </a>
                  )}
                </div>
              </div>
            </div>

            {/* Right - Contact Form */}
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-[#8A8A93] mb-2">Name</label>
                <input
                  type="text"
                  required
                  className="w-full px-4 py-3 bg-[#121216] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:ring-1 focus:ring-[#AB4AFF] transition-all outline-none text-[#F4F4F6]"
                  placeholder="John Doe"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-[#8A8A93] mb-2">Email</label>
                <input
                  type="email"
                  required
                  className="w-full px-4 py-3 bg-[#121216] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:ring-1 focus:ring-[#AB4AFF] transition-all outline-none text-[#F4F4F6]"
                  placeholder="john@example.com"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-[#8A8A93] mb-2">Message</label>
                <textarea
                  required
                  rows={6}
                  className="w-full px-4 py-3 bg-[#121216] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:ring-1 focus:ring-[#AB4AFF] transition-all outline-none text-[#F4F4F6] resize-none"
                  placeholder="Tell me about your project..."
                />
              </div>
              <button
                type="submit"
                disabled={isSubmitting}
                className="w-full py-4 bg-[#AB4AFF] text-white font-medium rounded-xl hover:bg-[#9A3FEE] transition-all flex items-center justify-center gap-2 disabled:opacity-70 disabled:cursor-not-allowed"
              >
                {isSubmitting ? (
                  'Sending...'
                ) : (
                  <>
                    Send Message
                    <Send className="w-5 h-5" />
                  </>
                )}
              </button>
            </form>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
