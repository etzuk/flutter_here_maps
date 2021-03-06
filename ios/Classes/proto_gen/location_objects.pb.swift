// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: location_objects.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct FlutterHereMaps_LocationReading {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var coordinate: FlutterHereMaps_Coordinate {
    get {return _storage._coordinate ?? FlutterHereMaps_Coordinate()}
    set {_uniqueStorage()._coordinate = newValue}
  }
  /// Returns true if `coordinate` has been explicitly set.
  var hasCoordinate: Bool {return _storage._coordinate != nil}
  /// Clears the value of `coordinate`. Subsequent reads from it will return its default value.
  mutating func clearCoordinate() {_uniqueStorage()._coordinate = nil}

  var altitude: Double {
    get {return _storage._altitude}
    set {_uniqueStorage()._altitude = newValue}
  }

  var heading: Double {
    get {return _storage._heading}
    set {_uniqueStorage()._heading = newValue}
  }

  var accuracy: Double {
    get {return _storage._accuracy}
    set {_uniqueStorage()._accuracy = newValue}
  }

  var speed: Double {
    get {return _storage._speed}
    set {_uniqueStorage()._speed = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct FlutterHereMaps_AndroidIconData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var iconName: String = String()

  var iconType: FlutterHereMaps_AndroidIconData.TypeEnum = .unknown

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum TypeEnum: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case unknown // = 0
    case mipmap // = 1
    case drawable // = 2
    case UNRECOGNIZED(Int)

    init() {
      self = .unknown
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .unknown
      case 1: self = .mipmap
      case 2: self = .drawable
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .unknown: return 0
      case .mipmap: return 1
      case .drawable: return 2
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  init() {}
}

#if swift(>=4.2)

extension FlutterHereMaps_AndroidIconData.TypeEnum: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [FlutterHereMaps_AndroidIconData.TypeEnum] = [
    .unknown,
    .mipmap,
    .drawable,
  ]
}

#endif  // swift(>=4.2)

struct FlutterHereMaps_AndroidLocationSettings {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var notificationSettings: FlutterHereMaps_AndroidLocationSettings.LocationNotificationSettings {
    get {return _storage._notificationSettings ?? FlutterHereMaps_AndroidLocationSettings.LocationNotificationSettings()}
    set {_uniqueStorage()._notificationSettings = newValue}
  }
  /// Returns true if `notificationSettings` has been explicitly set.
  var hasNotificationSettings: Bool {return _storage._notificationSettings != nil}
  /// Clears the value of `notificationSettings`. Subsequent reads from it will return its default value.
  mutating func clearNotificationSettings() {_uniqueStorage()._notificationSettings = nil}

  var locationMethod: FlutterHereMaps_AndroidLocationSettings.LocationMethod {
    get {return _storage._locationMethod}
    set {_uniqueStorage()._locationMethod = newValue}
  }

  var locationServiceID: Int32 {
    get {return _storage._locationServiceID}
    set {_uniqueStorage()._locationServiceID = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum LocationMethod: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case none // = 0
    case gps // = 1
    case network // = 2
    case gpsNetwork // = 3
    case gpsNetworkIndoor // = 4
    case indoor // = 5
    case UNRECOGNIZED(Int)

    init() {
      self = .none
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .none
      case 1: self = .gps
      case 2: self = .network
      case 3: self = .gpsNetwork
      case 4: self = .gpsNetworkIndoor
      case 5: self = .indoor
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .none: return 0
      case .gps: return 1
      case .network: return 2
      case .gpsNetwork: return 3
      case .gpsNetworkIndoor: return 4
      case .indoor: return 5
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  struct LocationNotificationSettings {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var channelID: String {
      get {return _storage._channelID}
      set {_uniqueStorage()._channelID = newValue}
    }

    var channelName: String {
      get {return _storage._channelName}
      set {_uniqueStorage()._channelName = newValue}
    }

    var title: String {
      get {return _storage._title}
      set {_uniqueStorage()._title = newValue}
    }

    var body: String {
      get {return _storage._body}
      set {_uniqueStorage()._body = newValue}
    }

    var iconData: FlutterHereMaps_AndroidIconData {
      get {return _storage._iconData ?? FlutterHereMaps_AndroidIconData()}
      set {_uniqueStorage()._iconData = newValue}
    }
    /// Returns true if `iconData` has been explicitly set.
    var hasIconData: Bool {return _storage._iconData != nil}
    /// Clears the value of `iconData`. Subsequent reads from it will return its default value.
    mutating func clearIconData() {_uniqueStorage()._iconData = nil}

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}

    fileprivate var _storage = _StorageClass.defaultInstance
  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

#if swift(>=4.2)

extension FlutterHereMaps_AndroidLocationSettings.LocationMethod: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [FlutterHereMaps_AndroidLocationSettings.LocationMethod] = [
    .none,
    .gps,
    .network,
    .gpsNetwork,
    .gpsNetworkIndoor,
    .indoor,
  ]
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "FlutterHereMaps"

extension FlutterHereMaps_LocationReading: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".LocationReading"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "coordinate"),
    3: .same(proto: "altitude"),
    4: .same(proto: "heading"),
    5: .same(proto: "accuracy"),
    6: .same(proto: "speed"),
  ]

  fileprivate class _StorageClass {
    var _coordinate: FlutterHereMaps_Coordinate? = nil
    var _altitude: Double = 0
    var _heading: Double = 0
    var _accuracy: Double = 0
    var _speed: Double = 0

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _coordinate = source._coordinate
      _altitude = source._altitude
      _heading = source._heading
      _accuracy = source._accuracy
      _speed = source._speed
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._coordinate)
        case 3: try decoder.decodeSingularDoubleField(value: &_storage._altitude)
        case 4: try decoder.decodeSingularDoubleField(value: &_storage._heading)
        case 5: try decoder.decodeSingularDoubleField(value: &_storage._accuracy)
        case 6: try decoder.decodeSingularDoubleField(value: &_storage._speed)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._coordinate {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if _storage._altitude != 0 {
        try visitor.visitSingularDoubleField(value: _storage._altitude, fieldNumber: 3)
      }
      if _storage._heading != 0 {
        try visitor.visitSingularDoubleField(value: _storage._heading, fieldNumber: 4)
      }
      if _storage._accuracy != 0 {
        try visitor.visitSingularDoubleField(value: _storage._accuracy, fieldNumber: 5)
      }
      if _storage._speed != 0 {
        try visitor.visitSingularDoubleField(value: _storage._speed, fieldNumber: 6)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: FlutterHereMaps_LocationReading, rhs: FlutterHereMaps_LocationReading) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._coordinate != rhs_storage._coordinate {return false}
        if _storage._altitude != rhs_storage._altitude {return false}
        if _storage._heading != rhs_storage._heading {return false}
        if _storage._accuracy != rhs_storage._accuracy {return false}
        if _storage._speed != rhs_storage._speed {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension FlutterHereMaps_AndroidIconData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AndroidIconData"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "icon_name"),
    2: .standard(proto: "icon_type"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.iconName)
      case 2: try decoder.decodeSingularEnumField(value: &self.iconType)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.iconName.isEmpty {
      try visitor.visitSingularStringField(value: self.iconName, fieldNumber: 1)
    }
    if self.iconType != .unknown {
      try visitor.visitSingularEnumField(value: self.iconType, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: FlutterHereMaps_AndroidIconData, rhs: FlutterHereMaps_AndroidIconData) -> Bool {
    if lhs.iconName != rhs.iconName {return false}
    if lhs.iconType != rhs.iconType {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension FlutterHereMaps_AndroidIconData.TypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "UNKNOWN"),
    1: .same(proto: "MIPMAP"),
    2: .same(proto: "DRAWABLE"),
  ]
}

extension FlutterHereMaps_AndroidLocationSettings: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AndroidLocationSettings"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "notification_settings"),
    2: .standard(proto: "location_method"),
    3: .standard(proto: "location_service_id"),
  ]

  fileprivate class _StorageClass {
    var _notificationSettings: FlutterHereMaps_AndroidLocationSettings.LocationNotificationSettings? = nil
    var _locationMethod: FlutterHereMaps_AndroidLocationSettings.LocationMethod = .none
    var _locationServiceID: Int32 = 0

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _notificationSettings = source._notificationSettings
      _locationMethod = source._locationMethod
      _locationServiceID = source._locationServiceID
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._notificationSettings)
        case 2: try decoder.decodeSingularEnumField(value: &_storage._locationMethod)
        case 3: try decoder.decodeSingularInt32Field(value: &_storage._locationServiceID)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._notificationSettings {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if _storage._locationMethod != .none {
        try visitor.visitSingularEnumField(value: _storage._locationMethod, fieldNumber: 2)
      }
      if _storage._locationServiceID != 0 {
        try visitor.visitSingularInt32Field(value: _storage._locationServiceID, fieldNumber: 3)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: FlutterHereMaps_AndroidLocationSettings, rhs: FlutterHereMaps_AndroidLocationSettings) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._notificationSettings != rhs_storage._notificationSettings {return false}
        if _storage._locationMethod != rhs_storage._locationMethod {return false}
        if _storage._locationServiceID != rhs_storage._locationServiceID {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension FlutterHereMaps_AndroidLocationSettings.LocationMethod: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NONE"),
    1: .same(proto: "GPS"),
    2: .same(proto: "NETWORK"),
    3: .same(proto: "GPS_NETWORK"),
    4: .same(proto: "GPS_NETWORK_INDOOR"),
    5: .same(proto: "INDOOR"),
  ]
}

extension FlutterHereMaps_AndroidLocationSettings.LocationNotificationSettings: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = FlutterHereMaps_AndroidLocationSettings.protoMessageName + ".LocationNotificationSettings"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "channel_id"),
    2: .standard(proto: "channel_name"),
    3: .same(proto: "title"),
    4: .same(proto: "body"),
    5: .standard(proto: "icon_data"),
  ]

  fileprivate class _StorageClass {
    var _channelID: String = String()
    var _channelName: String = String()
    var _title: String = String()
    var _body: String = String()
    var _iconData: FlutterHereMaps_AndroidIconData? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _channelID = source._channelID
      _channelName = source._channelName
      _title = source._title
      _body = source._body
      _iconData = source._iconData
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularStringField(value: &_storage._channelID)
        case 2: try decoder.decodeSingularStringField(value: &_storage._channelName)
        case 3: try decoder.decodeSingularStringField(value: &_storage._title)
        case 4: try decoder.decodeSingularStringField(value: &_storage._body)
        case 5: try decoder.decodeSingularMessageField(value: &_storage._iconData)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._channelID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._channelID, fieldNumber: 1)
      }
      if !_storage._channelName.isEmpty {
        try visitor.visitSingularStringField(value: _storage._channelName, fieldNumber: 2)
      }
      if !_storage._title.isEmpty {
        try visitor.visitSingularStringField(value: _storage._title, fieldNumber: 3)
      }
      if !_storage._body.isEmpty {
        try visitor.visitSingularStringField(value: _storage._body, fieldNumber: 4)
      }
      if let v = _storage._iconData {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: FlutterHereMaps_AndroidLocationSettings.LocationNotificationSettings, rhs: FlutterHereMaps_AndroidLocationSettings.LocationNotificationSettings) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._channelID != rhs_storage._channelID {return false}
        if _storage._channelName != rhs_storage._channelName {return false}
        if _storage._title != rhs_storage._title {return false}
        if _storage._body != rhs_storage._body {return false}
        if _storage._iconData != rhs_storage._iconData {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
