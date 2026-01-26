import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod_template/services/repository/base_repository.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';

final privacyPolicyScreenProvider = StateNotifierProvider((ref) => _PrivacyPolicyScreenProvider());

class _PrivacyPolicyScreenProvider extends StateNotifier<AsyncValue<String>> {
  final BaseRepository _repo = BaseRepository.instance;
  _PrivacyPolicyScreenProvider() : super(AsyncLoading()) {
    onAppLoading();
  }

  Future<void> onAppLoading() async {
    try {
      var response = await _repo.privacyPolicy();
      state = AsyncData(response);
    } catch (e, stackTrace) {
      errorLog("_PrivacyPolicyScreenProvider", e);
      state = AsyncError("_PrivacyPolicyScreenProvider provider", stackTrace);
    }
  }
}
