#import "IonicImportFilePlugin.h"
#import <Cordova/CDV.h>

@implementation IonicImportFilePlugin
    
    NSString *jsHandler;
    CDVPluginResult *pendingResult;
    
        
    - (void)registerFileHandler:(CDVInvokedUrlCommand *)command {
        jsHandler = command.callbackId;
        
        if (pendingResult != nil) {
            [self sendFileUrlToJavascript];
        }
    }
        
    /* 
     The openFileUrl method is called from the AppDelegate's openURL method. This can happen before the ionic.onDeviceReady is fired, and therefore, before there is a javascript function registered to handle the file open event. So we hold on to the pending result and try to process it at the time the javascrpit handler is registered.
     */
    - (BOOL)openFileUrl:(NSURL *)url {
        // Create dictionary from url and attach to result
        NSDictionary* data = @{
           @"url": [url absoluteString] ?: @"",
           @"path": [url path] ?: @"",
           @"queryString": [url query] ?: @"",
           @"scheme": [url scheme] ?: @"",
           @"host": [url host] ?: @"",
           @"fragment": [url fragment] ?: @""
        };


        pendingResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:data];

        // Allows me to use the callback handler more than once
        [pendingResult setKeepCallbackAsBool:YES];
        
        // Try to send file url to javascript side
        [self sendFileUrlToJavascript];

        // Return YES, as I intend to open this file now or on the registration of the javascript handler
        return YES;
    }
    
    - (void)sendFileUrlToJavascript {
        // If no registered handler then cannot open file
        if (jsHandler == nil || pendingResult == nil) {
            return;
        }
        
        // Pass result to javascript side handler
        [self.commandDelegate sendPluginResult:pendingResult callbackId:jsHandler];
        
        pendingResult = nil;
    }
    
@end
