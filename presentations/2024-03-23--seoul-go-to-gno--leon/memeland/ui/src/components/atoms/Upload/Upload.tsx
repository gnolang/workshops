import { defaultCompressorOptions, IUploadProps } from './upload.types.ts';
import React, { FC, useRef, useState } from 'react';
import { Box, Button, Tooltip, useToast } from '@chakra-ui/react';
import Toast from '../Toast/Toast.tsx';
import { EToastType } from '../Toast/toast.types.ts';
import Compressor from 'compressorjs';
import {
  EMessageType,
  IAccountInfo
} from '../../../services/adena/adena.types.ts';
import { AdenaService } from '../../../services/adena/adena.ts';
import Config from '../../../config.ts';
import { MdFileUpload } from 'react-icons/md';

const Upload: FC<IUploadProps> = (props) => {
  const { resetHomepage } = props;

  const [isLoading, setIsLoading] = useState<boolean>(false);
  const toast = useToast();
  const fileInputRef = useRef<HTMLInputElement | null>(null);

  const handleUploadTrigger = () => {
    if (!fileInputRef.current) {
      return;
    }

    fileInputRef.current.value = '';
    fileInputRef.current.click();
  };

  const handleMemeUpload = async (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    setIsLoading(true);

    // Grab the selected file, if any
    const file = event.target.files?.[0];
    if (!file) {
      toast({
        position: 'bottom-right',
        render: () => {
          return <Toast text={'No image selected'} type={EToastType.SUCCESS} />;
        }
      });

      setIsLoading(false);

      return;
    }

    new Compressor(file, {
      ...defaultCompressorOptions,

      success(result: File | Blob) {
        const reader = new FileReader();

        reader.onload = async () => {
          const base64Image = reader.result;

          try {
            const accountInfo: IAccountInfo =
              await AdenaService.getAccountInfo();

            await AdenaService.sendTransaction(
              [
                {
                  type: EMessageType.MSG_CALL,
                  value: {
                    caller: accountInfo.address,
                    send: '',
                    pkg_path: Config.REALM_PATH,
                    func: 'PostMeme',
                    args: [
                      base64Image as string,
                      `${Math.floor(Date.now() / 1000)}`
                    ]
                  }
                }
              ],
              10000000
            );

            // Trigger a homepage reset
            resetHomepage();

            toast({
              position: 'bottom-right',
              render: () => {
                return (
                  <Toast
                    text={'Successfully posted meme!'}
                    type={EToastType.SUCCESS}
                  />
                );
              }
            });
          } catch (e) {
            console.error(e);

            toast({
              position: 'bottom-right',
              render: () => {
                return (
                  <Toast text={'Unable to post meme'} type={EToastType.ERROR} />
                );
              }
            });
          }
        };

        reader.readAsDataURL(result);
      },
      error(e: Error) {
        console.error(e);

        toast({
          position: 'bottom-right',
          render: () => {
            return (
              <Toast text={'Unable to parse meme'} type={EToastType.ERROR} />
            );
          }
        });
      }
    });

    setIsLoading(false);
  };

  return (
    <Box>
      <Tooltip label="Memes are cropped to 600x600px" hasArrow>
        <Button
          isLoading={isLoading}
          loadingText={'UPLOADING'}
          variant={'buttonPrimary'}
          marginLeft={'auto'}
          as={'label'}
          htmlFor={'fileInput'}
          onClick={handleUploadTrigger}
          cursor={'pointer'}
          leftIcon={<MdFileUpload />}
        >
          UPLOAD MEME
        </Button>
      </Tooltip>
      <input
        type={'file'}
        accept={'image/*'}
        onChange={handleMemeUpload}
        ref={fileInputRef}
        style={{ display: 'none' }}
      />
    </Box>
  );
};

export default Upload;
