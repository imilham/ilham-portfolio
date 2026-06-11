import { useState } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { X, Upload } from 'lucide-react';
import { GalleryPhoto } from '../data/store';
import { getDriveViewUrl } from '../lib/drive';

interface GallerySectionProps {
  gallery: GalleryPhoto[];
}

export function GallerySection({ gallery }: GallerySectionProps) {
  const [selectedImage, setSelectedImage] = useState<string | null>(null);

  return (
    <section id="gallery" className="py-20 px-6 bg-[#121216]">
      <div className="max-w-7xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <div className="flex justify-between items-end mb-12">
            <div>
              <h2 className="text-4xl lg:text-5xl font-bold mb-4">
                Life & <span className="text-[#AB4AFF]">Moments</span>
              </h2>
              <p className="text-[#8A8A93] text-lg max-w-2xl">
                A glimpse into my life, travels, and the moments that inspire my work.
                Because life isn't just about writing code.
              </p>
            </div>
          </div>

          <div className="columns-1 md:columns-2 lg:columns-3 gap-6 space-y-6">
            {gallery.map((photo, index) => (
              <motion.div
                key={photo.id}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.4, delay: index * 0.1 }}
                className="relative group cursor-pointer break-inside-avoid"
                onClick={() => setSelectedImage(getDriveViewUrl(photo.url))}
              >
                <div className="relative overflow-hidden rounded-xl bg-[#1A1A22]">
                  {photo.url ? (
                    <img
                      src={getDriveViewUrl(photo.url)}
                      alt={photo.caption}
                      className="w-full object-cover transform group-hover:scale-105 transition-transform duration-500"
                    />
                  ) : (
                    <div className="w-full aspect-[4/5] flex items-center justify-center">
                      <span className="text-[#8A8A93]">No Image</span>
                    </div>
                  )}
                  
                  {/* Overlay */}
                  <div className="absolute inset-0 bg-gradient-to-t from-[#0A0A0C]/90 via-[#0A0A0C]/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                    <div className="absolute bottom-0 left-0 right-0 p-6">
                      <span className="inline-block px-3 py-1 bg-[#AB4AFF] text-white text-xs font-medium rounded-full mb-2">
                        {photo.category}
                      </span>
                      <p className="text-white font-medium">{photo.caption}</p>
                    </div>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>

          {gallery.length === 0 && (
            <p className="text-[#8A8A93]">No gallery photos available yet.</p>
          )}

        </motion.div>
      </div>

      {/* Lightbox */}
      <AnimatePresence>
        {selectedImage && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setSelectedImage(null)}
            className="fixed inset-0 z-50 flex items-center justify-center bg-[#0A0A0C]/95 backdrop-blur-xl p-6"
          >
            <button
              onClick={() => setSelectedImage(null)}
              className="absolute top-6 right-6 p-2 bg-[#1A1A22] rounded-full text-white hover:bg-[#AB4AFF] transition-colors"
            >
              <X className="w-6 h-6" />
            </button>
            <motion.img
              initial={{ scale: 0.9 }}
              animate={{ scale: 1 }}
              exit={{ scale: 0.9 }}
              src={selectedImage}
              alt="Selected"
              className="max-w-full max-h-full rounded-2xl shadow-2xl"
              onClick={(e) => e.stopPropagation()}
            />
          </motion.div>
        )}
      </AnimatePresence>
    </section>
  );
}
