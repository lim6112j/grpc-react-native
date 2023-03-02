package com.rngrpcapp
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.Promise


class CielModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    override fun getName(): String {
        return "Ciel"
    }
    @ReactMethod
    fun getUserState( requestMap : ReadableMap,  responsePromise : Promise) {
        ResponseTask(requestMap, responsePromise)
    }
}
