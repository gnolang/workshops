export interface IUploadProps {
  resetHomepage: () => void;
}

export const defaultCompressorOptions: Compressor.Options = {
  quality: 0.9,
  mimeType: 'image/jpeg',
  convertSize: Infinity,
  width: 600,
  height: 600,
  resize: 'contain',
  strict: true
};
