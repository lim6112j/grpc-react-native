* [gRPC with react-native ](https://gaitatzis.medium.com/building-a-grpc-server-in-nodejs-e3ccdd93a0f)
* compile proto file

            protoc authService.proto \
            --grpc-swift_opt=Client=true,Server=false \
            --grpc-swift_out=ios \
            --proto_path=../proto \
            --swift_opt=Visibility=Public \
            --swift_out=ios
