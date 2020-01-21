# TODO, Add swift generate to pod file, and dart generate to pubspec for generating automatically.
# For now make sure swift-protobuf and dart-protobuf are installed.
#swift-protobuf from https://github.com/apple/swift-protobuf
#dart_out from https://developers.google.com/protocol-buffers/docs/darttutorial
protoc -I=../proto/ --swift_out=../ios/Classes/proto_gen/ ../proto/*.proto
protoc -I=../proto/ --dart_out=../lib/src/proto_gen ../proto/*.proto


