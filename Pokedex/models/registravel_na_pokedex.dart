/// Q9 — Interface: o que a Pokédex precisa registrar sobre um Pokémon.
// CONCEITO: Interface — contrato (visto / capturado / favorito); Dart: abstract class + implements.
abstract class RegistravelNaPokedex {
  /// Marca o Pokémon como já visto na Pokédex.
  void marcarComoVisto();

  /// Marca como capturado e, pela regra da prova, também como visto.
  void marcarComoCapturado();

  /// Só permite favoritar se já estiver capturado.
  void favoritar();

  /// Remove o Pokémon da lista de favoritos.
  void desfavoritar();
}
