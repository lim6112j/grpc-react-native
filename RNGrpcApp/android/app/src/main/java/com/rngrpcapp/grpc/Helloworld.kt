package com.rngrpcapp.grpc

import android.util.Log
import com.rngrpcapp.grpc.GrpcService
import frontend.Frontend
import io.grpc.stub.StreamObserver
import javax.inject.Inject

@Inject
lateinit var grpcService: GrpcService

fun printHelloworld(){
    Log.d("kotlin test", "asdfasdf");

    grpcService = GrpcService
    grpcService.initGrpc("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyVHlwZSI6IjEiLCJ1c2VyQXBwSWR4IjoiMyIsInVzZXJJZHgiOiJyQXJ6Szh1Z2JGYzYvN28wL0JNQ1JBPT0iLCJuYmYiOjE2NzY5Njc5MjEsImV4cCI6MTY3Njk2Nzk4MSwiaWF0IjoxNjc2OTY3OTIxLCJpc3MiOiJNT0JCTEUyVVNFUkFQSSIsImF1ZCI6InVzZXJBcHBfMyJ9.gOznITQB-rY4z8iiTtKoA-7cFa17LEOufKxDXSHwX20");

    grpcService.getUserState(object : StreamObserver<Frontend.UserStateResponse> {
        override fun onNext(value: Frontend.UserStateResponse?) {
            Log.d("테스트 onNext", value.toString());
        }

        override fun onError(t: Throwable?) {
            Log.d("테스트", t.toString());
        }

        override fun onCompleted() {
            Log.d("테스트", "grpc complete");
        }

    })
}
