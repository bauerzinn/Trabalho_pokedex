# Pokédex — Prova prática (Dart)

**Disciplina:** Desenvolvimento para Dispositivos Móveis — Universidade Tuiuti do Paraná  
**Professor:** Chauã Queirolo

## Identificação da equipe

Preencha com os dados do seu grupo:

| Nome | RA / matrícula |
|------|----------------|
|      |                |
|      |                |
|      |                |
|      |                |

*(Trabalho em equipes de 2 a 4 alunos.)*

## Como executar

No diretório do projeto:

```bash
dart run main.dart
```

Se usar Flutter com Dart embutido:

```bash
flutter dart run main.dart
```

---

## Enunciado — Questões

### Questão 1 — Cadastro básico de Pokémon

Crie uma classe `Pokemon` com os seguintes atributos obrigatórios:

- `int numero`
- `String nome`
- `String tipo`
- `int nivel`
- `int hpAtual`
- `int hpMaximo`
- `bool capturado`

Implemente um construtor que receba todos esses valores.

Depois, crie um método `exibirFicha()` que mostre todas as informações do pokémon de forma organizada.

No `main()`, instancie exatamente **3** pokémons diferentes e exiba a ficha de cada um.

**Restrições:**

- `nivel` deve começar entre 1 e 100.
- `hpAtual` não pode ser maior que `hpMaximo`.
- `hpMaximo` deve ser maior que 0.

---

### Questão 2 — Encapsulamento e validação de regras

Na classe `Pokemon`, torne os atributos de status internos privados quando fizer sentido e controle o acesso usando métodos, getters ou setters.

Implemente obrigatoriamente os métodos:

- `subirNivel(int quantidade)`
- `receberDano(int dano)`
- `curar(int valor)`

**Regras obrigatórias:**

- o nível nunca pode passar de 100;
- o nível nunca pode ficar abaixo de 1;
- o HP nunca pode ficar negativo;
- o HP nunca pode ultrapassar o HP máximo;
- valores negativos recebidos nos métodos não devem ser aceitos.

No `main()`, demonstre cada método funcionando com pelo menos **2** pokémons.

---

### Questão 3 — Evolução com regra fixa

Adicione à classe `Pokemon` os seguintes atributos:

- `String? proximaEvolucao`
- `int nivelEvolucao`

Implemente o método `evoluir()`.

**Regras obrigatórias:**

- um pokémon só pode evoluir se `proximaEvolucao` estiver preenchido;
- ele só pode evoluir se `nivel >= nivelEvolucao`;
- ao evoluir, o nome do pokémon deve ser alterado para o valor de `proximaEvolucao`;
- após evoluir, `proximaEvolucao` deve ficar nula;
- o pokémon não pode evoluir duas vezes usando a mesma configuração;
- ao evoluir, aumente `hpMaximo` em 20 e restaure `hpAtual` para o novo máximo.

No `main()`, crie um exemplo de pokémon que evolui e outro que ainda não pode evoluir.

---

### Questão 4 — Criação da Pokédex

Crie uma classe `Pokedex` com uma coleção interna de pokémons.

Implemente os métodos:

- `adicionarPokemon(Pokemon p)`
- `removerPokemonPorNumero(int numero)`
- `buscarPorNumero(int numero)`
- `listarTodos()`

**Regras obrigatórias:**

- não permitir dois pokémons com o mesmo número na Pokédex;
- `buscarPorNumero` deve retornar o objeto encontrado ou `null`;
- `listarTodos()` deve exibir todos os pokémons cadastrados;
- `removerPokemonPorNumero` deve indicar se a remoção aconteceu ou não.

No `main()`, cadastre pelo menos **5** pokémons e teste todos os métodos.

---

### Questão 5 — Filtros obrigatórios da Pokédex

Na classe `Pokedex`, implemente os métodos:

- `listarCapturados()`
- `listarPorTipo(String tipo)`
- `listarAcimaDoNivel(int nivelMinimo)`
- `listarQuePodemEvoluir()`

Cada método deve retornar uma lista de pokémons.

**Regras obrigatórias:**

- a comparação por tipo deve ignorar diferença entre maiúsculas e minúsculas;
- `listarQuePodemEvoluir()` deve considerar apenas pokémons que possuem próxima evolução e já atingiram o nível necessário;
- o programa principal deve mostrar o resultado de cada filtro separadamente.

---

### Questão 6 — Herança por tipo de Pokémon

Crie três subclasses de `Pokemon`:

- `PokemonFogo`
- `PokemonAgua`
- `PokemonEletrico`

Adicione à classe `Pokemon` o método:

- `int calcularAtaqueBase()`

Cada subclasse deve sobrescrever esse método com uma regra própria.

**Regras obrigatórias:**

