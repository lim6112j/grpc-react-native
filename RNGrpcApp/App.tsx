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

import React, { useState } from 'react';
import { Button, NativeModules, Alert } from 'react-native';
import { Greeter } from './helloworld';
import {UserState} from './cielclient';
const { AuthClient } = NativeModules;
import {
    SafeAreaView,
    Text,
    TextInput,
} from 'react-native';

async function doRpc() {
    try {
        const response = await Greeter.sayHello({ name: 'Ciel Company' });
        Alert.alert('android grpc response', response.message);
    } catch (e: any) {
        Alert.alert('error', e.message);
    }
}
doRpc();
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
            const stateVar = await UserState.getUserState();
            console.log('userstate response', stateVar);
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
                onPress={() => { login(username, password); }}
            />
            <Button
                title="Logout"
                onPress={() => { logout(oauthToken); }}
            />
            <Button
                title="getUserState"
                onPress={() => { userState("test"); }}
            />
            <Text>Oauth Token: {oauthToken}</Text>
        </SafeAreaView>
    );
};

export default App;
