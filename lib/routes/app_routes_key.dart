class AppRoutesKey {
  ////////////// constructor
  AppRoutesKey._privateConstructor();
  static final AppRoutesKey _instance = AppRoutesKey._privateConstructor();
  static AppRoutesKey get instance => _instance;
  //////////////// routes
  final String splash = "/";
  final String navigation = "/navigation";
  final String loginScreen = "/loginScreen";
}
