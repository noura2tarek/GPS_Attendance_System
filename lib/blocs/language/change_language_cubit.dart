import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/language/change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguageState(const Locale("en")));

  void changeLanguage(String languageCode) {
    emit(ChangeLanguageState(Locale(languageCode)));
  }
}
