const PROTO_PATH = __dirname + '/../proto/cielService.proto';
const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
var _ = require('lodash');
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
const frontend = protoDescriptior.frontend;
var userStateList = [1,2,3,4,5]
function getUserState(call) {
  console.log("called getuserstate")
  _.each(userStateList, function(state) {
    call.write(state);
  })
  call.end();
}
function getServer() {
  var server = new grpc.Server();
  server.addService(frontend.UserService.service, {
    getUserState: getUserState
  });
  return server;
}

var cielServer = getServer();
console.log('Starting gRPC server on port 0.0.0.0:50051....')
cielServer.bindAsync(
  '0.0.0.0:50051',
  grpc.ServerCredentials.createInsecure(), () => {
    cielServer.start()
  }
)
