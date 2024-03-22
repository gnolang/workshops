export enum EToastType {
  SUCCESS,
  ERROR
}

export interface IToastProps {
  text: string;
  type: EToastType;
}
