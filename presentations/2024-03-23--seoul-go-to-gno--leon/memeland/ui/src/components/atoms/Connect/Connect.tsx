import { IConnectProps } from './connect.types.ts';
import { FC, useContext, useState } from 'react';
import { Button, useToast } from '@chakra-ui/react';
import { AdenaService } from '../../../services/adena/adena.ts';
import Toast from '../Toast/Toast.tsx';
import { EToastType } from '../Toast/toast.types.ts';
import { IAccountInfo } from '../../../services/adena/adena.types.ts';
import Config from '../../../config.ts';
import AccountContext from '../../../context/AccountContext.ts';
import Adena from '../../../shared/assets/img/adena.svg?react';

const Connect: FC<IConnectProps> = () => {
  const toast = useToast();
  const { setChainID, setAddress } = useContext(AccountContext);
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleWalletConnect = async () => {
    setIsLoading(true);

    try {
      // Attempt to establish a connection
      await AdenaService.establishConnection('meme.land');

      // Get the account info
      const info: IAccountInfo = await AdenaService.getAccountInfo();

      // Make sure the network is valid
      await AdenaService.switchNetwork(Config.CHAIN_ID);

      // Update the account context
      setAddress(info.address);
      setChainID(Config.CHAIN_ID);

      toast({
        position: 'bottom-right',
        render: () => {
          return (
            <Toast
              text={'Successfully connected to Adena'}
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
            <Toast
              text={'Unable to connect to Adena'}
              type={EToastType.ERROR}
            />
          );
        }
      });
    }

    setIsLoading(false);
  };

  return (
    <Button
      isLoading={isLoading}
      loadingText={'CONNECTING'}
      variant={'buttonPrimary'}
      marginLeft={'auto'}
      onClick={handleWalletConnect}
      leftIcon={
        <Adena
          style={{
            width: '20px',
            height: 'auto'
          }}
        />
      }
    >
      CONNECT WALLET
    </Button>
  );
};

export default Connect;
