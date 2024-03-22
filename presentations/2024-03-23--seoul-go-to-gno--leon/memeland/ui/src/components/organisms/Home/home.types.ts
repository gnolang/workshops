import { IPost } from '../../atoms/Post/post.types.ts';

export interface IHomeProps {}

export enum EPostSort {
  UPVOTES = 'UPVOTES',
  DATE_CREATED = 'DATE_CREATED'
}

export enum EPostTime {
  ALL_TIME,
  TWO_WEEKS,
  THREE_MONTHS,
  ONE_YEAR
}

export const constructStartTimestamp = (time: EPostTime): number => {
  let date: Date = new Date();

  switch (time) {
    case EPostTime.ALL_TIME:
      date = new Date(0); // zero time

      break;
    case EPostTime.TWO_WEEKS:
      date.setDate(date.getDate() - 14);

      break;
    case EPostTime.THREE_MONTHS:
      date.setMonth(date.getMonth() - 3);

      break;
    case EPostTime.ONE_YEAR:
      date.setFullYear(date.getFullYear() - 1);

      break;
  }

  return Math.floor(date.getTime() / 1000);
};

export const parsePostFetchResponse = (response: string): IPost[] => {
  const regex = /\("(.*)".*\)/;
  const match = response.match(regex);

  if (!match || match.length < 2) {
    throw new Error('invalid post response');
  }

  const cleanResponse: string = match[1].replace(/\\"/g, '"');

  return JSON.parse(cleanResponse);
};
