package com.rngrpcapp
import androidx.annotation.NonNull
import com.facebook.react.bridge.*


class CielModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    override fun getName(): String {
        return "CielModule"
    }
    @ReactMethod
    fun getUserState( requestMap : ReadableMap,  responsePromise : Promise) {
        println("calleed getUserState")
    }
}
