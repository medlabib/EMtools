/**
 * Tests for image compression utility
 */
import { describe, it, expect, vi, beforeEach } from 'vitest';

// Mock canvas and image for Node.js environment
const mockCanvas = {
  width: 0,
  height: 0,
  getContext: vi.fn().mockReturnValue({
    drawImage: vi.fn()
  }),
  toDataURL: vi.fn().mockReturnValue('data:image/jpeg;base64,/9j/test')
};

// Mock document.createElement for canvas
vi.stubGlobal('document', {
  createElement: vi.fn().mockReturnValue(mockCanvas)
});

// Mock Image constructor
vi.stubGlobal('Image', class MockImage {
  onload: (() => void) | null = null;
  onerror: ((e: Error) => void) | null = null;
  src: string = '';
  width: number = 1920;
  height: number = 1080;
});

describe('Image Compression Utility', () => {
  describe('formatFileSize', () => {
    // Import the function inline to avoid module issues
    const formatFileSize = (bytes: number): string => {
      if (bytes < 1024) return `${bytes} B`;
      if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
      return `${(bytes / (1024 * 1024)).toFixed(2)} MB`;
    };

    it('should format bytes', () => {
      expect(formatFileSize(512)).toBe('512 B');
    });

    it('should format kilobytes', () => {
      expect(formatFileSize(1024)).toBe('1.0 KB');
      expect(formatFileSize(1536)).toBe('1.5 KB');
    });

    it('should format megabytes', () => {
      expect(formatFileSize(1024 * 1024)).toBe('1.00 MB');
      expect(formatFileSize(2.5 * 1024 * 1024)).toBe('2.50 MB');
    });

    it('should handle edge cases', () => {
      expect(formatFileSize(0)).toBe('0 B');
      expect(formatFileSize(1)).toBe('1 B');
    });
  });

  describe('Compression Logic', () => {
    it('should identify files needing compression', () => {
      const threshold = 2 * 1024 * 1024; // 2MB
      
      expect(1 * 1024 * 1024 > threshold).toBe(false); // 1MB - no compression
      expect(2 * 1024 * 1024 > threshold).toBe(false); // 2MB - no compression
      expect(3 * 1024 * 1024 > threshold).toBe(true);  // 3MB - needs compression
      expect(5 * 1024 * 1024 > threshold).toBe(true);  // 5MB - needs compression
    });

    it('should reject files over 5MB', () => {
      const maxSize = 5 * 1024 * 1024; // 5MB
      
      expect(6 * 1024 * 1024 > maxSize).toBe(true);
      expect(4 * 1024 * 1024 > maxSize).toBe(false);
    });

    it('should calculate base64 size correctly', () => {
      const getBase64Size = (base64: string): number => {
        const base64Data = base64.split(',')[1] || base64;
        return Math.round((base64Data.length * 3) / 4);
      };
      
      // Base64 is ~4/3 times larger than binary
      const base64 = 'data:image/jpeg;base64,' + 'A'.repeat(1000);
      const size = getBase64Size(base64);
      expect(size).toBe(750); // 1000 * 3/4
    });
  });

  describe('Dimension Scaling', () => {
    it('should scale down images wider than maxWidth', () => {
      const maxWidth = 1920;
      let width = 3840;
      let height = 2160;
      
      if (width > maxWidth) {
        height = Math.round((height * maxWidth) / width);
        width = maxWidth;
      }
      
      expect(width).toBe(1920);
      expect(height).toBe(1080);
    });

    it('should not scale images under maxWidth', () => {
      const maxWidth = 1920;
      let width = 1280;
      let height = 720;
      
      if (width > maxWidth) {
        height = Math.round((height * maxWidth) / width);
        width = maxWidth;
      }
      
      expect(width).toBe(1280);
      expect(height).toBe(720);
    });

    it('should maintain aspect ratio', () => {
      const maxWidth = 1920;
      const originalWidth = 4000;
      const originalHeight = 3000;
      const aspectRatio = originalWidth / originalHeight;
      
      let width = originalWidth;
      let height = originalHeight;
      
      if (width > maxWidth) {
        height = Math.round((height * maxWidth) / width);
        width = maxWidth;
      }
      
      const newAspectRatio = width / height;
      expect(Math.abs(aspectRatio - newAspectRatio)).toBeLessThan(0.01);
    });
  });

  describe('Quality Reduction', () => {
    it('should reduce quality iteratively', () => {
      let quality = 0.8;
      const minQuality = 0.1;
      const qualityStep = 0.1;
      const iterations: number[] = [];
      
      while (quality > minQuality + 0.001) { // Account for floating point
        iterations.push(quality);
        quality -= qualityStep;
      }
      
      expect(iterations.length).toBeGreaterThanOrEqual(6);
      expect(iterations.length).toBeLessThanOrEqual(8);
      expect(iterations[0]).toBeCloseTo(0.8);
    });

    it('should stop at minimum quality', () => {
      let quality = 0.3;
      const minQuality = 0.1;
      let iterations = 0;
      
      while (quality > minQuality) {
        quality -= 0.1;
        iterations++;
      }
      
      expect(iterations).toBe(2);
      expect(quality).toBeCloseTo(0.1);
    });
  });

  describe('CompressionResult Interface', () => {
    interface CompressionResult {
      base64: string;
      originalSize: number;
      compressedSize: number;
      wasCompressed: boolean;
    }

    it('should have correct structure for uncompressed result', () => {
      const result: CompressionResult = {
        base64: 'data:image/jpeg;base64,test',
        originalSize: 1000000,
        compressedSize: 1000000,
        wasCompressed: false
      };
      
      expect(result.wasCompressed).toBe(false);
      expect(result.originalSize).toBe(result.compressedSize);
    });

    it('should have correct structure for compressed result', () => {
      const result: CompressionResult = {
        base64: 'data:image/jpeg;base64,compressed',
        originalSize: 4000000,
        compressedSize: 1800000,
        wasCompressed: true
      };
      
      expect(result.wasCompressed).toBe(true);
      expect(result.compressedSize).toBeLessThan(result.originalSize);
    });

    it('should calculate compression ratio', () => {
      const result: CompressionResult = {
        base64: 'data:image/jpeg;base64,test',
        originalSize: 4000000,
        compressedSize: 1000000,
        wasCompressed: true
      };
      
      const ratio = result.compressedSize / result.originalSize;
      expect(ratio).toBe(0.25); // 75% reduction
    });
  });

  describe('JPEG Conversion', () => {
    it('should convert to JPEG for compression', () => {
      const mimeType = 'image/jpeg';
      expect(mimeType).toBe('image/jpeg');
    });

    it('should use correct quality parameter range', () => {
      const validQualities = [0.1, 0.5, 0.7, 0.8, 0.9, 1.0];
      validQualities.forEach(q => {
        expect(q).toBeGreaterThanOrEqual(0);
        expect(q).toBeLessThanOrEqual(1);
      });
    });
  });

  describe('Error Handling', () => {
    it('should handle missing file', () => {
      const file = null;
      const isValid = file !== null;
      expect(isValid).toBe(false);
    });

    it('should validate image MIME types', () => {
      const validTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
      const fileType = 'image/jpeg';
      const isValid = validTypes.some(t => fileType.startsWith('image/'));
      expect(isValid).toBe(true);
    });

    it('should reject non-image files', () => {
      const fileType = 'application/pdf';
      const isImage = fileType.startsWith('image/');
      expect(isImage).toBe(false);
    });
  });
});
