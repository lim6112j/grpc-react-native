package com.rngrpcapp.grpc

import android.util.Log
import com.rngrpcapp.grpc.GrpcService
import frontend.Frontend
import frontend.Frontend.SupplyLocationRequest
import io.grpc.stub.StreamObserver
import javax.inject.Inject

@Inject
lateinit var grpcService: GrpcService

fun grpcSmaple(){
    Log.d("kotlin test", "asdfasdf");

    //grpc 객체 초기화 (토큰을 입력하도록 함)
    grpcService = GrpcService
    grpcService.initGrpc("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyVHlwZSI6IjEiLCJ1c2VyQXBwSWR4IjoiMyIsInVzZXJJZHgiOiJyQXJ6Szh1Z2JGYzYvN28wL0JNQ1JBPT0iLCJuYmYiOjE2NzY5Njc5MjEsImV4cCI6MTY3Njk2Nzk4MSwiaWF0IjoxNjc2OTY3OTIxLCJpc3MiOiJNT0JCTEUyVVNFUkFQSSIsImF1ZCI6InVzZXJBcHBfMyJ9.gOznITQB-rY4z8iiTtKoA-7cFa17LEOufKxDXSHwX20");

    getUserState()
    getSupplyState(8)
}

fun getUserState(){
    grpcService.getUserState(object : StreamObserver<Frontend.UserStateResponse> {
        override fun onNext(value: Frontend.UserStateResponse?) {
            //Log.d("테스트 onNext", value.toString());

            //전역 데이터에 값 입력
            value?.let {
                grpcService.userStateData = it
            }
            Log.d("테스트 onNext", grpcService.userStateData.toString())
        }

        override fun onError(t: Throwable?) {
            Log.d("테스트 onError", t.toString());
        }

        override fun onCompleted() {
            Log.d("테스트 onComplete", "grpc complete");
        }
    })
}

fun getSupplyState(_supplyIdx: Int){
    grpcService.getSupplyLocation(object :StreamObserver<Frontend.SupplyLocationResponse>{
        override fun onNext(value: Frontend.SupplyLocationResponse?) {
            value?.let {
                grpcService.supplyLocationData = it
            }
            Log.d("테스트 onNext", grpcService.supplyLocationData.toString())
        }

        override fun onError(t: Throwable?) {
            Log.d("테스트 onError", "error while getSupplyLocation")

        }

        override fun onCompleted() {
            Log.d("테스트 onCompleted", "getSupplyLocation completed")
        }

    })

    //전송할 데이터 설정
    grpcService.supplyLocationObserver.onNext(
        Frontend.GetSupplyLocationRequest.newBuilder()
            .setSupplyIdx(_supplyIdx)
            .build()
    )
    //grpcService.get
}