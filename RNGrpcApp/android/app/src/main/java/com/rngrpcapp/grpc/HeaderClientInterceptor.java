/*
 * Copyright 2015 The gRPC Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.rngrpcapp.grpc;

import com.google.common.annotations.VisibleForTesting;
import io.grpc.CallOptions;
import io.grpc.Channel;
import io.grpc.ClientCall;
import io.grpc.ClientInterceptor;
import io.grpc.ForwardingClientCall.SimpleForwardingClientCall;
import io.grpc.ForwardingClientCallListener.SimpleForwardingClientCallListener;
import io.grpc.Metadata;
import io.grpc.MethodDescriptor;
import java.util.logging.Logger;

/**
 * A interceptor to handle client header.
 * HeaderClientInterceptor 는 grpc 헤더에 토큰을 넣기 커스터 마이징 클래스
 */
public class HeaderClientInterceptor implements ClientInterceptor {

    public HeaderClientInterceptor(String accesstk){
        this.accesstk = accesstk;
    }
    private String accesstk = null;
    private static final Logger logger = Logger.getLogger(HeaderClientInterceptor.class.getName());

    @VisibleForTesting
    static final Metadata.Key<String> AUTHORIZATION = Metadata.Key.of("Authorization", Metadata.ASCII_STRING_MARSHALLER);

    @Override
    public <ReqT, RespT> ClientCall<ReqT, RespT> interceptCall(MethodDescriptor<ReqT, RespT> method, CallOptions callOptions, Channel next) {
        return new SimpleForwardingClientCall<ReqT, RespT>(next.newCall(method, callOptions)) {

            @Override
            public void start(Listener<RespT> responseListener, Metadata headers) {
                /* put custom header */
                // TODO: 현재 서버에서 작업 중인 부분 완료 후에 Authorization 으로 변경하기
                //  현재 구조에서는 Header 에 { accesstk : ${token} } 을 넣어서 요청 & 응답. (토큰 인증 없음)
                headers.put(AUTHORIZATION, accesstk == null ? "" : "Bearer " + accesstk); // 토큰 추가 내용
                super.start(new SimpleForwardingClientCallListener<RespT>(responseListener) {
                    @Override
                    public void onHeaders(Metadata headers) {
                        /**
                         * if you don't need receive header from server,
                         * you can use {@link io.grpc.stub.MetadataUtils#attachHeaders}
                         * directly to send header
                         */
                        logger.info("header received from server:" + headers);
                        super.onHeaders(headers);
                    }
                }, headers);
            }
        };
    }
}


