import {NativeModules} from 'react-native';
export const UserState = {
  getUserState: (): Promise<String> => {
    return NativeModules.CielClient.getUserStateClient();
  },
};
