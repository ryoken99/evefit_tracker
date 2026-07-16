# EveFit v1.1.2 — Pesquisa Canónica Hierárquica

## Objetivo

A v1.1.2 publica como versão estável o fluxo hierárquico de pesquisa canónica de exercícios já integrado e validado na aplicação.

## Alterações visíveis

O seletor aberto por Adicionar exercício conduz o utilizador por:

1. Contexto
2. Capacidade
3. Conceito
4. Intenção
5. Exercícios

Existem cinco contextos explícitos. Treino principal é o primeiro e só participa na pesquisa quando o utilizador o seleciona. As oito capacidades aprovadas permanecem inalteradas. Breadcrumb, Back e Home preservam a navegação entre passos.

## Alterações internas

A query começa vazia. A escolha de contexto cria o primeiro critério `usageContext`; a escolha de capacidade acrescenta `capabilityRoot` como segundo critério. Não existem listas fixas de exercícios, IDs legacy, `parent_id` ou relações de propriedade entre pilares.

## Estado do conteúdo canónico

- Contextos ativos: 5
- Capacidades ativas: 8
- Conceitos ativos: 0
- Intenções ativas: 0
- Atributos oficiais ativos: 0
- Exercícios ativos: 0
- Subníveis ativos: 0

O fluxo termina atualmente num estado vazio de conceitos. Esta versão não define valores futuros nem adiciona conteúdo canónico.

## Legacy e compatibilidade

O catálogo legacy permanece fora do runtime, a árvore anterior permanece invisível e não existe fallback para resultados antigos. O schema e as migrations não são alterados.

Perfis, objetivos, medições, treinos, séries e históricos são preservados. A atualização suportada parte da EveFit v1.1.1 (`1.1.1+3`) para a v1.1.2 (`1.1.2+4`) com o mesmo package e certificado.

## Testes

A release exige validação de metadados, testes focados do Canonical Core e Clean Base, suíte completa, full-app Android no `EveFit_Test_Device`, teste de atualização v1.1.1 → v1.1.2, build release e inspeção do APK.

## Instalação

O APK pode ser instalado diretamente num dispositivo Android que permita aplicações desta origem. Para atualizar uma instalação v1.1.1, instalar o APK v1.1.2 por cima sem limpar os dados.

## Limitações e riscos conhecidos

- Ainda não existem conceitos, intenções ou exercícios canónicos ativos.
- O fluxo termina no estado vazio de conceitos.
- O APK usa a configuração de assinatura existente no projeto; a adequação à Play Store requer validação separada.

## Próximos passos

Conceitos, intenções e exercícios poderão ser definidos em tarefas futuras independentes. Nenhum desses trabalhos é iniciado nesta release.
