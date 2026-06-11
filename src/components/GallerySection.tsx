import { motion } from 'motion/react';
import { useState } from 'react';
import { X, Upload } from 'lucide-react';
export function GallerySection() {
  const [photos, setPhotos] = useState<string[]>([]);
  const [selectedPhoto, setSelectedPhoto] = useState<string | null>(null);

  const handleFileUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const files = event.target.files;
    if (!files) return;

    Array.from(files).forEach((file) => {
      const reader = new FileReader();
      reader.onload = (e) => {
        setPhotos((prev) => [...prev, e.target?.result as string]);
      };
      reader.readAsDataURL(file);
    });
  };

  return (
    <section id="gallery" className="py-20 px-6">
      <div className="max-w-7xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <h2 className="text-4xl lg:text-5xl font-bold mb-6">
            Photo <span className="text-[#AB4AFF]">Gallery</span>
          </h2>
          <p className="text-[#8A8A93] text-lg mb-12 max-w-2xl">
            Moments from conferences, hackathons, speaking engagements, and team collaborations.
          </p>

          {/* Upload Button */}
          <div className="mb-8">
            <label className="inline-flex items-center gap-2 px-6 py-3 bg-[#121216] border border-[#1A1A22] rounded-lg text-[#F4F4F6] hover:border-[#AB4AFF] transition-colors cursor-pointer">
              <Upload className="w-5 h-5" />
              Upload Photos
              <input
                type="file"
                accept="image/*"
                multiple
                onChange={handleFileUpload}
                className="hidden"
              />
            </label>
          </div>

          {/* Photo Grid */}
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
            {photos.map((photo, index) => (
              <motion.div
                key={index}
                initial={{ opacity: 0, scale: 0.9 }}
                whileInView={{ opacity: 1, scale: 1 }}
                viewport={{ once: true }}
                transition={{ duration: 0.3, delay: index * 0.05 }}
                onClick={() => setSelectedPhoto(photo)}
                className="aspect-square rounded-xl overflow-hidden border border-[#1A1A22] hover:border-[#AB4AFF] transition-all cursor-pointer group"
              >
                <img
                  src={photo}
                  alt={`Gallery ${index + 1}`}
                  className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300"
                />
              </motion.div>
            ))}
          </div>
        </motion.div>
      </div>

      {/* Lightbox */}
      {selectedPhoto && (
        <div
          className="fixed inset-0 z-50 bg-black/90 flex items-center justify-center p-4 backdrop-blur-sm"
          onClick={() => setSelectedPhoto(null)}
        >
          <button
            onClick={() => setSelectedPhoto(null)}
            className="absolute top-6 right-6 p-2 bg-[#121216] rounded-lg hover:bg-[#1A1A22] transition-colors"
          >
            <X className="w-6 h-6" />
          </button>
          <img
            src={selectedPhoto}
            alt="Selected"
            className="max-w-full max-h-full object-contain rounded-xl"
          />
        </div>
      )}
    </section>
  );
}
