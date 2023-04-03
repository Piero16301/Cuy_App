import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:local_repository/local_repository.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(Locale locale, this._localRepository)
      : super(LanguageState(language: locale));

  final LocalRepository _localRepository;

  Future<void> changeLanguage(Locale locale) async {
    await _localRepository.saveLocale(locale: locale.languageCode);
    emit(state.copyWith(language: locale));
  }
}
