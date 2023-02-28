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
import SwiftProtobuf

@objc(CielClient) class CielClient : NSObject{
  let port: Int = 8053
  @objc static func requiresMainQueueSetup() -> Bool {
    return false
  }
  func createGrpcServiceClient(
    eventLoopGroup: EventLoopGroup
  ) throws -> Frontend_UserServiceAsyncClient {
    print("### frontend user  service client starting ...##")
    let secureGrpcChannel = try GRPCChannelPool.with(
      //target: .host("test.2bt.kr", port: port),
      target: .host("127.0.0.1", port: 50051),
      transportSecurity: .plaintext,
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
    defer {
      try? eventLoopGroup.syncShutdownGracefully()
    }
    let cielServiceClient = try? self.createGrpcServiceClient(eventLoopGroup: eventLoopGroup)
    do {
      for try await res in cielServiceClient!.getUserState(Google_Protobuf_Empty()) {
      print("responses : \(res)")
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
