import {NativeModules} from 'react-native';
export const UserState = {
  getUserState: (): Promise<String> => {
    return NativeModules.CielClient.getUserState();
  },
};
export const UserModule = {
  getUserState: (): Promise<String> => {
    return NativeModules.CielModule.getUserState();
  },
  getSupplyState: (supplyIdx: number): Promise<String> => {
    return NativeModules.CielModule.getSupplyState(supplyIdx);
  },
};
