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
  var cielServiceClient: Frontend_UserServiceClient?
  let port: Int = 8053
  @objc static func requiresMainQueueSetup() -> Bool {
          return false
  }
  func createGrpcServiceClient(
    eventLoopGroup: EventLoopGroup
  ) throws -> Frontend_UserServiceClient {
    let secureGrpcChannel = try GRPCChannelPool.with(
        target: .host("test.2bt.kr", port: port),
        transportSecurity: .plaintext,
        eventLoopGroup: eventLoopGroup
    ) 
    return Frontend_UserServiceClient(channel: secureGrpcChannel)
  }
  func getUserStateClient(
    client: Frontend_UserServiceClient,
    message: String
  ) async throws {
    for try await response in client.getUserState(
      SwiftProtobuf.Google_Protobuf_Empty(),
      callOptions: nil,
      handler: {(res: Frontend_UserStateResponse) -> Void in print(res.textFormatString())}
    ) {
      print("get user state \(response.text)")
    }
  }
}
