import 'pokemon.dart';

/// Q4, Q5, Q11 — Coleção de Pokémon com CRUD básico, filtros e estatísticas.
// CONCEITO: Coleções — List guarda os cadastrados; filtros usam .where; estatísticas usam Map e fold.
class Pokedex {
  // CONCEITO: Coleções — lista interna da Pokédex (encapsulada: acesso via métodos e todos()).
  final List<Pokemon> _pokemons = [];

  /// Q4 — Insere se o número ainda não existir; senão retorna false e avisa.
  bool adicionarPokemon(Pokemon p) {
    if (_pokemons.any((pokemon) => pokemon.numero == p.numero)) {
      print('Nao foi possivel adicionar: ja existe pokemon com numero ${p.numero}.');
      return false;
    }
    _pokemons.add(p);
    return true;
  }

  /// Q4 — Remove pelo número; retorna true se removeu, false se não achou.
  bool removerPokemonPorNumero(int numero) {
    final indice = _pokemons.indexWhere((pokemon) => pokemon.numero == numero);
    if (indice == -1) {
      return false;
    }
    _pokemons.removeAt(indice);
    return true;
  }

  /// Q4 — Retorna o Pokémon ou null.
  Pokemon? buscarPorNumero(int numero) {
    for (final pokemon in _pokemons) {
      if (pokemon.numero == numero) {
        return pokemon;
      }
    }
    return null;
  }

  /// Q4 — Imprime a ficha de cada um (ou mensagem se vazia).
  void listarTodos() {
    if (_pokemons.isEmpty) {
      print('Pokedex vazia.');
      return;
    }
    for (final pokemon in _pokemons) {
      pokemon.exibirFicha();
    }
  }

  /// Q5 — Apenas com capturado == true.
  // CONCEITO: Coleções + função anônima (callback em where) — critério inline.
  List<Pokemon> listarCapturados() {
    return _pokemons.where((pokemon) => pokemon.capturado).toList();
  }

  /// Q5 — Filtra por tipo ignorando maiúsculas/minúsculas.
  List<Pokemon> listarPorTipo(String tipo) {
    return _pokemons
        .where((pokemon) => pokemon.tipo.toLowerCase() == tipo.toLowerCase())
        .toList();
  }

  /// Q5 — nivel estritamente maior que [nivelMinimo].
  List<Pokemon> listarAcimaDoNivel(int nivelMinimo) {
    return _pokemons.where((pokemon) => pokemon.nivel > nivelMinimo).toList();
  }

  /// Q5 — Tem próxima evolução e nivel >= nivelEvolucao.
  List<Pokemon> listarQuePodemEvoluir() {
    return _pokemons
        .where((pokemon) =>
            pokemon.proximaEvolucao != null && pokemon.nivel >= pokemon.nivelEvolucao)
        .toList();
  }

  /// Q11 — Quantidade cadastrada (0 se vazia).
  int totalPokemons() => _pokemons.length;

  /// Q11 — Conta por string de tipo exata como está em cada Pokémon.
  // CONCEITO: Coleções — Map agrupa contagens por chave (tipo).
  Map<String, int> quantidadePorTipo() {
    final Map<String, int> quantidade = {};
    for (final pokemon in _pokemons) {
      quantidade[pokemon.tipo] = (quantidade[pokemon.tipo] ?? 0) + 1;
    }
    return quantidade;
  }

  /// Q11 — Média aritmética dos níveis; 0 se lista vazia.
  double mediaDeNivel() {
    if (_pokemons.isEmpty) {
      return 0;
    }
    // CONCEITO: Coleções — fold com função anônima acumula soma dos níveis.
    final soma = _pokemons.fold<int>(0, (acc, pokemon) => acc + pokemon.nivel);
    return soma / _pokemons.length;
  }

  /// Q11 — (capturados / total) * 100; 0 se vazia.
  double percentualCapturados() {
    if (_pokemons.isEmpty) {
      return 0;
    }
    final capturados = _pokemons.where((pokemon) => pokemon.capturado).length;
    return (capturados / _pokemons.length) * 100;
  }

  /// Q10 — Cópia somente leitura da lista interna (para consultas com lambdas no main).
  List<Pokemon> todos() => List.unmodifiable(_pokemons);
}
