# TODO, Add swift generate to pod file, and dart generate to pubspec for generating automatically.
# For now make sure swift-protobuf and dart-protobuf are installed.
#swift-protobuf from https://github.com/apple/swift-protobuf
#swift-protobuf from https://developers.google.com/protocol-buffers/docs/darttutorial
protoc -I=. --swift_out=../ios/Classes/gen/ map_objects.proto
protoc -I=. --dart_out=../lib/gen map_objects.proto


