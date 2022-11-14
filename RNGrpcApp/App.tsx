/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React, { useContext, useState } from 'react';
import { Button, NativeModules } from 'react-native';
const { AuthClient } = NativeModules;
import {
    SafeAreaView,
    StatusBar,
    StyleSheet,
    Text,
    TextInput,
    useColorScheme,
    View,
} from 'react-native';

import {
    Colors,
    DebugInstructions,
    Header,
    LearnMoreLinks,
    ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

const App = () => {
    const [username, setUsername] = useState('email@example.com')
    const [password, setPassword] = useState('password')
    const [oauthToken, setOauthToken] = useState('')
    const login = async (username: String, password: String) => {
        try {
            const oauthData = await AuthClient.login(username, password)
            setOauthToken(oauthData.token)
        } catch (error: any) {
            console.log(error)
            console.log(error.message)
        }
    }
    const logout = async (oauthToken: String) => {
        await AuthClient.logout(oauthToken)
        setOauthToken('')
    }
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
                onPress={() => { login(username, password) }}
            />
            <Button
                title="Logout"
                onPress={() => { logout(oauthToken) }}
            />
            <Text>Oauth Token: {oauthToken}</Text>
        </SafeAreaView>
    )
};

export default App;
