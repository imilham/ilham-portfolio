"use client";

import { motion } from 'motion/react';

interface ImageLoaderProps extends React.ComponentProps<typeof motion.img> {
  containerClassName?: string;
}

export function ImageLoader({ containerClassName = '', className = '', src, alt, ...props }: ImageLoaderProps) {
  if (!src) return null;

  return (
    <div className={`relative overflow-hidden ${containerClassName}`}>
      <motion.img
        src={src}
        alt={alt || ''}
        className={className}
        {...props}
      />
    </div>
  );
}
