import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod_template/services/repository/base_repository.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';

final aboutUsScreenProvider = StateNotifierProvider((ref) => _AboutUsScreenProvider());

class _AboutUsScreenProvider extends StateNotifier<AsyncValue<String>> {
  final BaseRepository _repo = BaseRepository.instance;
  _AboutUsScreenProvider() : super(AsyncLoading()) {
    onAppLoading();
  }

  Future<void> onAppLoading() async {
    try {
      var response = await _repo.aboutUs();
      state = AsyncData(response);
    } catch (e, stackTrace) {
      errorLog("_AboutUsScreenProvider", e);
      state = AsyncError("_AboutUsScreenProvider provider", stackTrace);
    }
  }
}
