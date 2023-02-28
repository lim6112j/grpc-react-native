const PROTO_PATH = __dirname + '/../proto/route_guide.proto';
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
const routeGuide = protoDescriptior.routeguide;
