# ACUDIA

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Google Sign-in Integration

To access Google Sign-In, you'll need to make sure to [register your application](https://developers.google.com)

### Android

Create a signinconfig for debug purpose
  
  - Create a keystore
  
  > keytool -genkey -v -keystore debug.keystore -storepass [storepass] -alias android_debugkey -keypass [keypass] -keyalg RSA -keysize 2048 -validity 10000


  - Create a file named `<app dir>/android/key.properties` that contains a reference to your keystore:
  > storePassword=[storepass]  
  > keyPassword=[keypass]  
  > keyAlias=android_debugkey  
  > storeFile=<location of the key store file, such as /Users/<user name>/key.jks>
  
  - Add the SHA certificate fingerprints of the debug key in the google console.
  
  - Update the google-services.json file in `<app dir>/android/app`
  
  

### iOS

  - Download the file named GoogleService-Info.plist from the google console.

  - Open Xcode, then right-click on Runner directory and select Add Files to "Runner".

  - Select GoogleService-Info.plist from the file manager.

  - A dialog will show up and ask you to select the targets, select the Runner target.

  - Then add the CFBundleURLTypes attributes below into the `[my_project]/ios/Runner/Info.plist` file.
  
  
  
