//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: authService.proto
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


/// Usage: instantiate `AuthService_AuthServiceRoutesClient`, then call methods of this protocol to make API calls.
internal protocol AuthService_AuthServiceRoutesClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: AuthService_AuthServiceRoutesClientInterceptorFactoryProtocol? { get }

  func login(
    _ request: AuthService_AccountCredentials,
    callOptions: CallOptions?
  ) -> UnaryCall<AuthService_AccountCredentials, AuthService_OauthCredentials>

  func logout(
    _ request: AuthService_OauthCredentials,
    callOptions: CallOptions?
  ) -> UnaryCall<AuthService_OauthCredentials, AuthService_OauthCredentials>
}

extension AuthService_AuthServiceRoutesClientProtocol {
  internal var serviceName: String {
    return "authService.AuthServiceRoutes"
  }

  /// Unary call to Login
  ///
  /// - Parameters:
  ///   - request: Request to send to Login.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func login(
    _ request: AuthService_AccountCredentials,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<AuthService_AccountCredentials, AuthService_OauthCredentials> {
    return self.makeUnaryCall(
      path: "/authService.AuthServiceRoutes/Login",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLoginInterceptors() ?? []
    )
  }

  /// Unary call to Logout
  ///
  /// - Parameters:
  ///   - request: Request to send to Logout.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func logout(
    _ request: AuthService_OauthCredentials,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<AuthService_OauthCredentials, AuthService_OauthCredentials> {
    return self.makeUnaryCall(
      path: "/authService.AuthServiceRoutes/Logout",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLogoutInterceptors() ?? []
    )
  }
}

internal protocol AuthService_AuthServiceRoutesClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'login'.
  func makeLoginInterceptors() -> [ClientInterceptor<AuthService_AccountCredentials, AuthService_OauthCredentials>]

  /// - Returns: Interceptors to use when invoking 'logout'.
  func makeLogoutInterceptors() -> [ClientInterceptor<AuthService_OauthCredentials, AuthService_OauthCredentials>]
}

internal final class AuthService_AuthServiceRoutesClient: AuthService_AuthServiceRoutesClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: AuthService_AuthServiceRoutesClientInterceptorFactoryProtocol?

  /// Creates a client for the authService.AuthServiceRoutes service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: AuthService_AuthServiceRoutesClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

