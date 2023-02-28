//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: route_guide.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Interface exported by the server.
///
/// Usage: instantiate `Routeguide_RouteGuideClient`, then call methods of this protocol to make API calls.
internal protocol Routeguide_RouteGuideClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? { get }

  func getFeature(
    _ request: Routeguide_Point,
    callOptions: CallOptions?
  ) -> UnaryCall<Routeguide_Point, Routeguide_Feature>

  func listFeatures(
    _ request: Routeguide_Rectangle,
    callOptions: CallOptions?,
    handler: @escaping (Routeguide_Feature) -> Void
  ) -> ServerStreamingCall<Routeguide_Rectangle, Routeguide_Feature>

  func recordRoute(
    callOptions: CallOptions?
  ) -> ClientStreamingCall<Routeguide_Point, Routeguide_RouteSummary>

  func routeChat(
    callOptions: CallOptions?,
    handler: @escaping (Routeguide_RouteNote) -> Void
  ) -> BidirectionalStreamingCall<Routeguide_RouteNote, Routeguide_RouteNote>
}

extension Routeguide_RouteGuideClientProtocol {
  internal var serviceName: String {
    return "routeguide.RouteGuide"
  }

  /// A simple RPC.
  ///
  /// Obtains the feature at a given position.
  ///
  /// A feature with an empty name is returned if there's no feature at the given
  /// position.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetFeature.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getFeature(
    _ request: Routeguide_Point,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Routeguide_Point, Routeguide_Feature> {
    return self.makeUnaryCall(
      path: "/routeguide.RouteGuide/GetFeature",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetFeatureInterceptors() ?? []
    )
  }

  /// A server-to-client streaming RPC.
  ///
  /// Obtains the Features available within the given Rectangle.  Results are
  /// streamed rather than returned at once (e.g. in a response message with a
  /// repeated field), as the rectangle may cover a large area and contain a
  /// huge number of features.
  ///
  /// - Parameters:
  ///   - request: Request to send to ListFeatures.
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
  internal func listFeatures(
    _ request: Routeguide_Rectangle,
    callOptions: CallOptions? = nil,
    handler: @escaping (Routeguide_Feature) -> Void
  ) -> ServerStreamingCall<Routeguide_Rectangle, Routeguide_Feature> {
    return self.makeServerStreamingCall(
      path: "/routeguide.RouteGuide/ListFeatures",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeListFeaturesInterceptors() ?? [],
      handler: handler
    )
  }

  /// A client-to-server streaming RPC.
  ///
  /// Accepts a stream of Points on a route being traversed, returning a
  /// RouteSummary when traversal is completed.
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata, status and response.
  internal func recordRoute(
    callOptions: CallOptions? = nil
  ) -> ClientStreamingCall<Routeguide_Point, Routeguide_RouteSummary> {
    return self.makeClientStreamingCall(
      path: "/routeguide.RouteGuide/RecordRoute",
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRecordRouteInterceptors() ?? []
    )
  }

  /// A Bidirectional streaming RPC.
  ///
  /// Accepts a stream of RouteNotes sent while a route is being traversed,
  /// while receiving other RouteNotes (e.g. from other users).
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata and status.
  internal func routeChat(
    callOptions: CallOptions? = nil,
    handler: @escaping (Routeguide_RouteNote) -> Void
  ) -> BidirectionalStreamingCall<Routeguide_RouteNote, Routeguide_RouteNote> {
    return self.makeBidirectionalStreamingCall(
      path: "/routeguide.RouteGuide/RouteChat",
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRouteChatInterceptors() ?? [],
      handler: handler
    )
  }
}

internal protocol Routeguide_RouteGuideClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'getFeature'.
  func makeGetFeatureInterceptors() -> [ClientInterceptor<Routeguide_Point, Routeguide_Feature>]

  /// - Returns: Interceptors to use when invoking 'listFeatures'.
  func makeListFeaturesInterceptors() -> [ClientInterceptor<Routeguide_Rectangle, Routeguide_Feature>]

  /// - Returns: Interceptors to use when invoking 'recordRoute'.
  func makeRecordRouteInterceptors() -> [ClientInterceptor<Routeguide_Point, Routeguide_RouteSummary>]

  /// - Returns: Interceptors to use when invoking 'routeChat'.
  func makeRouteChatInterceptors() -> [ClientInterceptor<Routeguide_RouteNote, Routeguide_RouteNote>]
}

internal final class Routeguide_RouteGuideClient: Routeguide_RouteGuideClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol?

  /// Creates a client for the routeguide.RouteGuide service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Routeguide_RouteGuideClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}
