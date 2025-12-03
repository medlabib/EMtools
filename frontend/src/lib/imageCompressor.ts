/**
 * Image compression utility
 * Compresses images larger than 2MB to fit under the limit
 */

export interface CompressionResult {
  base64: string;
  originalSize: number;
  compressedSize: number;
  wasCompressed: boolean;
}

/**
 * Compress an image file if it's larger than 2MB
 * @param file - The image file to compress
 * @param maxSizeBytes - Maximum output size in bytes (default 2MB)
 * @param maxWidth - Maximum width to scale to (default 1920)
 * @param quality - Initial JPEG quality (default 0.8)
 * @returns Promise with compression result
 */
export async function compressImage(
  file: File,
  maxSizeBytes: number = 2 * 1024 * 1024,
  maxWidth: number = 1920,
  quality: number = 0.8
): Promise<CompressionResult> {
  const originalSize = file.size;
  
  // If file is already under the limit, just convert to base64
  if (originalSize <= maxSizeBytes) {
    const base64 = await fileToBase64(file);
    return {
      base64,
      originalSize,
      compressedSize: originalSize,
      wasCompressed: false
    };
  }
  
  // Need to compress
  const compressed = await compressToSize(file, maxSizeBytes, maxWidth, quality);
  
  return {
    base64: compressed.base64,
    originalSize,
    compressedSize: compressed.size,
    wasCompressed: true
  };
}

/**
 * Convert a File to base64 string
 */
function fileToBase64(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => resolve(reader.result as string);
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

/**
 * Load an image from a File
 */
function loadImage(file: File): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.onload = () => resolve(img);
    img.onerror = reject;
    
    const reader = new FileReader();
    reader.onload = (e) => {
      img.src = e.target?.result as string;
    };
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

/**
 * Compress image to fit within target size
 */
async function compressToSize(
  file: File,
  targetSize: number,
  maxWidth: number,
  initialQuality: number
): Promise<{ base64: string; size: number }> {
  const img = await loadImage(file);
  
  // Calculate new dimensions
  let width = img.width;
  let height = img.height;
  
  if (width > maxWidth) {
    height = Math.round((height * maxWidth) / width);
    width = maxWidth;
  }
  
  // Create canvas
  const canvas = document.createElement('canvas');
  canvas.width = width;
  canvas.height = height;
  
  const ctx = canvas.getContext('2d');
  if (!ctx) {
    throw new Error('Could not get canvas context');
  }
  
  // Draw image
  ctx.drawImage(img, 0, 0, width, height);
  
  // Try different quality levels until we hit target size
  let quality = initialQuality;
  let base64 = canvas.toDataURL('image/jpeg', quality);
  let size = getBase64Size(base64);
  
  // Reduce quality iteratively if still too large
  while (size > targetSize && quality > 0.1) {
    quality -= 0.1;
    base64 = canvas.toDataURL('image/jpeg', quality);
    size = getBase64Size(base64);
  }
  
  // If still too large, reduce dimensions
  if (size > targetSize) {
    let scale = 0.9;
    while (size > targetSize && scale > 0.3) {
      const newWidth = Math.round(width * scale);
      const newHeight = Math.round(height * scale);
      
      canvas.width = newWidth;
      canvas.height = newHeight;
      ctx.drawImage(img, 0, 0, newWidth, newHeight);
      
      base64 = canvas.toDataURL('image/jpeg', 0.7);
      size = getBase64Size(base64);
      scale -= 0.1;
    }
  }
  
  return { base64, size };
}

/**
 * Get approximate size of base64 string in bytes
 */
function getBase64Size(base64: string): number {
  // Remove data URL prefix
  const base64Data = base64.split(',')[1] || base64;
  // Base64 is ~4/3 times larger than binary
  return Math.round((base64Data.length * 3) / 4);
}

/**
 * Format file size for display
 */
export function formatFileSize(bytes: number): string {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(2)} MB`;
}
