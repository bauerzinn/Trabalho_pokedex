import 'pokemon.dart';

/// Q7 — Modelo de habilidade: nome, custo de energia e efeito em [usar].
// CONCEITO: Classe abstrata — não instancia Habilidade direto; só subclasses concretas implementam usar().
abstract class Habilidade {
  final String nome;
  final int custoEnergia;

  Habilidade(this.nome, this.custoEnergia);

  /// Aplica o efeito no [alvo] usando o ataque base do [usuario] e desconta energia.
  void usar(Pokemon usuario, Pokemon alvo);
}