- **PokemonFogo:** ataque base = `nivel * 3`
- **PokemonAgua:** ataque base = `nivel * 2 + 10`
- **PokemonEletrico:** ataque base = `nivel * 2 + 15`

Além disso, sobrescreva `exibirFicha()` para mostrar também a categoria do pokémon.

No `main()`, crie pelo menos **1** objeto de cada subclasse e exiba suas fichas.

---

### Questão 7 — Habilidades com classe abstrata

Crie uma classe abstrata `Habilidade` com os atributos:

- `String nome`
- `int custoEnergia`

E com o método abstrato:

- `void usar(Pokemon usuario, Pokemon alvo)`

Depois, implemente exatamente estas três classes concretas:

- `ChoqueDoTrovao`
- `JatoDAgua`
- `LancaChamas`

**Regras obrigatórias:**

- cada habilidade deve causar dano ao alvo;
- o dano deve ser calculado usando o ataque base do usuário;
- **ChoqueDoTrovao:** dano = ataque base + 5
- **JatoDAgua:** dano = ataque base + 3
- **LancaChamas:** dano = ataque base + 7

Adicione à classe `Pokemon` um campo **energia** e faça cada habilidade descontar energia do usuário. A habilidade só pode ser usada se o usuário tiver energia suficiente.

---

### Questão 8 — Polimorfismo em batalha

Crie uma função que receba:

- um `Pokemon` atacante
- um `Pokemon` defensor
- uma `Habilidade` habilidade

Essa função deve executar a ação da habilidade **sem** usar `if`, `switch` ou teste manual de tipo para descobrir qual habilidade está sendo usada.

No `main()`, simule pelo menos **3 turnos** de batalha entre pokémons diferentes.

**Regras obrigatórias:**

- após cada turno, exibir o nome do atacante, o nome da habilidade e o HP restante do defensor;
- se o defensor chegar a 0 de HP, a batalha deve indicar que ele foi derrotado.

---

### Questão 9 — Interface de registro da Pokédex

Crie uma interface chamada `RegistravelNaPokedex` com os métodos:

- `marcarComoVisto()`
- `marcarComoCapturado()`
- `favoritar()`
- `desfavoritar()`

Implemente essa interface na classe `Pokemon` ou em uma classe auxiliar de registro.

**Regras obrigatórias:**

- além de `capturado`, passe a controlar também:
  - `bool visto`
  - `bool favorito`
- um pokémon só pode ser favoritado se já tiver sido capturado;
- ao marcar como capturado, ele também deve ser marcado como visto automaticamente.

No `main()`, demonstre essas regras com exemplos.

---

### Questão 10 — Funções anônimas para consultas

Usando a coleção da Pokédex, implemente consultas com funções anônimas para:

- filtrar pokémons com `hpAtual` abaixo de 30;
- ordenar os pokémons por nome em ordem alfabética;
- ordenar os pokémons por nível em ordem decrescente;
- selecionar apenas os pokémons favoritos.

Essas operações devem ser feitas a partir da lista já cadastrada na Pokédex.

**Regras obrigatórias:**

- use funções anônimas diretamente nas operações;
- não criar um método nomeado separado para cada comparação ou filtro;
- exibir o resultado de cada consulta no `main()`.

---

### Questão 11 — Estatísticas da Pokédex

Implemente na classe `Pokedex` os métodos:

- `int totalPokemons()`
- `Map<String, int> quantidadePorTipo()`
- `double mediaDeNivel()`
- `double percentualCapturados()`

**Regras obrigatórias:**

- `quantidadePorTipo()` deve agrupar corretamente os pokémons por tipo;
- `mediaDeNivel()` deve retornar valor decimal;
- `percentualCapturados()` deve retornar percentual entre 0 e 100;
- se a Pokédex estiver vazia, os métodos numéricos devem retornar 0 sem erro.

No `main()`, exiba todas as estatísticas com base nos pokémons cadastrados.

---

### Questão 12 — Desafio final: simulação do app

Monte um programa principal que simule o uso completo de uma Pokédex.

O programa deve obrigatoriamente:

- cadastrar pelo menos **8** pokémons;
- ter pokémons de pelo menos **3** tipos diferentes;
- marcar alguns como vistos;
- marcar alguns como capturados;
- favoritar pelo menos **2**;
- aplicar todos os filtros da questão 5;
- realizar pelo menos **1** evolução;
- simular pelo menos **2** batalhas com habilidades;
- exibir as estatísticas finais da Pokédex.

---

## Instruções de entrega (conforme prova)

- Repositório no GitHub com o projeto.
- Este README deve conter a identificação dos integrantes da equipe.
- Enviar o link do repositório na planilha do professor.
- Trabalhos idênticos ou com indícios de cópia terão nota zero.
