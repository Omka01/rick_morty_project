import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:test_rick/models/character/character.dart';
import 'package:test_rick/domain/use_cases/get_character_use_case.dart';
import 'package:test_rick/dependency_injection/app_component.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
    : super(
        HomeState(
            isPending: false,
            characters: [],
            errorMessage: null));

  final GetCharacterUseCase _getCharacterUseCase = getIt.get<GetCharacterUseCase>();

  getCharacters() async {
    try {
      final response = await _getCharacterUseCase.execute();
      state.characters = response.results;
      emit(state.copyWith(
          characters: state.characters,
      ));
    } catch (e) {
      inspect(e);
    }
  }
}
