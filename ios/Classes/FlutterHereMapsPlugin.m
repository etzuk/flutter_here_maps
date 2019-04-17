#import "FlutterHereMapsPlugin.h"
#import <flutter_here_maps/flutter_here_maps-Swift.h>

@implementation FlutterHereMapsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHereMapsPlugin registerWithRegistrar:registrar];
}
@end
