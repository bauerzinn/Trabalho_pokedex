import 'pokemon.dart';

/// Q6 — Subclasse Fogo: ataque = nivel * 3; ficha mostra categoria.
// CONCEITO: Herança (extends) e sobrescrita (@override) — reaproveita Pokemon e muda ataque/ficha.
class PokemonFogo extends Pokemon {
  PokemonFogo({
    required super.numero,
    required super.nome,
    required super.tipo,
    required super.nivel,
    required super.hpAtual,
    required super.hpMaximo,
    required super.capturado,
    required super.energia,
    super.proximaEvolucao,
    super.nivelEvolucao,
    super.visto,
    super.favorito,
  });

  /// Q6 — Regra Fogo: nivel * 3.
  @override
  int calcularAtaqueBase() => nivel * 3;

  /// Q6 — Acrescenta categoria antes da ficha completa da superclasse.
  @override
  void exibirFicha() {
    print('Categoria: Pokemon de Fogo');
    super.exibirFicha();
  }
}

/// Q6 — Subclasse Água: ataque = nivel * 2 + 10.
// CONCEITO: Herança e sobrescrita — mesma ideia que PokemonFogo, regra de água.
class PokemonAgua extends Pokemon {
  PokemonAgua({
    required super.numero,
    required super.nome,
    required super.tipo,
    required super.nivel,
    required super.hpAtual,
    required super.hpMaximo,
    required super.capturado,
    required super.energia,
    super.proximaEvolucao,
    super.nivelEvolucao,
    super.visto,
    super.favorito,
  });

  /// Q6 — Regra Água: nivel * 2 + 10.
  @override
  int calcularAtaqueBase() => nivel * 2 + 10;

  @override
  void exibirFicha() {
    // Q6 — Mesmo padrão: categoria + ficha da superclasse.
    print('Categoria: Pokemon de Agua');
    super.exibirFicha();
  }
}

/// Q6 — Subclasse Elétrico: ataque = nivel * 2 + 15.
// CONCEITO: Herança e sobrescrita — mesma ideia, regra elétrica.
class PokemonEletrico extends Pokemon {
  PokemonEletrico({
    required super.numero,
    required super.nome,
    required super.tipo,
    required super.nivel,
    required super.hpAtual,
    required super.hpMaximo,
    required super.capturado,
    required super.energia,
    super.proximaEvolucao,
    super.nivelEvolucao,
    super.visto,
    super.favorito,
  });

  /// Q6 — Regra Elétrico: nivel * 2 + 15.
  @override
  int calcularAtaqueBase() => nivel * 2 + 15;

  /// Q6 — Categoria + ficha da superclasse.
  @override
  void exibirFicha() {
    print('Categoria: Pokemon Eletrico');
    super.exibirFicha();
  }
}
