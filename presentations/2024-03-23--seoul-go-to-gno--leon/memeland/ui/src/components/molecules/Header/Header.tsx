import { IHeaderProps } from './header.types.ts';
import { FC, useContext } from 'react';
import {
  Box,
  Button,
  Menu,
  MenuButton,
  MenuItem,
  MenuList,
  Text,
  useMediaQuery
} from '@chakra-ui/react';
import { IoChevronDownOutline } from 'react-icons/io5';
import { EPostSort, EPostTime } from '../../organisms/Home/home.types.ts';
import Connect from '../../atoms/Connect/Connect.tsx';
import AccountContext from '../../../context/AccountContext.ts';
import Upload from '../../atoms/Upload/Upload.tsx';

const Header: FC<IHeaderProps> = (props) => {
  const { setPostSort, setPostTime, resetHomepage } = props;

  const [isMdOrSmaller] = useMediaQuery('(max-width: 62em)');
  const { address } = useContext(AccountContext);

  return (
    <Box
      display={'flex'}
      backgroundColor={'white'}
      width={'100%'}
      className={'box'}
      justifyContent={'space-between'}
      alignItems={'center'}
      flexDirection={isMdOrSmaller ? 'column' : 'row'}
    >
      <Box display={'flex'} alignItems={'center'}>
        <Box>
          <Menu isLazy>
            <MenuButton
              as={Button}
              rightIcon={<IoChevronDownOutline />}
              variant={'buttonPrimary'}
              aria-label={'Sort by'}
            >
              SORT BY
            </MenuButton>
            <MenuList
              style={{
                border: '2px solid black',
                boxShadow: '3px 3px 0 0 rgba(0, 0, 0, 1)',
                fontWeight: 700
              }}
            >
              <MenuItem
                _focus={{
                  backgroundColor: 'gno.gray'
                }}
                _hover={{
                  backgroundColor: 'gno.gray'
                }}
                onClick={() => {
                  setPostSort(EPostSort.UPVOTES);
                }}
              >
                UPVOTES
              </MenuItem>
              <MenuItem
                _focus={{
                  backgroundColor: 'gno.gray'
                }}
                _hover={{
                  backgroundColor: 'gno.gray'
                }}
                onClick={() => {
                  setPostSort(EPostSort.DATE_CREATED);
                }}
              >
                DATE POSTED
              </MenuItem>
            </MenuList>
          </Menu>
        </Box>
        <Box ml={8}>
          <Menu>
            <MenuButton
              as={Button}
              rightIcon={<IoChevronDownOutline />}
              variant={'buttonPrimary'}
              aria-label={'Time'}
            >
              TIME
            </MenuButton>
            <MenuList
              style={{
                border: '2px solid black',
                boxShadow: '3px 3px 0 0 rgba(0, 0, 0, 1)',
                fontWeight: 700
              }}
            >
              <MenuItem
                _focus={{
                  backgroundColor: 'gno.gray'
                }}
                _hover={{
                  backgroundColor: 'gno.gray'
                }}
                onClick={() => {
                  setPostTime(EPostTime.ALL_TIME);
                }}
              >
                ALL TIME
              </MenuItem>
              <MenuItem
                _focus={{
                  backgroundColor: 'gno.gray'
                }}
                _hover={{
                  backgroundColor: 'gno.gray'
                }}
                onClick={() => {
                  setPostTime(EPostTime.TWO_WEEKS);
                }}
              >
                2 WEEKS
              </MenuItem>
              <MenuItem
                _focus={{
                  backgroundColor: 'gno.gray'
                }}
                _hover={{
                  backgroundColor: 'gno.gray'
                }}
                onClick={() => {
                  setPostTime(EPostTime.THREE_MONTHS);
                }}
              >
                3 MONTHS
              </MenuItem>
              <MenuItem
                _focus={{
                  backgroundColor: 'gno.gray'
                }}
                _hover={{
                  backgroundColor: 'gno.gray'
                }}
                onClick={() => {
                  setPostTime(EPostTime.ONE_YEAR);
                }}
              >
                1 YEAR
              </MenuItem>
            </MenuList>
          </Menu>
        </Box>
      </Box>
      <Box my={isMdOrSmaller ? 4 : 0}>
        <Text fontSize={'xl'}>meme.land</Text>
      </Box>
      {address ? (
        <Upload resetHomepage={resetHomepage} />
      ) : (
        <Box display={'flex'}>
          <Connect />
        </Box>
      )}
    </Box>
  );
};

export default Header;
