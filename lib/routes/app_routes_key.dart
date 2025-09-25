class AppRoutesKey {
  ////////////// constructor
  AppRoutesKey._privateConstructor();
  static final AppRoutesKey _instance = AppRoutesKey._privateConstructor();
  static AppRoutesKey get instance => _instance;
  //////////////// routes
  final String initial = "/";
  final String splash = "splash";
  final String onBoardScreen = "onboardScreen";
  final String notFoundScreen = "notFoundScreen";
  final String errorScreen = "errorScreen";
  final String noInternetScreen = "noInternetScreen";
}
