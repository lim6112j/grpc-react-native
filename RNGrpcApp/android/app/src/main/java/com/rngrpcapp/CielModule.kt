package com.rngrpcapp
import android.util.Log
import com.facebook.react.bridge.*
import com.rngrpcapp.grpc.GrpcService
import com.rngrpcapp.grpc.grpcService
import frontend.Frontend
import io.grpc.stub.StreamObserver

class CielModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    override fun getName(): String {
        return "CielModule"
    }
    @ReactMethod
    fun getUserState(promise: Promise){

      Log.d("getUserState", "called UserState")
      grpcService = GrpcService
      grpcService.initGrpc("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyVHlwZSI6IjEiLCJ1c2VyQXBwSWR4IjoiMyIsInVzZXJJZHgiOiJyQXJ6Szh1Z2JGYzYvN28wL0JNQ1JBPT0iLCJuYmYiOjE2NzY5Njc5MjEsImV4cCI6MTY3Njk2Nzk4MSwiaWF0IjoxNjc2OTY3OTIxLCJpc3MiOiJNT0JCTEUyVVNFUkFQSSIsImF1ZCI6InVzZXJBcHBfMyJ9.gOznITQB-rY4z8iiTtKoA-7cFa17LEOufKxDXSHwX20");
        grpcService.getUserState(object : StreamObserver<Frontend.UserStateResponse> {
            override fun onNext(value: Frontend.UserStateResponse?) {
                //Log.d("테스트 onNext", value.toString());

                //전역 데이터에 값 입력
                value?.let {
                    grpcService.userStateData = it
                }
                Log.d("테스트 onNext", grpcService.userStateData.toString())
                promise.resolve(grpcService.userStateData.toString())
            }

            override fun onError(t: Throwable?) {
                Log.d("테스트 onError", t.toString());
                promise.reject("error while userState")
            }

            override fun onCompleted() {
                Log.d("테스트 onComplete", "grpc complete");
                //promise.resolve(grpcService.userStateData.toString())
            }
        })
    }
    @ReactMethod
    fun getSupplyState(_supplyIdx: Int, promise: Promise) {
        grpcService = GrpcService
        grpcService.initGrpc("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyVHlwZSI6IjEiLCJ1c2VyQXBwSWR4IjoiMyIsInVzZXJJZHgiOiJyQXJ6Szh1Z2JGYzYvN28wL0JNQ1JBPT0iLCJuYmYiOjE2NzY5Njc5MjEsImV4cCI6MTY3Njk2Nzk4MSwiaWF0IjoxNjc2OTY3OTIxLCJpc3MiOiJNT0JCTEUyVVNFUkFQSSIsImF1ZCI6InVzZXJBcHBfMyJ9.gOznITQB-rY4z8iiTtKoA-7cFa17LEOufKxDXSHwX20");
        //전송할 데이터 설정
        grpcService.supplyLocationObserver.onNext(
            Frontend.GetSupplyLocationRequest.newBuilder()
                .setSupplyIdx(_supplyIdx)
                .build()
        )
        grpcService.getSupplyLocation(object :StreamObserver<Frontend.SupplyLocationResponse>{
            override fun onNext(value: Frontend.SupplyLocationResponse?) {
                value?.let {
                    grpcService.supplyLocationData = it
                }
                Log.d("테스트 onNext", grpcService.supplyLocationData.toString())
            }

            override fun onError(t: Throwable?) {
                Log.d("테스트 onError", "error while getSupplyLocation")
                promise.reject("getSupplyLocation request error")
            }

            override fun onCompleted() {
                Log.d("테스트 onCompleted", "getSupplyLocation completed")
                promise.resolve(grpcService.supplyLocationData.toString())
            }

        })
    }
}
