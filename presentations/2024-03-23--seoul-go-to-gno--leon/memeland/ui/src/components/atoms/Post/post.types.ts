export interface IPost {
  id: string;
  data: string;
  author: string;
  timestamp: number;
  upvotes: number;
}

export interface IPostProps {
  post: IPost;
}

export const formatUpvotes = (upvotes: number): string => {
  if (upvotes >= 1000000) {
    return (upvotes / 1000000).toFixed(1) + 'M';
  }

  if (upvotes >= 1000) {
    return (upvotes / 1000).toFixed(1) + 'k';
  }

  return upvotes.toString();
};
