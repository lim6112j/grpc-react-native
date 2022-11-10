// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: authService.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public struct AuthService_AccountCredentials {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var username: String = String()

  public var password: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct AuthService_OauthCredentials {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var token: String = String()

  public var timeoutSecconds: UInt32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension AuthService_AccountCredentials: @unchecked Sendable {}
extension AuthService_OauthCredentials: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "authService"

extension AuthService_AccountCredentials: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".AccountCredentials"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "username"),
    2: .same(proto: "password"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.username) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.password) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.username.isEmpty {
      try visitor.visitSingularStringField(value: self.username, fieldNumber: 1)
    }
    if !self.password.isEmpty {
      try visitor.visitSingularStringField(value: self.password, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: AuthService_AccountCredentials, rhs: AuthService_AccountCredentials) -> Bool {
    if lhs.username != rhs.username {return false}
    if lhs.password != rhs.password {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension AuthService_OauthCredentials: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".OauthCredentials"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    3: .same(proto: "token"),
    4: .same(proto: "timeoutSecconds"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 3: try { try decoder.decodeSingularStringField(value: &self.token) }()
      case 4: try { try decoder.decodeSingularUInt32Field(value: &self.timeoutSecconds) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.token.isEmpty {
      try visitor.visitSingularStringField(value: self.token, fieldNumber: 3)
    }
    if self.timeoutSecconds != 0 {
      try visitor.visitSingularUInt32Field(value: self.timeoutSecconds, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: AuthService_OauthCredentials, rhs: AuthService_OauthCredentials) -> Bool {
    if lhs.token != rhs.token {return false}
    if lhs.timeoutSecconds != rhs.timeoutSecconds {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
