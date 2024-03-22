import {
  constructStartTimestamp,
  EPostSort,
  EPostTime,
  IHomeProps,
  parsePostFetchResponse
} from './home.types.ts';
import { FC, useContext, useEffect, useState } from 'react';
import { Box, Button, useMediaQuery, useToast } from '@chakra-ui/react';
import Header from '../../molecules/Header/Header.tsx';
import Footer from '../../molecules/Footer/Footer.tsx';
import { IPost } from '../../atoms/Post/post.types.ts';
import Post from '../../atoms/Post/Post.tsx';
import Toast from '../../atoms/Toast/Toast.tsx';
import { EToastType } from '../../atoms/Toast/toast.types.ts';
import Config from '../../../config.ts';
import ProviderContext from '../../../context/ProviderContext.ts';

const Home: FC<IHomeProps> = () => {
  const [isMdOrSmaller] = useMediaQuery('(max-width: 62em)');

  const [sort, setSort] = useState<EPostSort>(EPostSort.UPVOTES);
  const [time, setTime] = useState<EPostTime>(EPostTime.ALL_TIME);

  const [isLoadingMore, setIsLoadingMore] = useState<boolean>(true);
  const postsPerFetch: number = 3;
  const [displayedPosts, setDisplayedPosts] = useState<IPost[]>([]);
  const [page, setPage] = useState<number>(1);

  const toast = useToast();
  const { provider } = useContext(ProviderContext);

  const fetchPosts = async (
    page: number,
    sort: EPostSort = EPostSort.UPVOTES
  ): Promise<IPost[]> => {
    if (!provider) {
      throw new Error('invalid chain RPC URL');
    }

    const startTimestamp: number = constructStartTimestamp(time);
    const endTimestamp: number = Math.floor(new Date().getTime() / 1000);

    const response: string = await provider.evaluateExpression(
      Config.REALM_PATH,
      `GetPostsInRange(${startTimestamp},${endTimestamp},${page},${postsPerFetch},"${sort}")`
    );

    // Parse the posts response
    return parsePostFetchResponse(response);
  };

  const resetHomepage = () => {
    setIsLoadingMore(true);

    fetchPosts(1, EPostSort.DATE_CREATED)
      .then((posts: IPost[]) => {
        setDisplayedPosts(posts);

        setPage(1);
        setSort(EPostSort.DATE_CREATED);
        setTime(EPostTime.ALL_TIME);
      })
      .catch((e) => {
        console.error(e);

        toast({
          position: 'bottom-right',
          render: () => {
            return (
              <Toast text={'Unable to fetch memes'} type={EToastType.ERROR} />
            );
          }
        });
      })
      .finally(() => {
        setIsLoadingMore(false);
      });
  };

  const loadMorePosts = async () => {
    setIsLoadingMore(true);

    try {
      const posts: IPost[] = await fetchPosts(page + 1, sort);

      if (posts.length === 0) {
        // No new posts to show
        return;
      }

      // Just in case, filter out returned posts that match
      // whatever is displayed
      const newPosts: IPost[] = posts.filter((post) =>
        displayedPosts.every((displayedPost) => displayedPost.id !== post.id)
      );

      if (newPosts.length === 0) {
        // No new posts to show
        return;
      }

      setDisplayedPosts(displayedPosts.concat(newPosts));
      setPage(page + 1);
    } catch (e) {
      console.error(e);

      toast({
        position: 'bottom-right',
        render: () => {
          return (
            <Toast text={'Unable to fetch memes'} type={EToastType.ERROR} />
          );
        }
      });
    } finally {
      setIsLoadingMore(false);
    }
  };

  useEffect(() => {
    setIsLoadingMore(true);

    fetchPosts(1, sort)
      .then((posts: IPost[]) => {
        setDisplayedPosts(posts);
        setPage(1);
      })
      .catch((e) => {
        console.error(e);

        toast({
          position: 'bottom-right',
          render: () => {
            return (
              <Toast text={'Unable to fetch memes'} type={EToastType.ERROR} />
            );
          }
        });
      })
      .finally(() => {
        setIsLoadingMore(false);
      });
  }, [sort, time]);

  return (
    <Box
      display={'flex'}
      flexDirection={'column'}
      width={'100%'}
      minHeight={'100vh'}
      alignItems={'center'}
    >
      <Box mx={10} mt={5} width={isMdOrSmaller ? '95vw' : '60vw'}>
        <Header
          setPostSort={setSort}
          setPostTime={setTime}
          resetHomepage={resetHomepage}
        />
      </Box>
      <Box
        display={'flex'}
        flexDirection={'column'}
        marginLeft={'auto'}
        marginRight={'auto'}
        width={isMdOrSmaller ? '95vw' : '60vw'}
      >
        {displayedPosts.map((post: IPost, index: number) => {
          return (
            <Box key={`${index}-${post.id}`} mt={20} mx={'auto'}>
              <Post post={post} />
            </Box>
          );
        })}
        <Box mx={'auto'} mt={20}>
          <Button
            variant={'buttonPrimary'}
            isLoading={isLoadingMore}
            loadingText="LOADING"
            spinnerPlacement="start"
            onClick={loadMorePosts}
          >
            LOAD MORE
          </Button>
        </Box>
      </Box>
      <Box mx={10} display={'flex'} mb={5} mt={20} justifyContent={'center'}>
        <Footer />
      </Box>
    </Box>
  );
};

export default Home;
