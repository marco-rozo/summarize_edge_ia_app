final class AppEnv {
  AppEnv._();

  static const String appTitle = String.fromEnvironment('APP_TITLE');
  static const String firebaseAndroidApiKey =
      String.fromEnvironment('FIREBASE_ANDROID_API_KEY');
  static const String firebaseIosApiKey =
      String.fromEnvironment('FIREBASE_IOS_API_KEY');
}
