import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/utils/sharedpref.dart';
import 'package:meta/meta.dart';

part 'themechange_state.dart';

class ThemechangeCubit extends Cubit<ThemechangeState> {
  ThemechangeCubit() : super(ThemechangeInitial());

  bool isdark = false;

  // Initialize isdark value from SharedPreferences
  void init() {
    isdark = CacheData.getData('theme') ?? false;
    emit(ThemechangeInitial());
  }

  void changetheme() async {
    isdark = !isdark;

    CacheData.setData('theme', isdark);

    emit(Themechange());
  }
}
