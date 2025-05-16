import 'package:test_rick/data/rick_and_morty/repository.dart';
import 'package:test_rick/models/character_response/character_response.dart';
import 'package:test_rick/features/home/view/home_view.dart';

class GetCharacterUseCase {
  final RickAndMortyRepository repository;

  GetCharacterUseCase(this.repository);

  Future<CharacterResponse> execute() async {
    try {
      final response = await repository.getCharacters();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
