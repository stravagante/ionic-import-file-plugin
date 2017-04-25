Ionic Import File Plugin
======
This plugin is a starting point for you to import a file into your iOS ionic app and javascript to handle the file. 

This may be helpful if you need a your app to open an email attachment or a file downloaded from the internet.

This project **is not meant to be used as is, but as an example** of how to import a file in ionic and process the file in javascript. I was unable to find a nice example of how to do this using Ionic and Cordova. There were many examples of Phonegap and Cordova and of using native iOS code to process a file. I hope this is helpful to others.

*Note: If your application is using a custom URL scheme or universal links, this plugin may interfere and need to be customized to handle your use case.

Much of the work on this plugin was inspired by the structure of the [Ionic Deeplinks Plugin](https://github.com/driftyco/ionic-plugin-deeplinks).

## Installation
The projcet is configured to import a "*.zip" file. If you want to do something different, you will need to edit the contents of this project to get it to work for you. You can clone this repository locally and install it like so
```bash
cordova plugin add [local path to ionic-import-file-plugin]
```
or install it directly into you cordova/ionic project with the following:
```bash
cordova plugin add https://github.com/stravagante/ionic-import-file-plugin
```

## Register File Types
You must register the type of files your app can open in the info.plist in you iOS app. See Apple's documentation on [Registering the File Types Your App Supports](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentInteraction_TopicsForIOS/Articles/RegisteringtheFileTypesYourAppSupports.html). You can do this by editing the plugin.xml file. The example below registers that the application can import zip files. For other file types, here's a helpful list of Apple's [System-Declared Uniform Type Identifiers](https://developer.apple.com/library/content/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html#//apple_ref/doc/uid/TP40009259-SW1). You can also declare your own unique file extensions ([Declaring New Uniform Type Identifiers](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_declare/understand_utis_declare.html#//apple_ref/doc/uid/TP40001319-CH204-SW1)).

#### plugin.xml
```xml
...
<config-file target="*-Info.plist" parent="CFBundleDocumentTypes">
    <!-- Modify here -->
    <array>
        <dict>
            <key>CFBundleTypeName</key>
            <string>ZIP</string>
            <key>LSHandlerRank</key>
            <string>Alternate</string>
            <key>LSItemContentTypes</key>
            <array>
                <string>com.pkware.zip-archive</string>
            </array>
        </dict>
    </array>
    <!-- End Modify -->
</config-file>
...
```
## Register file handler in js
*note: make sure to call IonicImportFilePlugin from a platform.ready or `deviceready` event*
By default the plugin is available on `window.IonicImportFilePlugin`. You can pass success and error callback routines that will be triggered when the iOS native `application openURL` method is called. 
```javascript
$ionicPlatform.ready(function() {
    if (window.IonicImportFilePlugin) {
        window.IonicImportFilePlugin.registerFileHandler(
        function(fileUrlData) {
                console.log('File handlered called with ', fileUrlData.url);
                // Do something with file here or pass to another part of the application
        }, function(error) {
            // error importing file.
        });
    }
});
```
In this project, the javascript handler is called anytime the iOS native `application openURL` method is called. Again, if your application is using a custom URL scheme or universal links, this plugin will need to be modified.
