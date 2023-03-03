/* eslint-disable @typescript-eslint/no-shadow */
/* eslint-disable prettier/prettier */
/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React, {useState} from 'react';
import {Button, NativeModules, Alert, Platform} from 'react-native';
import {UserState, UserModule} from './cielclient';
const {AuthClient} = NativeModules;
import {SafeAreaView, Text, TextInput} from 'react-native';

const App = () => {
  const [username, setUsername] = useState('email@example.com');
  const [password, setPassword] = useState('password');
  const [oauthToken, setOauthToken] = useState('');
  const login = async (username: String, password: String) => {
    try {
      const oauthData = await AuthClient.login(username, password);
      setOauthToken(oauthData.token);
    } catch (error: any) {
      console.log(error);
      console.log(error.message);
    }
  };
  const logout = async (oauthToken: String) => {
    await AuthClient.logout(oauthToken);
    setOauthToken('');
  };
  const userState = async (param: any) => {
    console.log('calling getUserState !!!!', param);
    try {
      const stateVar =
        Platform.OS === 'ios'
          ? await UserState.getUserState()
          : await UserModule.getUserState();
      console.log('userstate response', stateVar);
    } catch (error: any) {
      console.log(error);
      console.log(error.message);
    }
  };

  const supplyState = async (param: any) => {
    console.log('calling getSupplyState !!!!', param);
    try {
      const stateVar =
        Platform.OS === 'ios'
          ? await UserState.getSupplyState()
          : await UserModule.getSupplyState(6);
      console.log('supplyState response', stateVar);
    } catch (error: any) {
      console.log(error);
      console.log(error.message);
    }
  };
  return (
    <SafeAreaView>
      <TextInput
        placeholder="Email"
        autoCapitalize="none"
        value={username}
        onChangeText={setUsername}
      />
      <TextInput
        placeholder="Password"
        autoCapitalize="none"
        value={password}
        onChangeText={setPassword}
      />
      <Button
        title="Login"
        onPress={() => {
          login(username, password);
        }}
      />
      <Button
        title="Logout"
        onPress={() => {
          logout(oauthToken);
        }}
      />
      <Button
        title="getUserState"
        onPress={() => {
          userState('test');
        }}
      />
      <Button
        title="getSupplyState"
        onPress={() => {
          supplyState('test');
        }}
      />
      <Text>Oauth Token: {oauthToken}</Text>
    </SafeAreaView>
  );
};

export default App;
