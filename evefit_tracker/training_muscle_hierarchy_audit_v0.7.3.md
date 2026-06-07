# EveFit Tracker v0.7.3 - Auditoria da hierarquia muscular

## Objetivo do hotfix

Corrigir o nível "Músculo específico" no fluxo de Musculação para deixar de saltar diretamente de grupo muscular para poucas opções. A nova lógica suporta:

- Região corporal
- Grupo muscular
- Subzona anatómica, quando aplicável
- Músculo específico/foco, quando aplicável
- Exercícios compatíveis com equipamento e perfil

## Hierarquia por região

### Parte superior

- Peito: Peito completo, Peito superior, Peito médio, Peito inferior, Peitoral menor, Serrátil anterior.
- Costas: Costas completo, Costas superior, Costas média, Costas inferior / lombar, Costas largura, Costas espessura.
- Ombros: Ombros completo, Deltoide anterior, Deltoide lateral, Deltoide posterior, Manguito rotador, Rotadores externos, Rotadores internos, Estabilidade escapular.
- Braços: Braços completo, Braço, Antebraço / punho / mão.
- Trapézio: Trapézio completo, Trapézio superior, Trapézio médio, Trapézio inferior, Estabilização escapular.
- Pescoço: Pescoço completo, Pescoço anterior, Pescoço posterior, Pescoço lateral, Estabilizadores cervicais.

### Braços

Braço abre:

- Bíceps braquial
- Braquial
- Braquiorradial
- Coracobraquial
- Tríceps completo
- Tríceps cabeça longa
- Tríceps cabeça lateral
- Tríceps cabeça medial

Antebraço / punho / mão abre:

- Antebraço completo
- Flexores do antebraço
- Extensores do antebraço
- Pronadores
- Supinadores
- Punho
- Dedos
- Pega de suporte
- Pega de pinça
- Força de pega geral

### Core

- Core completo
- Abdominal
- Lombar
- Estabilidade do core

Abdominal abre:

- Abdominal completo
- Abdominal superior
- Abdominal médio
- Abdominal inferior
- Abdominais laterais / oblíquos
- Reto abdominal
- Oblíquos externos
- Oblíquos internos
- Transverso abdominal

### Parte inferior

- Pernas completo
- Acima do joelho / coxa e anca
- Abaixo do joelho / perna inferior e pé

Acima do joelho / coxa e anca abre quadríceps, posterior de coxa, glúteos, adutores, abdutores, flexores e rotadores da anca.

Abaixo do joelho / perna inferior e pé abre gémeos, sóleo, tibial anterior, tornozelo, pés e estabilidade do tornozelo.

## Como funciona o salto em "completo"

Opções terminadas em "completo" são tratadas como atalhos. Quando selecionadas, a UI não mostra a caixa seguinte de músculo específico.

Exemplos:

- Braços completo -> exercícios gerais de braços.
- Costas completo -> exercícios gerais de costas.
- Core completo -> exercícios gerais de core.
- Abdominal completo -> exercícios gerais de abdominal.
- Pernas completo -> exercícios gerais de pernas.
- Peito completo -> exercícios gerais de peito.
- Ombros completo -> exercícios gerais de ombros.

## Equipamento e filtros

O filtro continua a validar:

- Tipo de treino.
- Equipamento escolhido no treino.
- Região corporal.
- Grupo muscular.
- Subzona anatómica.
- Foco específico.
- Equipamento disponível no perfil.

Para evitar migração de base de dados neste hotfix, a arquitetura antiga faz a seleção grossa por região/grupo/equipamento e a v0.7.3 aplica palavras-chave específicas para focos como Bíceps braquial, Abdominal inferior, Abdominais laterais, Costas inferior e afins.

## Testes criados

- `test/v073_muscle_hierarchy_test.dart`

Cobertura:

- Braços completo não obriga a escolher músculo específico.
- Braço abre bíceps braquial, braquial, braquiorradial, coracobraquial e tríceps.
- Antebraço abre flexores, extensores, pronadores, supinadores, punho, dedos e pega.
- Costas completo, superior e inferior têm hierarquia própria.
- Abdominal abre superior, médio, inferior e laterais.
- Peito abre superior, médio, inferior e serrátil.
- Pernas completo, acima do joelho e abaixo do joelho têm opções específicas.
- Bíceps com halteres mostra curls compatíveis.
- Bíceps com peso corporal sem barra fixa não mostra flexões.
- Tríceps com peso corporal mostra flexões fechadas e fundos quando há apoio.
- Core com peso corporal mostra prancha, crunch, dead bug e hollow hold.

## Limitações conhecidas

- Algumas subzonas muito específicas dependem de exercícios existentes no seed; se não houver exercício correspondente, a lista pode ficar curta.
- A v0.7.3 evita migração estrutural para ser hotfix. O matching fino é feito por keywords normalizadas sobre nome, grupo, grupos secundários e equipamento.
- A UI usa os grupos existentes da arquitetura anterior; a hierarquia de Pernas é normalizada para "Pernas" quando a região é Parte inferior.
