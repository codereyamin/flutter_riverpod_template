# 🚀 Flutter Riverpod Template

A production-ready, security-hardened Flutter starter template with Riverpod state management, Go Router navigation, Dio API layer, Socket.IO real-time support, and 26 industry-standard security best practices applied out of the box.

---

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Environment Configuration](#-environment-configuration)
- [Running the App](#-running-the-app)
- [API Integration Guide](#-api-integration-guide)
- [State Management](#-state-management)
- [Navigation / Routing](#-navigation--routing)
- [Storage Guide](#-storage-guide)
- [Socket.IO Guide](#-socketio-guide)
- [Adding a New Screen](#-adding-a-new-screen)
- [Security Overview](#-security-overview)
- [Android Release Signing](#-android-release-signing)
- [CI/CD](#-cicd)
- [Changing the Package Name](#-changing-the-package-name)
- [Flutter Version](#-flutter-version)

---

## ✨ Features

- ✅ **Riverpod 3.x** state management with full lifecycle observer
- ✅ **Go Router** with internet-gating redirect and 404 handling
- ✅ **Dio** HTTP client with interceptors, token refresh, and typed results
- ✅ **Socket.IO** with auto-reconnect and authenticated handshake
- ✅ **Secure token storage** via Android Keystore / iOS Keychain
- ✅ **Dark / Light theme** with persistent preference
- ✅ **Multi-language** translation support with caching
- ✅ **Real internet reachability** check (not just connectivity)
- ✅ **Custom widgets** — inputs, buttons, image pickers, dialogs, skeletons
- ✅ **OTP utilities**, email masking, date/time formatting
- ✅ **Firebase** push notifications (FCM)
- ✅ **Error boundary** — custom error widget replaces Flutter's red screen
- ✅ **CI/CD** pipeline with secret-leak detection

---

## 🛠 Tech Stack

| Package | Version | Purpose |
|---|---|---|
| `flutter_riverpod` | ^3.3.1 | State management |
| `go_router` | ^17.2.1 | Declarative routing |
| `dio` | ^5.9.2 | HTTP client |
| `flutter_secure_storage` | ^9.2.4 | Encrypted token storage |
| `shared_preferences` | ^2.5.5 | Non-sensitive preferences |
| `socket_io_client` | ^3.1.2 | Real-time WebSocket |
| `connectivity_plus` | ^7.1.1 | Network state |
| `firebase_messaging` | ^16.2.0 | Push notifications |
| `firebase_core` | ^4.7.0 | Firebase init |
| `cached_network_image` | ^3.4.1 | Image caching |
| `image_picker` | ^1.2.1 | Camera / gallery |
| `skeletonizer` | ^2.1.3 | Skeleton loaders |
| `pretty_dio_logger` | ^1.4.0 | Debug-only API logging |
| `permission_handler` | ^12.0.1 | Runtime permissions |
| `app_links` | ^7.0.0 | Deep links / payments |
| `change_app_package_name` | ^1.5.0 | Package name changer |

---

## 📁 Project Structure

```
flutter_riverpod_template/
│
├── .env.example                        # Safe env template — commit this
├── .gitignore                          # Blocks keys, .env, JKS files
├── .github/
│   └── workflows/
│       └── ci.yml                      # CI: lint, test, secret scan, build
│
├── android/
│   ├── key.properties.example          # Signing template — commit this
│   └── key.properties                  # Real credentials — NEVER commit (gitignored)
│
├── assets/
│   ├── fonts/                          # Poppins font family (5 weights)
│   ├── images/                         # App images / placeholders
│   └── icons/                          # App icons
│
└── lib/
    │
    ├── main.dart                       # App entry point, orientation lock, UI overlay
    ├── main_app_entry.dart             # ProviderScope, MaterialApp.router, theme, overlay
    │
    ├── constant/
    │   ├── app_api_url.dart            # All API endpoint strings + --dart-define base URL
    │   ├── app_colors.dart             # Full color palette (gray, red, blue, purple, orange…)
    │   ├── app_constant.dart           # App-wide constants (font name, etc.)
    │   ├── app_asserts_icons_path.dart # Icon asset path strings
    │   └── app_asserts_image_path.dart # Image asset path strings
    │
    ├── routes/
    │   ├── app_routes.dart             # GoRouter config, redirect logic, nav helpers
    │   ├── app_routes_key.dart         # Route name/path string constants
    │   └── internet_check_provider.dart# StreamProvider — real HTTP reachability probe
    │
    ├── services/
    │   │
    │   ├── api/
    │   │   ├── api.dart                # AppApi — Dio singleton, interceptors, token refresh
    │   │   ├── api_services.dart       # CRUD methods 
    │   │   ├── non_auth_api.dart       # Unauthenticated Dio (login, refresh, reset password)
    │   │   └── ssl_pinning_scaffold.dart # SSL pinning how-to guide
    │   │
    │   ├── repository/
    │   │   ├── auth_repository.dart    # login, signup, OTP, forgot password, profile update
    │   │   └── base_repository.dart    # terms, about us, privacy policy, FAQ
    │   │
    │   ├── sockets/
    │   │   └── app_socket_all_operation.dart # Socket.IO — connect, emit, listen, reconnect
    │   │
    │   └── storage/
    │       ├── storage_key.dart        # All SharedPreferences / SecureStorage key constants
    │       └── storage_services.dart   # Secure (token, role) + pref (theme, language) storage
    │
    ├── screens/
    │   ├── splash_screen/
    │   │   └── splash_screen.dart
    │   ├── home_screen/
    │   │   └── home_screen.dart
    │   ├── profile_screen/
    │   │   └── profile_screen.dart
    │   └── base_screen/                # Shared utility screens
    │       ├── about_us_screen/
    │       │   ├── about_us_screen.dart
    │       │   └── provider/about_us_screen_provider.dart
    │       ├── faq_screen/
    │       │   ├── faq_screen.dart
    │       │   ├── models/f_a_q_screen_data_model.dart
    │       │   ├── providers/f_a_q_screen_provider.dart
    │       │   └── widgets/
    │       │       ├── faq_card.dart
    │       │       └── faq_card_loader.dart
    │       ├── privacy_policy_screen/
    │       ├── terms_and_conditions_screen/
    │       └── widgets/
    │           ├── base_data_widget.dart      # Async state widget (loading/error/data)
    │           └── base_no_found_data_widget.dart
    │
    ├── error_handling_screen/
    │   ├── error_screen.dart           # Replaces Flutter red-screen-of-death
    │   ├── no_internet_screen          # internet status base show
    │   └── not_found_screen.dart       # 404 router fallback
    │
    ├── utils/
    │   ├── app_log.dart                # Debug-only logging with sensitive value redaction
    │   ├── app_size.dart               # Responsive sizing (width/height from design spec)
    │   ├── app_snack_bar.dart          # Overlay and scaffold snackbars (error/success/info)
    │   ├── app_theme.dart              # ThemeNotifier + themeProvider (dark/light toggle)
    │   ├── app_theme_configuration.dart# Full Material3 ThemeData (light + dark)
    │   ├── gap.dart                    # Responsive SizedBox shorthand
    │   ├── otp_related_function.dart   # OTP timer formatting, email masking
    │   ├── observer/
    │   │   └── logger_ob_server.dart   # ProviderObserver — logs add/update/dispose/mutations
    │   └── languages/
    │       ├── language_provider.dart  # Riverpod language state + persistence
    │       └── translation_cache.dart  # SharedPreferences-backed translation cache
    │
    └── widgets/
        ├── app_image/
        │   ├── app_image.dart          # Cached network image with placeholder
        │   └── app_image_circular.dart # Circular avatar variant
        ├── buttons/
        │   ├── app_button.dart         # Primary app button
        │   ├── common_app_bar.dart     # Reusable AppBar
        │   ├── custom_check_box_button.dart
        │   ├── customer_favorite_button.dart
        │   └── flutter_switch.dart     # Toggle switch
        ├── inputs/
        │   ├── app_input_widget.dart   # Standard text input
        │   ├── app_input_widget_tow.dart
        │   ├── app_in_put_unfocused.dart
        │   ├── text_input_number_limit.dart
        │   └── formatter/             # Input formatters
        │       ├── decimal_text_input_formatter.dart
        │       ├── leading_zero_remover_formatter.dart
        │       ├── max_number_formater.dart
        │       ├── otp_input_formatter.dart
        │       ├── otp_number_formatter.dart
        │       └── remove_leading_zero_formatter.dart
        ├── texts/
        │   ├── app_text.dart           # Styled text widget (Poppins, color, weight)
        │   ├── app_date_time_formate.dart
        │   ├── app_expandable_text.dart
        │   └── app_html_text.dart      # HTML-rendered text (terms, about us)
        ├── dialogs/
        │   ├── log_out_dialog.dart
        │   └── up_coming_dialog.dart
        ├── loading/
        │   └── app_loading.dart        # Circular loading indicator
        ├── overlay/
        │   └── app_overlay_helper.dart # Global overlay insertion helpers
        ├── search_animation/
        │   └── search_animation.dart
        ├── custom_date_picker/
        │   ├── custom_show_date_picker.dart
        │   └── custom_time_picker.dart
        ├── custom_expansion_tile/
        │   └── custom_expansion_tile.dart
        ├── custom_paints/
        │   └── dotted_border_painter.dart
        └── image_userPick/
            ├── image_user_pick.dart
            └── image_user_picker.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter `3.41.6` (stable)
- Dart SDK `^3.11.0`
- Android Studio / Xcode
- Firebase project (for push notifications)

### 1. Clone the repository

```bash
git clone https://github.com/yourname/flutter_riverpod_template.git
cd flutter_riverpod_template
```

### 2. Create your local environment file

```bash
cp .env.example .env
```

Open `.env` and set your server URL:

```env
BASE_URL_DEV=http://localhost:6008/api/v1
BASE_URL_PROD=https://api.yourapp.com/api/v1
```

> `.env` is gitignored — never commit it.

### 3. Set up Android signing

```bash
cp android/key.properties.example android/key.properties
```

Fill in `android/key.properties` with your real keystore credentials.
Generate a new keystore if you don't have one:

```bash
keytool -genkeypair -v \
  -keystore android/app/release.jks \
  -keyalg RSA -keysize 2048 \
  -validity 10000 \
  -alias your-key-alias
```

> `key.properties` is gitignored — never commit it.

### 4. Install dependencies

```bash
flutter pub get
```

### 5. Set up Firebase (push notifications)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase (generates google-services.json + GoogleService-Info.plist)
flutterfire configure
```

> Both files are gitignored. Store them as CI secrets for automated builds.

---

## 🌐 Environment Configuration

Base URLs are **never hardcoded**. They are injected at build time using `--dart-define`:

```bash
# Development
flutter run --dart-define=BASE_URL=http://localhost:6008/api/v1

# Staging
flutter run --dart-define=BASE_URL=https://staging.yourapp.com/api/v1

# Production
flutter build apk --release \
  --dart-define=BASE_URL=https://api.yourapp.com/api/v1
```

The value is read in `lib/constant/app_api_url.dart`:

```dart
static const String _baseUrlFromEnv = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'https://api.yourapp.com/api/v1',
);
```

> HTTP (non-TLS) URLs are **blocked at runtime in release builds**. Production always requires HTTPS.

---

## ▶️ Running the App

```bash
# Debug (development server)
flutter run --dart-define=BASE_URL=http://localhost:6008/api/v1

# Release APK
flutter build apk --release \
  --dart-define=BASE_URL=https://api.yourapp.com/api/v1

# Release IPA (iOS)
flutter build ipa --release \
  --dart-define=BASE_URL=https://api.yourapp.com/api/v1

# Run tests
flutter test

# Lint
flutter analyze
```

---

## 🔌 API Integration Guide

### Making API calls

All calls go through `ApiServices` which returns a typed `AppResult<T>`:

```dart
// In your repository
final result = await ApiServices.instance.getServices('/products');

if (result is AppSuccess) {
  final data = result.data; // dynamic
} else if (result is AppFailure) {
  print(result.message);   // user-facing error message
  print(result.statusCode); // HTTP status code
}
```

### Available methods

```dart
final api = ApiServices.instance;

// GET
await api.getServices('/endpoint', queryParameters: {'page': 1});

// POST
await api.postServices(url: '/endpoint', body: {'key': 'value'});

// PUT
await api.putServices(url: '/endpoint', body: body);

// PATCH
await api.patchServices(url: '/endpoint', body: formData);

// DELETE
await api.deleteServices(url: '/endpoint', body: body);
```

### Adding a new endpoint

Open `lib/constant/app_api_url.dart` and add your endpoint:

```dart
final String products = '/products';
final String productDetail = '/products/:id';
```

### Adding a new repository

```dart
class ProductRepository {
  ProductRepository._();
  static final ProductRepository instance = ProductRepository._();

  final ApiServices _api = ApiServices.instance;
  final AppApiUrl _url = AppApiUrl.instance;

  Future<List<Product>> getProducts() async {
    final result = await _api.getServices(_url.products);
    if (result.data?['data'] is List) {
      return (result.data['data'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
    }
    return [];
  }
}
```

---

## 🔄 State Management

This template uses **Riverpod 3.x** with `StateNotifierProvider` for async state.

### Pattern used across all screens

```dart
// 1. Provider
final productProvider = StateNotifierProvider<ProductNotifier,
    AsyncValue<List<Product>>>((ref) => ProductNotifier());

// 2. Notifier
class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  ProductNotifier() : super(const AsyncLoading()) {
    load();
  }

  Future<void> load() async {
    try {
      final data = await ProductRepository.instance.getProducts();
      state = AsyncData(data);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// 3. In widget
class ProductScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);
    return state.when(
      data: (products) => ProductList(products: products),
      loading: () => const AppLoading(),
      error: (e, _) => ErrorText(message: e.toString()),
    );
  }
}
```

### ProviderObserver

Every provider lifecycle event is logged in debug mode via `LoggerObServer`:

```
🟢 Provider Added   — name, type, value
🌀 Provider Updated — previous value → new value
🔴 Provider Disposed
⚠️ Provider Error   — error + stack trace
🚀 Mutation Started / ✅ Success / ❌ Error
```

### Resetting all providers (logout)

Call `resetRiverpod()` from `MainAppEntry` to wipe all provider state on logout:

```dart
// Access via a callback passed down or a global key
mainAppEntryState.resetRiverpod();
```

---

## 🧭 Navigation / Routing

Navigation uses **Go Router** accessed through the `AppRoutes` singleton.

### Route keys

All route names and paths are in `lib/routes/app_routes_key.dart`:

```dart
AppRoutesKey.instance.splash       // "splash"
AppRoutesKey.instance.initial      // "/"
AppRoutesKey.instance.noInternetScreen
```

### Navigation methods

```dart
final router = AppRoutes.instance;

router.go('/home');                          // Replace entire stack
router.push('/detail');                      // Push onto stack
router.pop();                                // Pop current screen
router.pushReplacement('/home');             // Replace top of stack
router.goNamed('productDetail',
  pathParameters: {'id': '123'});            // Named route with params
```

### Adding a new route

Open `lib/routes/app_routes.dart` and add a `GoRoute`:

```dart
GoRoute(
  path: '/products',
  name: AppRoutesKey.instance.products,
  builder: (context, state) => const ProductScreen(),
),
```

Add the key in `app_routes_key.dart`:

```dart
final String products = 'products';
```

### Internet gating

The router automatically redirects to the no-internet screen when offline and back to the previous screen when connectivity is restored. No manual handling needed.

---

## 💾 Storage Guide

### What goes where

|       Data      |       Storage        |       Reason       |
|-----------------|----------------------|--------------------|
| Access token | `flutter_secure_storage` | Encrypted, Keychain/Keystore |
| Refresh token | `flutter_secure_storage` | Encrypted |
| User role | `flutter_secure_storage` | RBAC-sensitive |
| Login data / PII | `flutter_secure_storage` | May contain personal info |
| Dark mode preference | `SharedPreferences` | Not sensitive |
| Language preference | `SharedPreferences` | Not sensitive |
| First-time flag | `SharedPreferences` | Not sensitive |

### Usage

```dart
final storage = StorageServices.instance;

// Save token (secure)
await storage.setToken('eyJ...');

// Read token
final token = await storage.getToken();

// Save preference
await storage.setDarkMode(true);

// Full logout — wipes ALL secure keys
await storage.logout();
```

### Storage keys

All key strings are defined in `lib/services/storage/storage_key.dart` — never use raw strings.

---

## 🔌 Socket.IO Guide

### Connect (typically in splash or after login)

```dart
await AppSocketAllOperation.instance.initializeSocket();
```

The auth token is automatically read from secure storage and included in the handshake.

### Listen to events

```dart
AppSocketAllOperation.instance.readEvent(
  event: 'new_message',
  handler: (data) {
    // data is dynamic — cast as needed
    final message = Message.fromJson(data);
  },
);
```

### Emit events

```dart
AppSocketAllOperation.instance.emitEvent(
  'send_message',
  {'roomId': '123', 'text': 'Hello'},
);
```

### Disconnect (on logout)

```dart
AppSocketAllOperation.instance.dispose();
```

---

## 📱 Adding a New Screen

Follow this pattern to add any new feature screen:

**1. Create the screen folder**
```
lib/screens/product_screen/
  ├── product_screen.dart
  ├── models/
  │   └── product_model.dart
  ├── providers/
  │   └── product_provider.dart
  └── widgets/
      └── product_card.dart
```

**2. Create the model**
```dart
// models/product_model.dart
class ProductModel {
  final String id;
  final String name;
  const ProductModel({required this.id, required this.name});

  factory ProductModel.fromJson(Map json) =>
      ProductModel(id: '${json['_id']}', name: '${json['name']}');
}
```

**3. Create the provider**
```dart
// providers/product_provider.dart
final productProvider = StateNotifierProvider<_ProductNotifier,
    AsyncValue<List<ProductModel>>>((ref) => _ProductNotifier());

class _ProductNotifier extends StateNotifier<AsyncValue<List<ProductModel>>> {
  _ProductNotifier() : super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ProductRepository.instance.getProducts();
      state = AsyncData(data);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
```

**4. Build the screen**
```dart
// product_screen.dart
class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);
    return Scaffold(
      appBar: const CommonAppBar(title: 'Products'),
      body: state.when(
        data: (list) => ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) => ProductCard(product: list[i]),
        ),
        loading: () => const Skeletonizer(child: _ProductSkeleton()),
        error: (e, _) => BaseNoFoundDataWidget(message: e.toString()),
      ),
    );
  }
}
```

**5. Register the route** in `app_routes.dart` and add the key to `app_routes_key.dart`.

---

## 🔒 Security Overview

26 industry-standard security practices are applied:

| # |       Fix       |       File       |
|---|-----------------|------------------|
| 1 | Tokens in `flutter_secure_storage` (Keychain/Keystore) | `storage_services.dart` |
| 2 | Base URL from `--dart-define`, never hardcoded | `app_api_url.dart` |
| 3 | Dead `_getDomain()` code removed | `app_api_url.dart` |
| 4 | Global SSL bypass (`MyHttpOverrides`) removed | `main.dart` |
| 5 | `key.properties` removed from git | `.gitignore` |
| 6 | `dev_info.txt` removed from git | `.gitignore` |
| 7 | `.gitignore` blocks `.env`, `*.jks`, `key.properties` | `.gitignore` |
| 8 | SSL pinning scaffold provided | `ssl_pinning_scaffold.dart` |
| 9 | Sensitive values auto-redacted in debug logs | `app_log.dart` |
| 10 | Timeouts: 15s connect, 30s send/receive (was 120s) | `api.dart` |
| 11 | `followRedirects = false` on all Dio instances | `api.dart`, `non_auth_api.dart` |
| 12 | Token refresh mutex — prevents race conditions | `api.dart` |
| 13 | Auth header cleared before logout redirect | `api.dart` |
| 14 | DRY `_execute()` — single error handler, not 5 copies | `api_services.dart` |
| 15 | Typed `AppResult<T>` replaces `dynamic / null` | `api_services.dart` |
| 16 | Server error messages sanitised before showing to user | `api_services.dart` |
| 17 | `postServices` uses `AppApi.instance` (not new Dio) | `api_services.dart` |
| 18 | `Content-Type: application/json` set on `NonAuthApi` | `non_auth_api.dart` |
| 19 | Cascade `..replaceAll` bug fixed to `.replaceAll` | `base_repository.dart` |
| 20 | Repository returns `AppResult`, not raw `dynamic` | `base_repository.dart` |
| 21 | Passwords never passed to `errorLog` | `auth_repository.dart` |
| 22 | Email normalised (trim + lowercase) before all calls | `auth_repository.dart` |
| 23 | Typed result from login — failure reason is explicit | `auth_repository.dart` |
| 24 | File size validated before upload (max 10 MB) | `auth_repository.dart` |
| 25 | Internet check uses real HTTP probe, not just connectivity | `internet_check_provider.dart` |
| 26 | Auth token sent in Socket.IO handshake headers | `app_socket_all_operation.dart` |

---

## 📦 Android Release Signing

**Never commit your keystore or passwords.**

### Local development

```bash
# Copy the example and fill in real values
cp android/key.properties.example android/key.properties
```

### CI / GitHub Actions

Store your keystore as a base64 GitHub Secret:

```bash
base64 -i android/app/release.jks | pbcopy
# Paste into GitHub → Settings → Secrets → KEYSTORE_BASE64
```

Decode in your workflow:
```yaml
- name: Decode keystore
  run: |
    echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 --decode \
      > android/app/release.jks
    echo "storePassword=${{ secrets.STORE_PASSWORD }}" >> android/key.properties
    echo "keyPassword=${{ secrets.KEY_PASSWORD }}"     >> android/key.properties
    echo "keyAlias=${{ secrets.KEY_ALIAS }}"           >> android/key.properties
    echo "storeFile=../app/release.jks"                >> android/key.properties
```

---

## ⚙️ CI/CD

The included GitHub Actions workflow (`.github/workflows/ci.yml`) runs on every push and pull request:

1. **Secret leak scan** — fails if `key.properties` or `.env` is committed
2. **Hardcoded IP scan** — fails if any raw IP appears in Dart source
3. **Flutter analyse** — enforces lint rules (`--fatal-infos`)
4. **Flutter test** — runs all unit and widget tests
5. **Release APK build** — verifies `--dart-define` injection works end-to-end

---

## 🏷️ Changing the Package Name

```bash
# Change both Android and iOS at once
dart run change_app_package_name:main com.yourcompany.yourapp

# Android only
dart run change_app_package_name:main com.yourcompany.yourapp --android

# iOS only
dart run change_app_package_name:main com.yourcompany.yourapp --ios
```

---

## 📌 Flutter Version

```
Flutter : 3.41.6 (stable)
Dart    : 3.11.x
Java    : 17.0.x
```

To pin your Flutter version locally with FVM:

```bash
fvm install 3.41.6
fvm use 3.41.6
fvm flutter pub get
```

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

MIT — see [LICENSE](LICENSE) for details.
