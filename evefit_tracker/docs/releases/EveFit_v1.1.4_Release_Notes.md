# EveFit v1.1.4 — Sete Contextos e Intenções Canónicas

EveFit v1.1.4 torna a pesquisa canónica de treino mais precisa sem adicionar exercícios canónicos.

## Inclui

- Sete contextos explícitos, começando por Treino principal.
- Oito capacidades, 35 conceitos globais e 40 relações capacidade-conceito.
- 280 percursos estruturados: 261 compatíveis e 19 incompatíveis com justificação preservada.
- 591 intenções globais e 771 ligações de intenção dependentes do percurso.
- Fluxo `Contexto → Capacidade → Conceito → Intenção → Exercícios` com breadcrumb, Back, Home e seleção explícita.
- Query estruturada com quatro critérios e sem `exercise_ids`, IDs legacy, protocolos, equipamento ou prescrição.
- Estado vazio claro enquanto não existirem exercícios aprovados para o percurso selecionado.

## Proteções

- Opções avançadas, exigência elevada e revisão clínica aparecem apenas quando são aplicáveis ao percurso.
- Retorno à função não substitui diagnóstico, reabilitação, critérios clínicos ou autorização de retorno ao desporto.
- Catálogo legacy e árvore antiga continuam invisíveis e fora do runtime.
- Schema 22 e migrations não mudam. Perfis, medições, objetivos, treinos e históricos permanecem preservados.

## Estado do catálogo

Esta versão não adiciona atributos oficiais, exercícios canónicos ou subníveis. Foram validados 693 IDs e 792 ocorrências históricas, mas esse histórico não é carregado como dados funcionais do APK.

## Atualização e instalação

- Versão: `1.1.4+6`.
- Atualização alvo, sujeita ao gate obrigatório: `1.1.3+5 → 1.1.4+6`.
- Package Android: `com.sandro.evefittracker`.
- O APK é construído com a configuração de assinatura atual do projeto; não deve ser considerado uma distribuição Play Store sem validação adicional.

## Limitações

O fluxo termina atualmente no estado vazio de Exercícios. Conceitos, intenções, atributos e exercícios adicionais serão aprovados e introduzidos progressivamente numa tarefa futura.
