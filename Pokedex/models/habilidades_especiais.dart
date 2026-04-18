import 'habilidade.dart';
import 'pokemon.dart';

/// Q7 — Dano = ataque base + 5; custo de energia no super.
// CONCEITO: Herança — habilidade concreta estende a abstrata e implementa usar().
class ChoqueDoTrovao extends Habilidade {
  ChoqueDoTrovao() : super('Choque do Trovao', 15);

  @override
  void usar(Pokemon usuario, Pokemon alvo) {
    // Gasta energia; se faltar, não aplica dano.
    if (!usuario.gastarEnergia(custoEnergia)) {
      return;
    }
    final dano = usuario.calcularAtaqueBase() + 5;
    alvo.receberDano(dano);
  }
}

/// Q7 — Dano = ataque base + 3.
class JatoDAgua extends Habilidade {
  JatoDAgua() : super('Jato dAgua', 12);

  @override
  void usar(Pokemon usuario, Pokemon alvo) {
    if (!usuario.gastarEnergia(custoEnergia)) {
      return;
    }
    final dano = usuario.calcularAtaqueBase() + 3;
    alvo.receberDano(dano);
  }
}

/// Q7 — Dano = ataque base + 7.
class LancaChamas extends Habilidade {
  LancaChamas() : super('Lanca-Chamas', 18);

  @override
  void usar(Pokemon usuario, Pokemon alvo) {
    if (!usuario.gastarEnergia(custoEnergia)) {
      return;
    }
    final dano = usuario.calcularAtaqueBase() + 7;
    alvo.receberDano(dano);
  }
}
