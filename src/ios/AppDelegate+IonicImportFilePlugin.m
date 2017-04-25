#import "AppDelegate.h"
#import "IonicImportFilePlugin.h"

static NSString *const PLUGIN_NAME = @"IonicImportFilePlugin";

@interface AppDelegate (IonicImportFilePlugin)
    
    -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
    
@end


@implementation AppDelegate (IonicImportFilePlugin)
    // This method must not be also implemented in the AppDelegate file
    // or the behavior is undefined per Apple Docs.
    -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
        
        
        // Get instance of plugin and pass
        IonicImportFilePlugin *plugin = [self.viewController getCommandInstance:PLUGIN_NAME];
        
        if(plugin == nil) {
            return NO;
        }
        
        return [plugin openFileUrl:url];
    }
    
@end
