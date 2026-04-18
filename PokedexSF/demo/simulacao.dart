import '../models/habilidades_especiais.dart';
import '../models/pokedex.dart';
import '../models/pokemon.dart';
import '../models/pokemon_tipos.dart';
import '../utils/batalha.dart';
import '../utils/exibicao.dart';

void executarSimulacaoPokedex() {
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
  oddish.marcarComoCapturado();
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
