abstract class RegistravelNaPokedex {
  void marcarComoVisto();
  void marcarComoCapturado();
  void favoritar();
  void desfavoritar();
}

class Pokemon implements RegistravelNaPokedex {
  final int numero;
  String nome;
  final String tipo;
  int _nivel;
  int _hpAtual;
  int _hpMaximo;
  int _energia;
  bool capturado;
  bool visto;
  bool favorito;
  String? proximaEvolucao;
  int nivelEvolucao;

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

  int get nivel => _nivel;
  int get hpAtual => _hpAtual;
  int get hpMaximo => _hpMaximo;
  int get energia => _energia;

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

  @override
  void marcarComoVisto() {
    visto = true;
  }

  @override
  void marcarComoCapturado() {
    capturado = true;
    visto = true;
  }

  @override
  void favoritar() {
    if (!capturado) {
      print('$nome nao pode ser favoritado antes de ser capturado.');
      return;
    }
    favorito = true;
  }

  @override
  void desfavoritar() {
    favorito = false;
  }

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

  void restaurarEnergia(int valor) {
    if (valor < 0) {
      print('Valor invalido: energia negativa nao e aceita.');
      return;
    }
    _energia += valor;
  }

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

  int calcularAtaqueBase() => _nivel * 2;

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

  @override
  int calcularAtaqueBase() => nivel * 3;

  @override
  void exibirFicha() {
    print('Categoria: Pokemon de Fogo');
    super.exibirFicha();
  }
}

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

  @override
  int calcularAtaqueBase() => nivel * 2 + 10;

  @override
  void exibirFicha() {
    print('Categoria: Pokemon de Agua');
    super.exibirFicha();
  }
}

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

  @override
  int calcularAtaqueBase() => nivel * 2 + 15;

  @override
  void exibirFicha() {
    print('Categoria: Pokemon Eletrico');
    super.exibirFicha();
  }
}

abstract class Habilidade {
  final String nome;
  final int custoEnergia;

  Habilidade(this.nome, this.custoEnergia);

  void usar(Pokemon usuario, Pokemon alvo);
}

class ChoqueDoTrovao extends Habilidade {
  ChoqueDoTrovao() : super('Choque do Trovao', 15);

  @override
  void usar(Pokemon usuario, Pokemon alvo) {
    if (!usuario.gastarEnergia(custoEnergia)) {
      return;
    }
    final dano = usuario.calcularAtaqueBase() + 5;
    alvo.receberDano(dano);
  }
}

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

class Pokedex {
  final List<Pokemon> _pokemons = [];

  bool adicionarPokemon(Pokemon p) {
    if (_pokemons.any((pokemon) => pokemon.numero == p.numero)) {
      print('Nao foi possivel adicionar: ja existe pokemon com numero ${p.numero}.');
      return false;
    }
    _pokemons.add(p);
    return true;
  }

  bool removerPokemonPorNumero(int numero) {
    final indice = _pokemons.indexWhere((pokemon) => pokemon.numero == numero);
    if (indice == -1) {
      return false;
    }
    _pokemons.removeAt(indice);
    return true;
  }

  Pokemon? buscarPorNumero(int numero) {
    for (final pokemon in _pokemons) {
      if (pokemon.numero == numero) {
        return pokemon;
      }
    }
    return null;
  }

  void listarTodos() {
    if (_pokemons.isEmpty) {
      print('Pokedex vazia.');
      return;
    }
    for (final pokemon in _pokemons) {
      pokemon.exibirFicha();
    }
  }

  List<Pokemon> listarCapturados() {
    return _pokemons.where((pokemon) => pokemon.capturado).toList();
  }

  List<Pokemon> listarPorTipo(String tipo) {
    return _pokemons
        .where((pokemon) => pokemon.tipo.toLowerCase() == tipo.toLowerCase())
        .toList();
  }

  List<Pokemon> listarAcimaDoNivel(int nivelMinimo) {
    return _pokemons.where((pokemon) => pokemon.nivel > nivelMinimo).toList();
  }

  List<Pokemon> listarQuePodemEvoluir() {
    return _pokemons
        .where((pokemon) =>
            pokemon.proximaEvolucao != null && pokemon.nivel >= pokemon.nivelEvolucao)
        .toList();
  }

  int totalPokemons() => _pokemons.length;

  Map<String, int> quantidadePorTipo() {
    final Map<String, int> quantidade = {};
    for (final pokemon in _pokemons) {
      quantidade[pokemon.tipo] = (quantidade[pokemon.tipo] ?? 0) + 1;
    }
    return quantidade;
  }

  double mediaDeNivel() {
    if (_pokemons.isEmpty) {
      return 0;
    }
    final soma = _pokemons.fold<int>(0, (acc, pokemon) => acc + pokemon.nivel);
    return soma / _pokemons.length;
  }

