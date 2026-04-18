import '../models/pokemon.dart';

/// Auxiliar — Imprime título e resumo de cada Pokémon (usado nos filtros e na Q10).
void exibirLista(String titulo, List<Pokemon> pokemons) {
  print('\n$titulo');
  if (pokemons.isEmpty) {
    print('Nenhum pokemon encontrado.');
    return;
  }
  for (final pokemon in pokemons) {
    print('- #${pokemon.numero} ${pokemon.nome} (tipo: ${pokemon.tipo}, nivel: ${pokemon.nivel})');
  }
}
