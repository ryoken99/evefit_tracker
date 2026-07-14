# EveFit v1.1.1 - Fundação Canónica

A v1.1.1 é uma correção arquitetural e de escopo da pesquisa de exercícios.
O runtime passa a refletir apenas os elementos aprovados no Script Canónico
EveFit, sem antecipar taxonomias ou conteúdo futuro.

## Fundação ativa

- Quatro eixos: capacidade, intenção, conceito de treino e contexto.
- Oito raízes de capacidade.
- Quatro contextos de utilização.
- Doze valores classificatórios ativos.
- Zero intenções, conceitos ou atributos oficiais ativos.
- Zero subníveis e zero exercícios.

Selecionar uma raiz ou um contexto executa uma query tipada e termina num estado
vazio real. Intenção e conceito permanecem identificados como vocabulários em
definição. Não existe `main_training`, `exercise_ids`, lista proprietária de
resultados ou fallback para o catálogo legacy.

## Preservação e compatibilidade

Os 234 subníveis ainda não aprovados foram removidos do runtime. A árvore
anterior de 246 nós está preservada em
`docs/research/unapproved/Canonical_Search_Subtrees_v0.1_Unapproved_Draft.md`,
marcada como **NÃO APROVADA** e fora do bundle da aplicação.

O catálogo e os filtros legacy continuam fora do runtime. A versão não altera
o schema da base de dados, não cria migrations e preserva perfis, medições,
objetivos, treinos e históricos.

## Validação

A release foi validada com analyze, 31 testes focados, 585 testes na suíte
completa, builds debug e release, três testes Android full-app em instalação
limpa e upgrade do APK oficial v1.1.0. As três medições no
`EveFit_Test_Device` produziram mediana de 1501 ms até ao primeiro ecrã, 115 ms
até abrir Explorar exercícios e 119 ms até ao resultado vazio.

## Limitações

- A pesquisa ainda devolve zero exercícios.
- Intenções e conceitos permanecem em definição.
- Não existem subfiltros ativos.
- Não foi iniciado trabalho da v1.2.
- O APK usa a configuração de assinatura existente no projeto.

A v1.1.1 não adiciona exercícios, intenções, conceitos ou atributos oficiais. Apenas alinha o runtime com os elementos já aprovados do Script Canónico EveFit.
