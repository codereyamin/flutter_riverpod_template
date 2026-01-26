import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod_template/screens/base_screen/faq_screen/models/f_a_q_screen_data_model.dart';
import 'package:flutter_riverpod_template/services/repository/base_repository.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';

final fAQScreenProvider = StateNotifierProvider((ref) => _FAQScreenProvider());

class _FAQScreenProvider extends StateNotifier<AsyncValue<List<FAQScreenDataModel>>> {
  final BaseRepository _repo = BaseRepository.instance;
  _FAQScreenProvider() : super(AsyncLoading()) {
    initialDataLoad();
  }

  void changeItem(int index) {
    try {
      var data = state.value;
      if (data == null) return;
      var oldData = [...data];
      var newData = [...data].map((e) => e.copyWith(isSelected: false)).toList();
      var item = oldData[index];
      newData[index] = item.copyWith(isSelected: !item.isSelected);
      state = AsyncData(newData);
    } catch (e) {
      errorLog("changeItem", e);
    }
  }

  Future<void> initialDataLoad() async {
    try {
      var response = await _repo.getAllFaq();
      state = AsyncData(response);
    } catch (e, stackTrace) {
      errorLog("initialDataLoad", e);
      state = AsyncError("initialDataLoad", stackTrace);
    }
  }
}
