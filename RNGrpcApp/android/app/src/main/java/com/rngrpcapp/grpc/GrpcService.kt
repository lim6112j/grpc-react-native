package com.rngrpcapp.grpc

import android.util.Log
import com.google.protobuf.Empty
import com.rngrpcapp.BuildConfig
import frontend.Frontend
import frontend.Frontend.UserStateResponse
//import frontend.FrontEndGrpc
//import frontend.Frontend
import frontend.UserServiceGrpc
import frontend.UserServiceGrpc.UserServiceStub
import frontend.SupplyServiceGrpc
import frontend.SupplyServiceGrpc.SupplyServiceStub
import io.grpc.*
import io.grpc.stub.AbstractAsyncStub
import io.grpc.stub.StreamObserver
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.asExecutor
import org.json.JSONObject
import java.io.Closeable
import javax.inject.Inject

//싱글톤 객체
object GrpcService: Closeable {
    var url:String? = null;
    var post:String? = null;
    var isDebug:Boolean = true;

    //jsonObject 데이터 변수
    var userStateData = JSONObject();

    //grpc 통신 observer
    private lateinit var userStateObserver: StreamObserver<UserStateResponse>


    private var originChannel: ManagedChannel? = null;
    private lateinit var asyncStub: UserServiceGrpc.UserServiceStub;

    fun initGrpc(_accessToken:String) {
        //채널이 살아 있으면 즉시 종료 함.
        //Log.d("grpc channel-userState",  "채널 열림? "+ originChannel?.isShutdown.toString())
        originChannel?.let {
            if (!it.isShutdown){
                //it.shutdownNow()
                return
            }
        }

        // 채널 생성
        originChannel = let {
            val builder = ManagedChannelBuilder.forAddress(

                BuildConfig.GRPC_URL,
                if (BuildConfig.GRPC_USE_HTTPS) BuildConfig.GRPC_PORT_HTTPS else BuildConfig.GRPC_PORT_HTTP
            )

            // TLS 사용 시
            if (BuildConfig.GRPC_USE_HTTPS) {
                builder.useTransportSecurity()
            } else {
                builder.usePlaintext()
            }

            builder.executor(Dispatchers.IO.asExecutor()).build()
        }

        // stub 세팅
        // gRPC MetaData 에 accesstk 넣기
        // TODO: accesstk 가 없는 경우, (로그아웃 후 앱 종료 -> 앱 재실행)
        //  null 인 경우 header 에 현재 "" 으로 넣고있음
        //  추가로 gRPC Error Handling 필요
        asyncStub = UserServiceGrpc.newStub(
            ClientInterceptors.intercept(
                originChannel,
                HeaderClientInterceptor(_accessToken)))

    }

    override fun close() {
        //Log.d(TAG_GRPC, "close()")

        // 채널이 닫혀있는지 체크
        // isShutdown -> 채널이 종료 여부 반환. 종료 채널은 새로운 call 을 즉시 취소하지만 일부 통화는 여전히 처리 중일 수 있음.
        // isTerminated -> 채널이 종료 여부를 반환. 종료된 채널에는 실행 중인 호출이 없고 관련 리소스(예: TCP 연결)가 해제됩니다.
        // shutdownNow() -> 기존 및 새 call 이 취소되는 강제 종료를 시작.
        originChannel?.let {
            if (!it.isShutdown){
                it.shutdownNow()
            }
        }

        // 채널 셧다운
        originChannel?.shutdownNow();
    }

    fun getUserState(observer: StreamObserver<Frontend.UserStateResponse>) {
        asyncStub.getUserState(Empty.newBuilder().build(), observer)
    }

}