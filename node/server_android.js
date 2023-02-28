const PROTO_PATH = __dirname + '/../proto/helloworld.proto';
const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');

const packageDefinition = protoLoader.loadSync(
  PROTO_PATH,
  {
    keppCase: true,
    longs: String,
    enums: String,
    defaults: true,
    oneofs: true
  }
)
const protoDescriptior = grpc.loadPackageDefinition(packageDefinition);
const helloworldService = protoDescriptior.helloworld;
const sayHello = (call, callback) => {
  let name = call.request.name
  const message = `Hello , ${name}`
  console.log(`name : '${name}'`)
  callback(null, {message})
}
const sayHelloStream = (call, callback) => {
  let name = call.request.name
  const message = `Hello , ${name}`
  console.log(`name : '${name}'`)
  callback(null, {message})
}
function getGrpcServer() {
  const grpcServer = new grpc.Server()
  grpcServer.addService(helloworldService.Greeter.service, {
    sayHello: sayHello,
  })
  return grpcServer
}
const grpcServer = getGrpcServer()
console.log('Starting gRPC server on port 0.0.0.0:50051....')
grpcServer.bindAsync(
  '0.0.0.0:50051',
  grpc.ServerCredentials.createInsecure(), () => {
    grpcServer.start()
  }
)
