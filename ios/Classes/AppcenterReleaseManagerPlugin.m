#import "AppcenterReleaseManagerPlugin.h"
#if __has_include(<appcenter_release_manager/appcenter_release_manager-Swift.h>)
#import <appcenter_release_manager/appcenter_release_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "appcenter_release_manager-Swift.h"
#endif

@implementation AppcenterReleaseManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppcenterReleaseManagerPlugin registerWithRegistrar:registrar];
}
@end
