package com.rngrpcapp;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;

import java.io.IOException;
import java.lang.reflect.AccessibleObject;
import java.net.URL;
import java.util.Map;
import java.util.HashMap;

import okhttp3.Headers;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class AuthModule extends ReactContextBaseJavaModule {
    private final OkHttpClient client = new OkHttpClient();
    AuthModule(ReactApplicationContext context) {
        super(context);
    }
    @Override
    public String getName() {
        return "AuthModule";
    }
}