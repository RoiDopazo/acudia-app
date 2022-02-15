# ACUDIA

Acudia project

## Prerequisites 

- Flutter installation
- Environment variables (create a new .env file including next secrets/keys)
  > AWS_APP_SYNC_ENDPOINT: <>  
  > USER_POOL_ID: <>  
  > USER_POOL_CLIENT_ID: <>  
  > AWS_APP_SYNC_API_KEY: <>  
  > CLOUDINARY_API_KEY: <>  
  > CLOUDINARY_API_SECRET: <>  
  > CLOUDINARY_API_NAME: <>  
  > OPENDATA_HOSPITAL_API: <>  

- Create a signinconfig for debug purpose (Android)
  - Create a keystore
    > keytool -genkey -v -keystore debug.keystore -storepass [storepass] -alias android_debugkey -keypass [keypass] -keyalg RSA -keysize 2048 -validity 10000
  - Create a file named `<app dir>/android/key.properties` that contains a reference to your keystore:
      > storePassword=[storepass]  
      > keyPassword=[keypass]  
      > keyAlias=android_debugkey  
      > storeFile=<location of the key store file, such as /Users/<user name>/key.jks>


## Build and run

  - Get all the dependencies listed in the pubspec.yaml
    > flutter pub get

  - Run the app
    > flutter run
  
  
