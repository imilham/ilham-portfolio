"use client";

import { useState } from 'react';
import { motion } from 'motion/react';

interface ImageLoaderProps extends React.ComponentProps<typeof motion.img> {
  containerClassName?: string;
}

export function ImageLoader({ containerClassName = '', className = '', src, alt, ...props }: ImageLoaderProps) {
  const [isLoaded, setIsLoaded] = useState(false);
  const [hasError, setHasError] = useState(false);

  return (
    <div className={`relative overflow-hidden ${containerClassName}`}>
      {/* Skeleton Loader */}
      {(!isLoaded && !hasError) && (
        <div className="absolute inset-0 bg-[#1A1A22] animate-pulse flex items-center justify-center">
           <div className="w-8 h-8 border-4 border-[#252530] border-t-[#AB4AFF] rounded-full animate-spin"></div>
        </div>
      )}
      
      {/* Error Fallback */}
      {hasError && (
        <div className="absolute inset-0 bg-[#121216] flex items-center justify-center">
           <span className="text-xs text-[#8A8A93] uppercase tracking-wider font-medium">Image Unavailable</span>
        </div>
      )}

      {/* Actual Image */}
      {!hasError && src && (
        <motion.img
          initial={{ opacity: 0 }}
          animate={{ opacity: isLoaded ? 1 : 0 }}
          transition={{ duration: 0.5 }}
          onLoad={() => setIsLoaded(true)}
          onError={() => setHasError(true)}
          src={src}
          alt={alt || ''}
          className={`${className} ${!isLoaded ? 'invisible' : 'visible'}`}
          {...props}
        />
      )}
    </div>
  );
}
