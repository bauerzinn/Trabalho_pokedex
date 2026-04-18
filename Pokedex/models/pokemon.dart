import 'registravel_na_pokedex.dart';

/// Q1 — Classe principal do Pokémon. Q2 encapsula status; Q3 evolução; Q7 energia; Q9 interface.
// CONCEITO: Classe e objetos — molde Pokemon; cada variável Pokemon(...) no main é um objeto.
// CONCEITO: Interface — esta classe cumpre o contrato RegistravelNaPokedex (métodos @override abaixo).
class Pokemon implements RegistravelNaPokedex {
  final int numero;
  String nome;
  final String tipo;
  // CONCEITO: Encapsulamento — estado sensível só é alterado por métodos (subirNivel, receberDano, curar, etc.).
  int _nivel;
  int _hpAtual;
  int _hpMaximo;
  int _energia;
  bool capturado;
  bool visto;
  bool favorito;
  String? proximaEvolucao;
  int nivelEvolucao;

  /// Q1 — Construtor com todos os dados obrigatórios; valida regras (nível 1–100, HP, etc.).
  Pokemon({
    required this.numero,
    required this.nome,
    required this.tipo,
    required int nivel,
    required int hpAtual,
    required int hpMaximo,
    required this.capturado,
    required int energia,
    this.proximaEvolucao,
    this.nivelEvolucao = 0,
    bool? visto,
    this.favorito = false,
  })  : _nivel = nivel,
        _hpAtual = hpAtual,
        _hpMaximo = hpMaximo,
        _energia = energia,
        visto = visto ?? capturado {
    _validarEstadoInicial();
  }

  // CONCEITO: Encapsulamento — leitura controlada dos campos privados (sem expor _nivel diretamente).
  int get nivel => _nivel;
  int get hpAtual => _hpAtual;
  int get hpMaximo => _hpMaximo;
  int get energia => _energia;

  /// Garante nível, HP máximo/atual, energia e regras de favorito/evolução ao criar o objeto.
  void _validarEstadoInicial() {
    if (_nivel < 1 || _nivel > 100) {
      throw ArgumentError('Nivel deve estar entre 1 e 100.');
    }
    if (_hpMaximo <= 0) {
      throw ArgumentError('HP maximo deve ser maior que 0.');
    }
    if (_hpAtual < 0 || _hpAtual > _hpMaximo) {
      throw ArgumentError('HP atual deve estar entre 0 e HP maximo.');
    }
    if (_energia < 0) {
      throw ArgumentError('Energia nao pode ser negativa.');
    }
    if (favorito && !capturado) {
      throw ArgumentError('Pokemon so pode ser favorito se for capturado.');
    }
    if (proximaEvolucao == null) {
      nivelEvolucao = 0;
    } else if (nivelEvolucao < 1 || nivelEvolucao > 100) {
      throw ArgumentError('Nivel de evolucao deve estar entre 1 e 100.');
    }
  }

  /// Q9 — Define visto = true.
  @override
  void marcarComoVisto() {
    visto = true;
  }

  /// Q9 — Capturado e automaticamente visto.
  @override
  void marcarComoCapturado() {
    capturado = true;
    visto = true;
  }

  /// Q9 — Só favorita se capturado; senão avisa no console.
  @override
  void favoritar() {
    if (!capturado) {
      print('$nome nao pode ser favoritado antes de ser capturado.');
      return;
    }
    favorito = true;
  }

  /// Q9 — Remove dos favoritos.
  @override
  void desfavoritar() {
    favorito = false;
  }

  /// Q2 — Soma nível (rejeita quantidade negativa); mantém entre 1 e 100.
  void subirNivel(int quantidade) {
    if (quantidade < 0) {
      print('Valor invalido: nao e permitido subir nivel com valor negativo.');
      return;
    }
    _nivel += quantidade;
    if (_nivel > 100) {
      _nivel = 100;
    }
    if (_nivel < 1) {
      _nivel = 1;
    }
  }

  /// Q2 — Reduz HP (rejeita dano negativo); HP não fica abaixo de 0.
  void receberDano(int dano) {
    if (dano < 0) {
      print('Valor invalido: dano negativo nao e aceito.');
      return;
    }
    _hpAtual -= dano;
    if (_hpAtual < 0) {
      _hpAtual = 0;
    }
  }

  /// Q2 — Aumenta HP até no máximo hpMaximo (rejeita cura negativa).
  void curar(int valor) {
    if (valor < 0) {
      print('Valor invalido: cura negativa nao e aceita.');
      return;
    }
    _hpAtual += valor;
    if (_hpAtual > _hpMaximo) {
      _hpAtual = _hpMaximo;
    }
  }

  /// Auxiliar Q7 — Recupera energia para batalhas (não é exigência explícita da prova).
  void restaurarEnergia(int valor) {
    if (valor < 0) {
      print('Valor invalido: energia negativa nao e aceita.');
      return;
    }
    _energia += valor;
  }

  /// Q7 — Debita energia se houver saldo; retorna false se custo inválido ou energia insuficiente.
  bool gastarEnergia(int custo) {
    if (custo < 0) {
      print('Custo de energia invalido.');
      return false;
    }
    if (_energia < custo) {
      print('$nome nao tem energia suficiente. Necessario: $custo, atual: $_energia.');
      return false;
    }
    _energia -= custo;
    return true;
  }

  /// Q3 — Troca nome pela próxima evolução, zera próxima evolução, +20 HP máx. e HP cheio.
  void evoluir() {
    if (proximaEvolucao == null) {
      print('$nome nao possui proxima evolucao cadastrada.');
      return;
    }
    if (_nivel < nivelEvolucao) {
      print('$nome ainda nao pode evoluir. Nivel atual: $_nivel / necessario: $nivelEvolucao.');
      return;
    }

    nome = proximaEvolucao!;
    proximaEvolucao = null;
    nivelEvolucao = 0;
    _hpMaximo += 20;
    _hpAtual = _hpMaximo;
    print('Evolucao concluida! Agora o pokemon e $nome.');
  }

  /// Q6 — Ataque base padrão da classe base (subclasses sobrescrevem com regra do tipo).
  // CONCEITO: Polimorfismo — subclasses trocam esta fórmula; chamadas via tipo Pokemon usam a versão real do objeto.
  int calcularAtaqueBase() => _nivel * 2;

  /// Q1 — Imprime todos os dados; Q6 nas subclasses inclui linha de categoria antes.
  void exibirFicha() {
    print('--- Ficha Pokemon ---');
    print('Numero: $numero');
    print('Nome: $nome');
    print('Tipo: $tipo');
    print('Nivel: $_nivel');
    print('HP: $_hpAtual/$_hpMaximo');
    print('Energia: $_energia');
    print('Capturado: $capturado');
    print('Visto: $visto');
    print('Favorito: $favorito');
    print('Proxima evolucao: ${proximaEvolucao ?? "Nenhuma"}');
    print('Nivel para evoluir: $nivelEvolucao');
    print('Ataque base: ${calcularAtaqueBase()}');
    print('---------------------');
  }
}