  double percentualCapturados() {
    if (_pokemons.isEmpty) {
      return 0;
    }
    final capturados = _pokemons.where((pokemon) => pokemon.capturado).length;
    return (capturados / _pokemons.length) * 100;
  }

  List<Pokemon> todos() => List.unmodifiable(_pokemons);
}

void executarTurnoBatalha(Pokemon atacante, Pokemon defensor, Habilidade habilidade) {
  habilidade.usar(atacante, defensor);
  print(
    '${atacante.nome} usou ${habilidade.nome} em ${defensor.nome}. HP restante de ${defensor.nome}: ${defensor.hpAtual}/${defensor.hpMaximo}',
  );
  if (defensor.hpAtual == 0) {
    print('${defensor.nome} foi derrotado!');
  }
}

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

void main() {
  print('=== Questao 1: Cadastro basico ===');
  final bulbasaur = Pokemon(
    numero: 1,
    nome: 'Bulbasaur',
    tipo: 'Grama',
    nivel: 5,
    hpAtual: 40,
    hpMaximo: 45,
    capturado: false,
    energia: 40,
    proximaEvolucao: 'Ivysaur',
    nivelEvolucao: 16,
  );
  final charmanderBase = Pokemon(
    numero: 4,
    nome: 'Charmander',
    tipo: 'Fogo',
    nivel: 8,
    hpAtual: 39,
    hpMaximo: 39,
    capturado: true,
    energia: 45,
    proximaEvolucao: 'Charmeleon',
    nivelEvolucao: 16,
  );
  final squirtleBase = Pokemon(
    numero: 7,
    nome: 'Squirtle',
    tipo: 'Agua',
    nivel: 7,
    hpAtual: 38,
    hpMaximo: 44,
    capturado: false,
    energia: 45,
    proximaEvolucao: 'Wartortle',
    nivelEvolucao: 16,
  );

  bulbasaur.exibirFicha();
  charmanderBase.exibirFicha();
  squirtleBase.exibirFicha();

  print('\n=== Questao 2: Encapsulamento e validacoes ===');
  bulbasaur.subirNivel(3);
  bulbasaur.receberDano(12);
  bulbasaur.curar(8);
  bulbasaur.receberDano(-10);
  print(
    '${bulbasaur.nome} -> nivel: ${bulbasaur.nivel}, hp: ${bulbasaur.hpAtual}/${bulbasaur.hpMaximo}',
  );

  squirtleBase.subirNivel(120);
  squirtleBase.receberDano(100);
  squirtleBase.curar(100);
  print(
    '${squirtleBase.nome} -> nivel: ${squirtleBase.nivel}, hp: ${squirtleBase.hpAtual}/${squirtleBase.hpMaximo}',
  );

  print('\n=== Questao 3: Evolucao ===');
  bulbasaur.subirNivel(10);
  bulbasaur.evoluir();
  squirtleBase.evoluir();

  print('\n=== Questao 4 em diante: Pokedex completa ===');
  final pokedex = Pokedex();

  final pikachu = PokemonEletrico(
    numero: 25,
    nome: 'Pikachu',
    tipo: 'Eletrico',
    nivel: 20,
    hpAtual: 55,
    hpMaximo: 55,
    capturado: true,
    energia: 60,
    proximaEvolucao: 'Raichu',
    nivelEvolucao: 22,
  );
  final charmander = PokemonFogo(
    numero: 104,
    nome: 'Charmander',
    tipo: 'Fogo',
    nivel: 18,
    hpAtual: 39,
    hpMaximo: 39,
    capturado: true,
    energia: 70,
    proximaEvolucao: 'Charmeleon',
    nivelEvolucao: 16,
  );
  final squirtle = PokemonAgua(
    numero: 107,
    nome: 'Squirtle',
    tipo: 'Agua',
    nivel: 17,
    hpAtual: 44,
    hpMaximo: 44,
    capturado: false,
    energia: 65,
    proximaEvolucao: 'Wartortle',
    nivelEvolucao: 16,
  );
  final vulpix = PokemonFogo(
    numero: 37,
    nome: 'Vulpix',
    tipo: 'Fogo',
    nivel: 14,
    hpAtual: 38,
    hpMaximo: 38,
    capturado: true,
    energia: 55,
  );
  final psyduck = PokemonAgua(
    numero: 54,
    nome: 'Psyduck',
    tipo: 'Agua',
    nivel: 16,
    hpAtual: 50,
    hpMaximo: 50,
    capturado: false,
    energia: 55,
  );
  final jolteon = PokemonEletrico(
    numero: 135,
    nome: 'Jolteon',
    tipo: 'Eletrico',
    nivel: 28,
    hpAtual: 65,
    hpMaximo: 65,
    capturado: true,
    energia: 80,
  );
  final eevee = Pokemon(
    numero: 133,
    nome: 'Eevee',
    tipo: 'Normal',
    nivel: 19,
    hpAtual: 55,
    hpMaximo: 55,
    capturado: false,
    energia: 50,
    proximaEvolucao: 'Vaporeon',
    nivelEvolucao: 20,
  );
  final oddish = Pokemon(
    numero: 43,
    nome: 'Oddish',
    tipo: 'Grama',
    nivel: 12,
    hpAtual: 35,
    hpMaximo: 45,
    capturado: false,
    energia: 45,
    proximaEvolucao: 'Gloom',
    nivelEvolucao: 21,
  );

  // Cadastro de pelo menos 8 pokemons
  pokedex.adicionarPokemon(bulbasaur);
  pokedex.adicionarPokemon(pikachu);
  pokedex.adicionarPokemon(charmander);
  pokedex.adicionarPokemon(squirtle);
  pokedex.adicionarPokemon(vulpix);
  pokedex.adicionarPokemon(psyduck);
  pokedex.adicionarPokemon(jolteon);
  pokedex.adicionarPokemon(eevee);
  pokedex.adicionarPokemon(oddish);

  // Teste de duplicidade (nao deve adicionar)
  pokedex.adicionarPokemon(
    Pokemon(
      numero: 1,
      nome: 'Duplicado',
      tipo: 'Normal',
      nivel: 3,
      hpAtual: 10,
      hpMaximo: 10,
      capturado: false,
      energia: 10,
    ),
  );

  // Testes de buscar/remover/listar
  final encontrado = pokedex.buscarPorNumero(25);
  print('\nBusca #25: ${encontrado?.nome ?? "Nao encontrado"}');
  final removeu = pokedex.removerPokemonPorNumero(999);
  print('Tentativa de remover #999: ${removeu ? "removido" : "nao removido"}');
  print('\nListagem completa:');
  pokedex.listarTodos();

  print('\n=== Questao 5: Filtros ===');
  exibirLista('Capturados', pokedex.listarCapturados());
  exibirLista('Tipo FOGO (case insensitive)', pokedex.listarPorTipo('fOgO'));
  exibirLista('Acima do nivel 15', pokedex.listarAcimaDoNivel(15));
  exibirLista('Que podem evoluir agora', pokedex.listarQuePodemEvoluir());

  print('\n=== Questao 6: Heranca e sobrescrita ===');
  pikachu.exibirFicha();
  charmander.exibirFicha();
  squirtle.exibirFicha();

  print('\n=== Questao 9: Interface de registro ===');
  oddish.marcarComoVisto();
  oddish.favoritar(); // nao deve permitir
  oddish.marcarComoCapturado(); // ao capturar, tambem fica visto
  oddish.favoritar(); // agora deve permitir
  print(
    '${oddish.nome} -> visto: ${oddish.visto}, capturado: ${oddish.capturado}, favorito: ${oddish.favorito}',
  );

  eevee.marcarComoCapturado();
  eevee.favoritar();
  vulpix.favoritar();

  print('\n=== Questao 7 e 8: Habilidades e batalha polimorfica ===');
  final choque = ChoqueDoTrovao();
  final jato = JatoDAgua();
  final lanca = LancaChamas();

  // Batalha 1 (3 turnos)
  print('\nBatalha 1: Pikachu x Squirtle');
  executarTurnoBatalha(pikachu, squirtle, choque);
  executarTurnoBatalha(squirtle, pikachu, jato);
  executarTurnoBatalha(pikachu, squirtle, choque);

  // Batalha 2
  print('\nBatalha 2: Charmander x Psyduck');
  executarTurnoBatalha(charmander, psyduck, lanca);
  executarTurnoBatalha(psyduck, charmander, jato);

  print('\n=== Questao 10: Funcoes anonimas ===');
  final hpBaixo = pokedex.todos().where((p) => p.hpAtual < 30).toList();
  exibirLista('HP atual abaixo de 30', hpBaixo);

  final porNome = [...pokedex.todos()]
    ..sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
  exibirLista('Ordenados por nome (A-Z)', porNome);

  final porNivelDesc = [...pokedex.todos()]..sort((a, b) => b.nivel.compareTo(a.nivel));
  exibirLista('Ordenados por nivel (desc)', porNivelDesc);

  final favoritos = pokedex.todos().where((p) => p.favorito).toList();
  exibirLista('Somente favoritos', favoritos);

  print('\n=== Questao 11: Estatisticas ===');
  print('Total de pokemons: ${pokedex.totalPokemons()}');
  print('Quantidade por tipo: ${pokedex.quantidadePorTipo()}');
  print('Media de nivel: ${pokedex.mediaDeNivel().toStringAsFixed(2)}');
  print('Percentual capturados: ${pokedex.percentualCapturados().toStringAsFixed(2)}%');

  print('\n=== Questao 12: Desafio final ===');
  // Evolucao adicional para garantir demonstracao no app completo.
  charmander.evoluir();
  eevee.subirNivel(2);
  eevee.evoluir();
  print('Simulacao completa executada com sucesso.');
}
