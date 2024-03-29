# Deep Link Integration

## Overview

This document provides instructions for integrating deep linking functionality into your mobile application across Android, iOS, and Flutter platforms. Deep linking enables seamless navigation to specific content within your app via uniform resource identifiers (URIs).

## Android Integration

### Manifest File (`AndroidManifest.xml`)

In your `AndroidManifest.xml`, add the following intent filter within your `<activity>` tag to enable deep linking:

```xml
<intent-filter android:autoVerify="true" tools:targetApi="m">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="http" />
    <data android:scheme="https" />
    <data android:host="yourHost" />
</intent-filter>
```

### MainActivity (Kotlin)

In your `MainActivity.kt`, handle the deep link intent within the `onCreate()` method:

```kotlin
val data: Uri? = intent.data
if (data != null) {
    handleDeepLink(intent)
}
```

## iOS Integration

### Info.plist

In your `Info.plist`, add the following configuration to specify URL schemes:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>com.example.deeplinkingdemo</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>deeplinkingdemo</string>
        </array>
    </dict>
</array>
```

### AppDelegate (Swift)

In your `AppDelegate.swift`, implement the `application(_:open:options:)` method to handle incoming deep link URLs:

```swift
override func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if let controller = window?.rootViewController as? FlutterViewController {
        let channel = FlutterMethodChannel(name: "deepLinkChannel", binaryMessenger: controller.binaryMessenger)
        
        if let scheme = url.scheme,
            scheme.localizedCaseInsensitiveCompare("deeplinkingexample") == .orderedSame,
            let value = url.host {
            channel.invokeMethod("receiveDeepLink", arguments: value)
            print("Deep link received: \(value)")
        }
    }
    return true
}
```

## Flutter Integration

### Method Channel (Dart)

In your Flutter application, utilize a method channel to handle deep links:

```dart
void handleDeepLink(BuildContext context, String value) {
    setState(() {
        values = value.toString();
    });
    print('Deep link received: $value');

    runApp(DetailsApp(value));
}

void setupPlatformChannels(MethodChannel channel, BuildContext context) {
    channel.setMethodCallHandler((call) async {
        if (call.method == 'receiveDeepLink') {
            handleDeepLink(context, call.arguments as String);
        }
    });
}
```

## HTML Redirect for Deep Links

In your HTML file, implement a script to redirect deep links to your mobile application:

```html
<!DOCTYPE HTML>
<html>
    <body style="text-align:center;" id="body">
        <p id="GFG_UP" style="font-size: 19px; font-weight: bold;"></p>
        <!-- <button onclick="GFG_Fun()">click here</button> -->
        <p id="GFG_DOWN" style="color: green; font-size: 24px; font-weight: bold;"></p>
        <script>
            window.onload = GFG_Fun;
            HTMLDocument.prototype.e = document.getElementById;
            var el_up = document.e("GFG_UP");
            var el_down = document.e("GFG_DOWN");

            function getIdFromUrl() {
            var urlParams = new URLSearchParams(window.location.search);
            return urlParams.get('id');
            }

            function GFG_Fun() {
                var idValue = getIdFromUrl();
                var androidUrl = "intent://deeplinkingexample.com/"+ idValue +"#Intent;scheme=https;package=com.example.deep_linking.deep_linking;end";
                var iosUrl = "deeplinkingexample://" + idValue;
                var windowUrl = "https://play.google.com/store/apps/details?id=com.microsoft.office.word&hl=en_IN&gl=US";
                var macUrl = "https://apps.apple.com/in/app/microsoft-word/id462054704?mt=12";
                var currentUrl = "";
                var Name = "Not known";
                el_down.innerHTML = Name;

                if (navigator.appVersion.indexOf("Win") !== -1) {
                Name = "Windows OS";
                currentUrl = windowUrl;
                } else if (navigator.userAgent.match(/iPhone|iPod|iPad/i)) {
                Name = "iOS";
               currentUrl = iosUrl;
               setTimeout(function() { 
                    window.location = macUrl; 
                }, 1000);
               } else if (navigator.appVersion.indexOf("Mac") !== -1) {
               Name = "MacOS";
               currentUrl = macUrl;
              } else if (navigator.appVersion.indexOf("Android") !== -1) {
              Name = "Android";
              currentUrl = androidUrl;
                }

                el_down.innerHTML = Name;

                var delay = 0; //Your delay in milliseconds
                setTimeout(function() { 
                    window.location = currentUrl; 
                }, delay);
            }
        </script>
    
<script src="https://static.app/js/static.js" type="text/javascript"></script>
</body>
</html>
```

Feel free to adjust the instructions and formatting to better suit your needs.
