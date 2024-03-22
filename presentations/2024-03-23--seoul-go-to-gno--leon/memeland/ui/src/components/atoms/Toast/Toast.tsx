import { EToastType, IToastProps } from './toast.types.ts';
import { FC } from 'react';
import { Box, Text } from '@chakra-ui/react';
import { IoCheckmarkCircleSharp, IoCloseCircleSharp } from 'react-icons/io5';

const Toast: FC<IToastProps> = (props) => {
  const renderToastIcon = (type: EToastType) => {
    if (type === EToastType.ERROR) {
      return <IoCloseCircleSharp />;
    }

    return <IoCheckmarkCircleSharp />;
  };

  return (
    <Box
      className={'box'}
      backgroundColor={'white'}
      padding={'20px'}
      display={'flex'}
      width={'100%'}
      alignItems={'center'}
    >
      {renderToastIcon(props.type)}
      <Text ml={2}>{props.text}</Text>
    </Box>
  );
};

export default Toast;
