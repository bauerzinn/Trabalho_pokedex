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

/// Q7 — Modelo de habilidade: nome, custo de energia e efeito em [usar].
// CONCEITO: Classe abstrata — não instancia Habilidade direto; só subclasses concretas implementam usar().
abstract class Habilidade {
  final String nome;
  final int custoEnergia;

  Habilidade(this.nome, this.custoEnergia);

  /// Aplica o efeito no [alvo] usando o ataque base do [usuario] e desconta energia.
  void usar(Pokemon usuario, Pokemon alvo);
}

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

void main() {
  // --- Q1: três instâncias e exibirFicha() em cada uma ---
  // CONCEITO: Classe e objetos — abaixo, `new` implícito: cada final ... = Pokemon(...) cria um objeto.
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

  // --- Q2: subirNivel, receberDano, curar em pelo menos 2 pokémons (inclui valor inválido) ---
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

  // --- Q3: chama evoluir() quando nível e próxima evolução permitem ---
  print('\n=== Questao 3: Evolucao ===');
  bulbasaur.subirNivel(10);
  bulbasaur.evoluir();
  squirtleBase.evoluir();

  // --- Q4+: Pokédex, cadastro 5+, teste duplicata, busca, remoção, listarTodos ---
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

  // --- Q5: cada filtro exibido separadamente ---
  print('\n=== Questao 5: Filtros ===');
  exibirLista('Capturados', pokedex.listarCapturados());
  exibirLista('Tipo FOGO (case insensitive)', pokedex.listarPorTipo('fOgO'));
  exibirLista('Acima do nivel 15', pokedex.listarAcimaDoNivel(15));
  exibirLista('Que podem evoluir agora', pokedex.listarQuePodemEvoluir());

  // --- Q6: uma ficha de cada subclasse (Fogo, Água, Elétrico) ---
  print('\n=== Questao 6: Heranca e sobrescrita ===');
  pikachu.exibirFicha();
  charmander.exibirFicha();
  squirtle.exibirFicha();

  // --- Q9: visto, capturado, favoritar só após capturar ---
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

  // --- Q7: habilidades com custo de energia | Q8: 3+ turnos + 2 batalhas via executarTurnoBatalha ---
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

  // --- Q10: where/sort com lambdas direto (sem métodos nomeados só para comparar/filtrar) ---
  // CONCEITO: Funções anônimas — (p) => ... e (a, b) => ... passadas direto a where/sort (exigência da prova).
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

  // --- Q11: totais, mapa por tipo, média, % capturados ---
  print('\n=== Questao 11: Estatisticas ===');
  print('Total de pokemons: ${pokedex.totalPokemons()}');
  print('Quantidade por tipo: ${pokedex.quantidadePorTipo()}');
  print('Media de nivel: ${pokedex.mediaDeNivel().toStringAsFixed(2)}');
  print('Percentual capturados: ${pokedex.percentualCapturados().toStringAsFixed(2)}%');

  // --- Q12: evoluções extras + encerramento (o fluxo acima já cumpre 8+ pokémons, 3 tipos, etc.) ---
  print('\n=== Questao 12: Desafio final ===');
  // Evolucao adicional para garantir demonstracao no app completo.
  charmander.evoluir();
  eevee.subirNivel(2);
  eevee.evoluir();
  print('Simulacao completa executada com sucesso.');
}
