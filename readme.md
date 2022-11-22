* [gRPC with react-native IOS 참조](https://gaitatzis.medium.com/building-a-grpc-server-in-nodejs-e3ccdd93a0f)
* [gRPC with react-native android 참조](https://medium.com/xebia/first-steps-in-grpc-bindings-for-react-native-32bb97115eed)
* grpc-swift install - 프로젝트 폴더에 아래 명령을 수행해서 proto generator 를 설치한다.(ios에서 proto 기반 swift generation에 필요)

        $ git clone https://github.com/grpc/grpc-swift
        $ cd grpc-swift
        $ git checkout 586000 (podfile grpc-swift version matching)
        $ make plugins
        $ cp .build/release/protoc-gen-swift .build/release/protoc-gen-grpc-swift /usr/local/bin

* compile proto file(ios에서 사용함)

        protoc authService.proto \
        --grpc-swift_opt=Client=true,Server=false \
        --grpc-swift_out=ios \
        --proto_path=../proto \
        --swift_opt=Visibility=Public \
        --swift_out=ios

* ios : podfile 세팅 체크
* android : build.gradle(project), build.gradle(app), settings.gradle(project) 체크
 
* how to run IOS
  1. download zip file
  1. cd node folder
  1. in terminal : yarn or npm install
  1. in terminal : node server.js
  1. cd RNGrpcApp
  1. in terminal : yarn or npm install
  1. cd RNGrpcApp/ios
  1. in terminal : bundle install
  1. in terminal : pod install
  1. cd RNGrpcApp
  1. npx react-native run-ios
  1. login button click, credential print 체크

* how to run android 
  1. cd node folder
  1. in terminal : node server_android.js
  1. cd RNGrpcApp
  1. in terminal : yarn or npm install
  1. npx react-native run-android
  1. check alert ciel companyd
  1. check the server ip : GRPCPackage.java 
  
        public class GRPCPackage implements ReactPackage {
            public static final String HOST = "172.30.1.48"; // your local ip
            public static final int PORT = 50051;
            public static final boolean USE_PLAINTEXT = true;

* how to change proto file - ios 
  1. compile protoc files (아래 참조)
  1. 위에서 생성된 swift file을 xcode를 열어 project_name/project_name 아래 복사(copy option default)
  1. newproto.swift, newproto.m file 생성
  1. cd RNGrpcApp
  1. npx react-native run-ios
  
* how to change proto file - android 
  1. copy protofile into project/android/app/src/java/main/proto/ (proto folder should make)
  1. ios와 달리 안드로이드에서는 proto file에 따라 자동으로 java class가 생성된다.
  1. proto에 맞게 구동 java 클래스를 코딩한다.d
  1. cd RNGrpcApp
  1. cd node
  1. 변경된 proto에 맞게 server 를 작성하고 실행한다.
  1. npx react-native run-android

* 주요 이슈
  1. mac M1 chip의 경우 세팅이 조금 추가된다. 소스 참조
  2. ios, android 공히 세팅이 불편하다. 가능하면 소스에 사용된 버전의 frameworks들을 사용하고 익숙해지면 버전을 바꿔본다.
  



* how to run

        // run server
        cd node
        yarn or npm install
        node server
        // run ios App
        cd RNGrpcApp/ios
        bundle install
        pod install
        cd RNGrpcApp
        npx react-native run-ios
