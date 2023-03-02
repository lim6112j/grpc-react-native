//
//  CielClient.swift
//  RNGrpcApp
//
//  Created by byeong cheol lim on 2023/02/22.
//

import Foundation
import GRPC
import NIO
import NIOConcurrencyHelpers
import NIOHTTP1
import NIOHPACK
import SwiftProtobuf

@objc(CielClient) class CielClient : NSObject{
  let port: Int = 8053
  let authTokens : String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyVHlwZSI6IjEiLCJ1c2VyQXBwSWR4IjoiMiIsInVzZXJJZHgiOiJZTi9OUTIrODRPUUlkMVhWZHdRZTBRPT0iLCJuYmYiOjE2NzcwMzA1MzcsImV4cCI6MTY3NzAzMDU5NywiaWF0IjoxNjc3MDMwNTM3LCJpc3MiOiJNT0JCTEUyVVNFUkFQSSIsImF1ZCI6InVzZXJBcHBfMiJ9.T6QKUz6puXYKxTU_PT6U1pQ2J57pyY8P-yB1uu6v9E0"
  @objc static func requiresMainQueueSetup() -> Bool {
    return false
  }
  func createGrpcServiceClient(
    eventLoopGroup: EventLoopGroup
  ) throws -> Frontend_UserServiceAsyncClient {
    print("### frontend user  service client starting ...##")
    let secureGrpcChannel = try GRPCChannelPool.with(
      target: .host("test.2bt.kr", port: port),
      //target: .host("127.0.0.1", port: 50051),
      transportSecurity: .tls(GRPCTLSConfiguration.makeClientConfigurationBackedByNIOSSL() ),
      eventLoopGroup: eventLoopGroup
    )
    
    return Frontend_UserServiceAsyncClient(channel: secureGrpcChannel)
  }
  func getUserStateClient(
    _ str: String = ""
  ) async
  {
    print("called from react-native ")
    let eventLoopGroup = PlatformSupport.makeEventLoopGroup(loopCount: 1)
    let httpHeaders = HTTPHeaders([("authorization", "Bearer \(self.authTokens)")])
    let headers = HPACKHeaders(httpHeaders: httpHeaders)
    let calloptions = CallOptions(customMetadata: headers)
    defer {
      try? eventLoopGroup.syncShutdownGracefully()
    }
    let cielServiceClient = try? self.createGrpcServiceClient(eventLoopGroup: eventLoopGroup)

    do {
      for try await res in cielServiceClient!.getUserState(Google_Protobuf_Empty(), callOptions: calloptions) {
        print("responses : \(res.userStateWithInfo)")
    }
    } catch {
      let error = NSError(domain: "", code: 200, userInfo: nil)
    }
  }
  
  @objc func getUserState(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock
  )  {
    Task {
      await getUserStateClient()
    }
    resolve("success")
  }

}
