import { EPostSort, EPostTime } from '../../organisms/Home/home.types.ts';

export interface IHeaderProps {
  setPostSort: (type: EPostSort) => void;
  setPostTime: (time: EPostTime) => void;
  resetHomepage: () => void;
}
