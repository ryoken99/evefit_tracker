# Reestruturação do catálogo — FASE 1: auditoria do estado atual

> Documento preparatório da reestruturação baseada nos ficheiros 10-30.
> A secção 1 (arquitetura atual) está completa; a secção 2 (comparação com
> os ficheiros 10-30) será preenchida assim que os ficheiros estiverem
> acessíveis.

## 1. Onde está guardado cada conceito no código atual

| Conceito | Localização | Forma atual |
|---|---|---|
| **Exercícios (nomes)** | `lib/database/seed_data.dart` → `SeedData.exercisesByGroup` | 398 strings em 15 grupos (Pescoço, Trapézio, Ombros, Peito, Costas, Lombar, Bíceps, Tríceps, Antebraço/Pega, Core, Pernas, Cardio, Karate, Jiu-Jitsu, Mobilidade) |
| **Identidade estável** | `ExerciseCatalogContextService.stableKey(name)` + `catalogEntryKey = '<exerciseKey>__<contextKey>'` | Derivada do NOME (não é um ID canónico independente); IDs `E###` são posicionais e mudam com inserções |
| **Categorias / tipos de treino** | `lib/services/training_flow.dart` → `TrainingFlow.types` | strength, cardio, martial_arts, mobility, recovery, custom — **não existem** tipos separados para elasticidade, aquecimento, ativação, prevenção (vivem misturados em Mobilidade/Cardio) |
| **Grupos/subgrupos musculares** | `lib/services/training_architecture.dart` (taxonomia regions→groups→subgroups→muscles) + `training_flow.dart` (`_strengthSubzones`, `_strengthSpecificBySubzone`) | Duas hierarquias paralelas (taxonomia interna + hierarquia de UI) ligadas por aliases no filtro |
| **Atribuição de músculos a exercícios** | `training_architecture.dart` → `_tagsForCatalogEntry` + helpers (`_shoulderMuscles`, `_coreMuscles`, …) | **Por matching de substrings do nome** — frágil; foi a origem de vários bugs corrigidos (ex.: "Rotação externa da anca" tratada como ombro) |
| **Equipamentos** | `lib/services/equipment_catalog_service.dart` (`definitions`, `gymEquipmentKeys`, `availableKeys`) | Chaves canónicas (dumbbells, barbell, foam_roller, heavy_bag, …); o TEXTO de equipamento por exercício vem de `exercise_catalog_detail_service.dart` (`equipmentFor`, matching por nome) e é convertido de volta a chaves por `equipmentKeysFor` (parser de texto) — ida-e-volta texto↔chave |
| **Locais** | `equipment_catalog_service.dart` → `availableKeys(trainingLocations…)` | Por substring do nome do local ('casa', 'ginásio', 'exterior', 'dojo') |
| **Requisitos/alternativas de equipamento** | `lib/services/exercise_capability_service.dart` | `requirementGroups` (grupos OR), `_supportRequirements` por exerciseKey |
| **Filtros / regras de visibilidade** | `lib/services/exercise_filter_service.dart` | `matchesSelection` (tags) + `_matchesHierarchyFocus` (aliases → predicados → keywords, default-false) + disponibilidade por capability |
| **Menus de seleção** | `training_flow.dart` (labels e listas por tipo) + ecrãs em `lib/screens/` | Navegação: tipo → região/grupo → subzona → músculo (strength); modo (cardio); arte → foco (martial); zona (mobility); tipo (recovery) |
| **Descrições/execuções** | `lib/services/exercise_catalog_context_service.dart` (~5000 linhas) | Mapas por nome normalizado (`_summaryByName`, `_specificSteps`, `_mistakesFor`, `_regressionFor`, `_progressionFor`, `_safetyFor`, …) + moldes por família |
| **Persistência** | `lib/database/app_database.dart` (SQLite v21) | Upsert idempotente por `catalog_entry_key` (`refreshCatalogExercises`); is_default=1 vs personalizados |
| **QA/gates** | `lib/services/catalog_quality_gate_service.dart` + `test/` (417 testes) | Pedagogia, famílias de movimento, texto↔equipamento, segurança, combinatórias de filtros |

## 2. Fraquezas estruturais já conhecidas (independentes dos ficheiros 10-30)

1. **Sem IDs canónicos**: a identidade deriva do nome em português; renomear
   um exercício muda a chave (a migração protege, mas é frágil).
2. **Classificação por substring de nome**: músculos, equipamento e passos
   são atribuídos por matching de texto — cada exercício novo exige regras
   novas espalhadas por 4 ficheiros.
3. **Sem primary_type/secondary_types**: um exercício pertence a UM grupo
   de seed; contextos múltiplos (ex.: technical stand-up em mobilidade+BJJ)
   são simulados com cross-tags ad hoc.
4. **Domínios misturados**: elasticidade, recuperação, aquecimento, ativação
   e prevenção vivem dentro do grupo "Mobilidade" ou espalhados; a distinção
   ativa/passiva/PNF está apenas no nome/texto.
5. **Artes marciais limitadas**: só Karate e Jiu-Jitsu; sem Boxe,
   Kickboxing, Muay Thai, Judo, Taekwondo, defesa pessoal.
6. **Sem campo de nível** (iniciante/intermédio/avançado) no modelo — é
   heurística de relatório, não dado.
7. **Sem campo de contexto** (treino principal vs aquecimento vs recuperação).
8. **Texto de equipamento como fonte** (parser texto→chaves) em vez de
   chaves como fonte e texto derivado.

## 3. Comparação com os ficheiros 10-30

> **PENDENTE — bloqueado**: a pasta do Google Drive não é acessível a
> partir deste ambiente (política de rede bloqueia drive.google.com).
> Esta secção será preenchida ficheiro a ficheiro quando o conteúdo estiver
> disponível no repositório ou no chat.

| Ficheiro | Estado |
|---|---|
| 10-11 Musculação | por comparar |
| 12-13 Cardio | por comparar |
| 14-15 Artes marciais | por comparar |
| 16-17 Mobilidade | por comparar |
| 18-19 Elasticidade | por comparar |
| 20-21 Recuperação | por comparar |
| 22-23 Aquecimento/ativação/prevenção | por comparar |
| 24 Locais e equipamentos | por comparar |
| 25 Filtros e visibilidade | por comparar |
| 26 Modelo de dados e IDs | por comparar |
| 27 Descrições/execuções | por comparar |
| 28 Testes/QA | por comparar |
| 29 Importação/entrega | por comparar |
| 30 Índice/roadmap | por comparar |
