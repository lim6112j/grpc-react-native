package com.rngrpcapp;

import static com.rngrpcapp.GRPCPackage.HOST;
import static com.rngrpcapp.GRPCPackage.PORT;
import static com.rngrpcapp.GRPCPackage.USE_PLAINTEXT;

import android.os.AsyncTask;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.concurrent.TimeUnit;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;

public class ResponseTask extends AsyncTask<Void, Void, ResponseOrException> {
    private final Promise responsePromise;
    private final ReadableMap requestMap;
    private ManagedChannel channel;

    protected ResponseTask(ReadableMap requestMap, Promise responsePromise) {
        this.responsePromise = responsePromise;
        this.requestMap = requestMap;
    }

    protected ManagedChannel getChannel() {
        return channel;
    }

    @Override
    protected ResponseOrException doInBackground(Void... nothing) {
        try {
            channel = ManagedChannelBuilder.forAddress(HOST, PORT).usePlaintext().build();
           return new ResponseOrException(getResponse(channel));
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            pw.flush();

            return new ResponseOrException(e);
        }
    }

    @Override
    protected void onPostExecute(ResponseOrException response) {
        try {
            channel.shutdown().awaitTermination(1, TimeUnit.SECONDS);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        if (response.hasResponse()) {
            responsePromise.resolve(response.getResponse());
        } else {
            responsePromise.reject(response.getException());
        }
    }

    protected WritableMap getResponse(ManagedChannel channel){
        HelloRequest request = HelloRequest.newBuilder().setName(requestMap.getString("name")).build();
        GreeterGrpc.GreeterBlockingStub stub = GreeterGrpc.newBlockingStub(channel);
        HelloReply reply = stub.sayHello(request);
        WritableMap response = new WritableNativeMap();
        response.putString("message", reply.getMessage());
        return response;
    };

}
