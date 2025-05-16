import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:test_rick/dependency_injection/app_component.dart';
import 'package:test_rick/domain/use_cases/get_character_use_case.dart';
import 'package:test_rick/models/character/character.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
    HomeState(
      isPending: false,
      characters: [],
      errorMessage: null,
    ),
  );

  final GetCharacterUseCase _getCharactersUseCase = getIt.get<GetCharacterUseCase>();

  getCharacters() async {
    try {
      final response = await _getCharactersUseCase.execute();
      state.characters = response.results;
      state.errorMessage = null;
      emit(state.copyWith(
        characters: state.characters,
        errorMessage: state.errorMessage,
      ));
    } on DioException catch (e) {
      state.errorMessage = e.message;
      emit(state.copyWith(
        errorMessage: state.errorMessage,
      ));
    }
  }
}