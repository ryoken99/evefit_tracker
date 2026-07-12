# EveFit v1.1.0 - Fundação Canónica

## Objetivo

Esta versão estabelece a fundação limpa e estável da nova arquitetura canónica
da EveFit. Ela integra a navegação canónica da área de exercícios e remove o
catálogo legacy do runtime, preservando dados pessoais e históricos.

Esta versão não adiciona novos exercícios.

## Alterações visíveis

- Nova área “Explorar exercícios”.
- Oito capacidades em “O que queres desenvolver?”.
- Quatro contextos em “Para que momento ou finalidade?”.
- Navegação em três níveis, breadcrumbs e Back do Android.
- Estados vazios intencionais em todos os 189 terminais.
- Nenhum resultado legacy, filtro legacy ou “Mostrar todos”.
- Correção das heroTags dos FloatingActionButton que podiam coexistir.

## Fundação canónica

O menu contém 12 raízes visíveis, 45 nós de nível 2, 189 terminais e 246
nós no total. As queries usam condições estruturadas; nenhum nó ou filtro
possui uma lista de `exercise_ids`. O contexto `main_training` é implícito ao
entrar por uma capacidade e não cria uma quinta raiz de contexto.

O catálogo canónico ativo está vazio. Os terminais não consultam rows legacy e
não permitem ainda escolher um exercício para um treino.

## Remoção do runtime legacy

O arranque deixou de carregar, transformar, validar, inserir ou indexar as 1762
entradas do catálogo antigo. O seed legacy está desativado e o contador de
entradas processadas no arranque é zero.

As fontes originais estão documentadas em
`docs/archive/legacy_catalog/`, com commit de origem e checksums. O material é
histórico, não é fonte de verdade canónica e não foi convertido
automaticamente.

## Compatibilidade e dados

- Perfis preservados.
- Medições preservadas.
- Objetivos preservados.
- Treinos, séries e histórico preservados.
- Rows legacy referenciadas por histórico permanecem passivamente na base.
- Foreign keys e joins históricos permanecem válidos.
- Rows históricas não aparecem na pesquisa canónica nem podem criar novos
  treinos.

Nenhuma migration destrutiva foi criada e a tabela `exercises` permanece no
schema para compatibilidade e evolução futura.

## Performance

No mesmo AVD, build debug e procedimento de instalação limpa:

- mediana antes: 181530 ms;
- pior antes: 186670 ms;
- mediana depois: 1637 ms;
- pior depois: 1644 ms;
- melhoria da mediana: 99.098%;
- seed legacy depois: 0 ms;
- entradas legacy processadas depois: 0.

## Validação

- Flutter format e analyze.
- Testes unitários e widget.
- Suíte completa de 574 testes.
- Full-app Android em instalação limpa.
- Upgrade Android sobre uma base com 1762 rows legacy e histórico pessoal.
- Verificação de foreign keys e contagens antes/depois.
- Builds APK debug e release.

## Limitações

- Os filtros canónicos terminam em estados vazios.
- Ainda não existem exercícios canónicos ativos.
- O APK usa a configuração de assinatura atual do projeto e não deve ser
  assumido como build Play Store sem verificação adicional.

## Próximos passos

Os exercícios canónicos poderão ser adicionados progressivamente em pequenos
lotes validados numa futura v1.2. Esse trabalho não faz parte desta release.
