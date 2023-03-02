package com.rngrpcapp;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class GRPCPackage implements ReactPackage {
    //public static final String HOST = "test.2bt.kr";
    //public static final int PORT = 8053;
    public static final String HOST = "127.0.0.1";
    public static final int PORT = 50051;
    public static final boolean USE_PLAINTEXT = true;

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        return Collections.emptyList();
    }

    @Override
    public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
        List<NativeModule> modules = new ArrayList<>();

        modules.add(new CielModule(reactContext));

        return modules;
    }
}
