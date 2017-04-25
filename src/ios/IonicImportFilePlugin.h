#import <Cordova/CDV.h>

@interface IonicImportFilePlugin : CDVPlugin

- (void)registerFileHandler:(CDVInvokedUrlCommand *)command;

- (BOOL)openFileUrl:(NSURL *)url;

@end
