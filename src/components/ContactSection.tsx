import { motion } from 'motion/react';
import { Mail, Code, Briefcase, MessageCircle, Send } from 'lucide-react';
import { useState } from 'react';

export function ContactSection() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    subject: '',
    message: '',
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Form submitted:', formData);
    // Handle form submission
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  return (
    <section id="contact" className="py-20 px-6 bg-[#0A0A0C]">
      <div className="max-w-5xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <h2 className="text-4xl lg:text-5xl font-bold mb-6 text-center">
            Let's <span className="text-[#AB4AFF]">Connect</span>
          </h2>
          <p className="text-[#8A8A93] text-lg mb-12 text-center max-w-2xl mx-auto">
            I'm always open to discussing new projects, creative ideas, or opportunities
            to be part of your vision. Feel free to reach out!
          </p>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
            {/* Left - Contact Info */}
            <div className="space-y-6">
              <div>
                <h3 className="text-2xl font-bold mb-4">Get in Touch</h3>
                <p className="text-[#8A8A93] mb-6">
                  Whether you have a question or just want to say hi, I'll try my best
                  to get back to you!
                </p>
              </div>

              <div className="space-y-4">
                <a
                  href="mailto:contact@imilham.com"
                  className="flex items-center gap-3 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors group"
                >
                  <div className="p-3 bg-[#121216] rounded-lg border border-[#1A1A22] group-hover:border-[#AB4AFF] transition-colors">
                    <Mail className="w-5 h-5" />
                  </div>
                  <span>contact@imilham.com</span>
                </a>
              </div>

              <div>
                <h4 className="font-bold mb-4 text-lg">Follow Me</h4>
                <div className="flex gap-4">
                  <a
                    href="#"
                    className="p-3 bg-[#121216] rounded-lg border border-[#1A1A22] hover:border-[#AB4AFF] hover:text-[#AB4AFF] transition-colors"
                  >
                    <Code className="w-6 h-6" />
                  </a>
                  <a
                    href="#"
                    className="p-3 bg-[#121216] rounded-lg border border-[#1A1A22] hover:border-[#AB4AFF] hover:text-[#AB4AFF] transition-colors"
                  >
                    <Briefcase className="w-6 h-6" />
                  </a>
                  <a
                    href="#"
                    className="p-3 bg-[#121216] rounded-lg border border-[#1A1A22] hover:border-[#AB4AFF] hover:text-[#AB4AFF] transition-colors"
                  >
                    <MessageCircle className="w-6 h-6" />
                  </a>
                </div>
              </div>
            </div>

            {/* Right - Contact Form */}
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  placeholder="Your Name"
                  required
                  className="w-full px-4 py-3 bg-[#121216] border border-[#1A1A22] rounded-lg text-[#F4F4F6] placeholder-[#8A8A93] focus:border-[#AB4AFF] focus:outline-none transition-colors"
                />
              </div>
              <div>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  placeholder="Your Email"
                  required
                  className="w-full px-4 py-3 bg-[#121216] border border-[#1A1A22] rounded-lg text-[#F4F4F6] placeholder-[#8A8A93] focus:border-[#AB4AFF] focus:outline-none transition-colors"
                />
              </div>
              <div>
                <input
                  type="text"
                  name="subject"
                  value={formData.subject}
                  onChange={handleChange}
                  placeholder="Subject"
                  required
                  className="w-full px-4 py-3 bg-[#121216] border border-[#1A1A22] rounded-lg text-[#F4F4F6] placeholder-[#8A8A93] focus:border-[#AB4AFF] focus:outline-none transition-colors"
                />
              </div>
              <div>
                <textarea
                  name="message"
                  value={formData.message}
                  onChange={handleChange}
                  placeholder="Your Message"
                  required
                  rows={5}
                  className="w-full px-4 py-3 bg-[#121216] border border-[#1A1A22] rounded-lg text-[#F4F4F6] placeholder-[#8A8A93] focus:border-[#AB4AFF] focus:outline-none transition-colors resize-none"
                />
              </div>
              <button
                type="submit"
                className="w-full px-6 py-3 bg-[#AB4AFF] text-white rounded-lg hover:bg-[#9A3FEE] transition-colors flex items-center justify-center gap-2 shadow-lg shadow-[#AB4AFF]/25"
              >
                Send Message
                <Send className="w-5 h-5" />
              </button>
            </form>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
