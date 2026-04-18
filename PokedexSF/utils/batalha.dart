import '../models/habilidade.dart';
import '../models/pokemon.dart';

/// Q8 — Polimorfismo: delega para [habilidade.usar] (sem if/switch por tipo de habilidade).
// CONCEITO: Polimorfismo — o parâmetro é Habilidade; em runtime roda ChoqueDoTrovao, JatoDAgua, etc., sem switch.
void executarTurnoBatalha(Pokemon atacante, Pokemon defensor, Habilidade habilidade) {
  // CONCEITO: Polimorfismo — uma única chamada; dentro de usar(), calcularAtaqueBase() também é polimórfico.
  habilidade.usar(atacante, defensor);
  print(
    '${atacante.nome} usou ${habilidade.nome} em ${defensor.nome}. HP restante de ${defensor.nome}: ${defensor.hpAtual}/${defensor.hpMaximo}',
  );
  if (defensor.hpAtual == 0) {
    print('${defensor.nome} foi derrotado!');
  }
}
