package com.rngrpcapp;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;

public class GreeterModule extends ReactContextBaseJavaModule {
    public GreeterModule(@Nullable ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @NonNull
    @Override
    public String getName() {
        return "Greeter";
    }

    @ReactMethod
    public void sayHello(final ReadableMap requestMap, final Promise responsePromise) {
        new ResponseTask(requestMap, responsePromise).execute();
/*
        String host = "127.0.0.1";
        String port = "50051";
        channel = ManagedChannelBuilder.forAddress(host, Integer.parseInt(port)).usePlaintext().build();
        GreeterGrpc.GreeterBlockingStub stub = GreeterGrpc.newBlockingStub(channel);
        HelloRequest request = HelloRequest.newBuilder().setName(message).build();
        HelloReply reply = stub.sayHello(request);
        return reply.getMessage();
*/
    }
}
