const PROTO_PATH = __dirname + '/../proto/authService.proto';
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
const authService = protoDescriptior.authService;
class AuthServer {
  constructor() {
    this.authTokens = {}
    this.activeUsers = {}
  }
  login(username, password) {
    let loginData = {}
    if (username in this.activeUsers) {
      loginData = this.activeUsers[username]
      this.authTokens[loginData.authToken] = loginData
    } else {
      loginData = new AuthLogin(username, password)
      this.authTokens[loginData.authToken] = loginData
      this.activeUsers[username] = loginData.authToken
    }
    const currentTime = new Date()
    const oauthCredentials = {
      token: loginData.authToken,
      timeoutSeconds: Math.floor((loginData.expires - currentTime) / 1000)
    }
    return oauthCredentials
  }
  logout() {
    if (authToken in this.authTokens) {
      const loginData = this.authTokens[authToken]
      delete this.activeUsers[loginData.username]
      delete this.authTokens[authToken]
    }
    return { token: '', timeoutSeconds: 0 }
  }
}

class AuthLogin {
  constructor(username, password) {
    this.username = username
    this.authToken = Math.random().toString(16).substr(2, 8)
    this.refreshExpiration()
  }
  refreshExpiration() {
    const currentTime = new Data()
    this.expires = currentTime.setDate(currentTime.getDate() + 1)
  }
}
const authServer = new AuthServer()

const login = (call, callback) => {
  let username = call.request.username
  let password = call.request.password
  console.log(`Login for username : '${username}'`)
  const authData = authServer.login(username, password)
  callback(null, authData)
}
const logout = (call, callback) => {
  let authToken = call.request.token
  console.log(`Logout for token: '${authToken}'`)
  const authData = authServer.logout(authToken)
  callback(null, authData)
}
function getGrpcServer() {
  const grpcServer = new grpc.Server()
  grpcServer.addService(authService.AuthServiceRoutes.service, {
    login: login,
    logout: logout
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
