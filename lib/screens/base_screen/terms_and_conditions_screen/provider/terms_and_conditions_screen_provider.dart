import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod_template/services/repository/base_repository.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';

final termsAndConditionsScreenProvider = StateNotifierProvider((ref) => _TermsAndConditionsScreenProvider());

class _TermsAndConditionsScreenProvider extends StateNotifier<AsyncValue<String>> {
  final BaseRepository _repo = BaseRepository.instance;
  _TermsAndConditionsScreenProvider() : super(AsyncLoading()) {
    onAppLoading();
  }

  Future<void> onAppLoading() async {
    try {
      var response = await _repo.termsAndConditions();
      state = AsyncData(response);
    } catch (e, stackTrace) {
      errorLog("onAppLoading", e);
      state = AsyncError("onAppLoading provider", stackTrace);
    }
  }
}
