class StorageKey {
  StorageKey._privateConstructor();
  static final StorageKey _storageKey = StorageKey._privateConstructor();
  static StorageKey get instance => _storageKey;

  final String storageContainerKey = "storageContainerKey";
  final String loginDataStore = "loginDataStore";
  final String token = "token";
  final String refreshToken = "refreshToken";
  final String user = "user";
  final String language = "language";
  final String isDarkMode = "isDarkMode";
  final String appFirstTime = "appFirstTime";
  final String appUserRollData = "appUserRollData";
}
