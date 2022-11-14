//
//  AuthClient.swift
//  RNGrpcApp
//
//  Created by byeong cheol lim on 2022/11/14.
//

import Foundation
import GRPC
import NIO
@objc(AuthClient) class AuthClient: NSObject {
  var authServiceClient: AuthService_AuthServiceRoutesClient?
  let port: Int = 50051
  @objc static func requiresMainQueueSetup() -> Bool {
    return false
  }
  func createGrpcServiceClient(
    eventLoopGroup: EventLoopGroup
  ) throws -> AuthService_AuthServiceRoutesClient {
    let secureGrpcChannel = try GRPCChannelPool.with(
      target: .host("127.0.0.1", port: port),
      transportSecurity: .plaintext,
      eventLoopGroup: eventLoopGroup
    )
    return AuthService_AuthServiceRoutesClient(
      channel: secureGrpcChannel
    )
  }
  @objc func login(
    _ username: String,
    password: String,
    resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock
  ) {
    let eventLoopGroup = PlatformSupport.makeEventLoopGroup(
      loopCount: 1
    )
    defer {
      try? eventLoopGroup.syncShutdownGracefully()
    }
    let authServiceClient = try? self.createGrpcServiceClient(
      eventLoopGroup: eventLoopGroup
    )
    // build the AccountCredentials object
    let accountCredentials: AuthService_AccountCredentials = .with {
      $0.username = username
      $0.password = password
    }
    // grab the login() method from the gRPC client
    let call = authServiceClient!.login(accountCredentials)
    do {
      let oauthCredentials = try call.response.wait()
      resolve([
        "token": oauthCredentials.token,
        "timeoutSeconds": oauthCredentials.timeoutSecconds
        //"timeoutSeconds": oauthCredentials.timeoutSeconds
      ])
    } catch {
      let error = NSError(domain: "", code: 200, userInfo: nil)
      reject("0", "RPC method ‘login’ failed", error)
    }
    try? authServiceClient!.channel.close().wait()
  }
  @objc func logout(
    _ oauthToken: String,
    resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock
  ) {
    let eventLoopGroup = PlatformSupport.makeEventLoopGroup(
      loopCount: 1
    )
    defer {
      try? eventLoopGroup.syncShutdownGracefully()
    }
    let authServiceClient = try? self.createGrpcServiceClient(
      eventLoopGroup: eventLoopGroup
    )
    // build the OauthCredentials object
    let oauthCredentials: AuthService_OauthCredentials = .with {
      $0.token = oauthToken
    }
    // grab the logout() method from the gRPC client
    let call = authServiceClient!.logout(oauthCredentials)
    // execute the gRPC call and grab the result
    do {
      let logoutResult = try call.response.wait()
      print("Logged out")
      resolve([
        "token": logoutResult.token,
        "timeoutSeconds": oauthCredentials.timeoutSecconds]
      )
    } catch {
      let error = NSError(domain: "", code: 200, userInfo: nil)
      reject("0", "RPC method ‘logout’ failed", error)
    }
  try? authServiceClient!.channel.close().wait()
  }
}
