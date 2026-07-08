# v0.9.9B - Plano de implementação proposto

Este plano depende de aprovação humana. A v0.9.9A não implementa estes blocos.

## Bloco A - hardening crítico

- Ficheiros prováveis: `ios/Runner/Info.plist`, `lib/database/app_database.dart`, modelos em `lib/models/`, fluxos de gravação em `lib/screens/`, testes de migração e smoke tests.
- Risco: alto, porque pode afetar dados locais, permissões iOS e persistência.
- Testes: migração com DB legado, save de treino, save de foto, profile gate erro, export CSV, `flutter test`, auditoria strict.
- Exercícios novos: 0.
- Impacto por categoria: nenhum.

## Bloco B - equipamentos de musculação essenciais

- Ficheiros prováveis: catálogo de exercícios, aliases, contextos, testes de catálogo e relatórios.
- Risco: médio, por duplicação de variantes e compatibilidade de filtros.
- Testes: matriz total, reachability, wrong-results, auditoria strict.
- Exercícios estimados: 95 essenciais, 18 backlog/futuro.
- Impacto: musculação 207 -> até 320 se aprovado na totalidade.

## Bloco C - ativação e prevenção

- Ficheiros prováveis: catálogo, descrições, contextos de pré-treino/prevenção, testes de qualidade textual.
- Risco: médio-alto, por necessidade de linguagem segura para iniciantes.
- Testes: qualidade de descrição, músculos válidos, eixos de articulação, auditoria strict.
- Exercícios estimados: ativação 38, prevenção 36.
- Impacto: ativação 52 -> 90; prevenção 44 -> 80.

## Bloco D - artes marciais gerais

- Ficheiros prováveis: catálogo marcial, contextos dojo/tatami/saco, focos técnicos, testes de rotas marciais.
- Risco: alto, por precisão técnica e risco de duplicar Karate genérico vs estilos.
- Testes: matriz marcial, Karate geral, BJJ, defesa pessoal, wrong-results.
- Exercícios estimados: 68.
- Impacto: artes marciais 232 -> 300.

## Bloco E - Shukokai somente com aprovação do Sandro

- Ficheiros prováveis: catálogo marcial, proposta Shukokai, testes específicos de estilo.
- Risco: alto, depende de validação técnica externa.
- Testes: rotas Dojo > Karate > Shukokai, descrições, focos técnicos, auditoria strict.
- Exercícios estimados: a definir após validação.
- Impacto: não estimado nesta fase.

## Bloco F - ajustes finais cardio/mobilidade/elasticidade/recuperação/aquecimento

- Ficheiros prováveis: catálogo e contextos dos domínios secundários.
- Risco: baixo-médio.
- Testes: cobertura por equipamento, articulação, local e fallback.
- Exercícios estimados: cardio 15, mobilidade 27, elasticidade 28, recuperação 18, aquecimento 9.
- Impacto: categorias atingem metas mínimas funcionais sem expansão massiva.
