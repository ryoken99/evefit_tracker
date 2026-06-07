# EveFit Tracker - Exercise Description Quality v0.7.6

Data: 2026-06-07

## Objetivo

Remover placeholders e descrições genéricas dos exercícios visíveis, garantindo explicações mais claras para iniciantes.

## Problemas encontrados

| ID | Área | Evidência | Estado inicial | Correção | Estado final |
|---|---|---|---|---|---|
| DESC-001 | UI do modal de explicação | `lib/screens/workout_detail_screen.dart` | Campo vazio mostrava placeholder sobre descrição incompleta | Fallback alterado para `Sem informação adicional.` | CORRIGIDO |
| DESC-002 | Passos de execução | `lib/database/app_database.dart::_stepsFor` | Fallback usava texto genérico proibido sobre preparar posição e confirmar equipamento | Fallback reescrito com passos concretos de pés/mãos/carga/tronco/respiração/regresso | CORRIGIDO |
| DESC-003 | Secundários vazios | `lib/database/app_database.dart::_secondaryGroupsFor` | Exercícios sem secundários deixavam campo vazio e acionavam placeholder | Fallback `Sem secundários relevantes` e secundários específicos para mobilidade/pescoço | CORRIGIDO |
| DESC-004 | Mobilidade | `lib/database/app_database.dart::_descriptionFor`, `_stepsFor`, `_safetyNotesFor` | Alongamentos tinham descrições pouco úteis | Criados textos por mobilidade, cervical, glúteos, posterior, ombros, peitoral, dorsal, tornozelo e punhos | CORRIGIDO |
| DESC-005 | Exercícios de risco | `lib/database/app_database.dart::_safetyNotesFor` | Segurança já existia, mas precisava ser preservada sem placeholders | Mantidas notas reforçadas para pescoço/cervical, lombar, peso morto, agachamento, HIIT, sprints e artes marciais | CORRIGIDO |
| DESC-006 | Erros comuns | `lib/database/app_database.dart::_commonMistakesFor` | Fallback genérico demais | Reescrito para mencionar pressa, compensações, amplitude, trajetória e intensidade | CORRIGIDO |

## Textos proibidos verificados

Os testes v0.7.6 impedem estes textos em ficheiros de produção que alimentam a UI:

- `Descrição ainda incompleta`
- `será melhorado numa próxima versão`
- `prepara a posição inicial`
- `confirma que o equipamento está estável`
- `executa com boa técnica`

Resultado: nenhum destes textos permanece nos ficheiros de produção testados.

## Formato final das explicações

A app continua a apresentar as secções já existentes:

- Grupo principal
- Grupos secundários
- Equipamento
- Descrição
- Execução
- Erros comuns
- Segurança

O conteúdo gerado para essas secções foi melhorado para cobrir:

- o que o exercício faz;
- foco principal;
- secundários úteis;
- equipamento claro;
- passos numerados;
- erros comuns concretos;
- segurança específica quando há risco.

## Exemplos revistos

### Alongamento cervical leve

- Secundários: trapézio superior, respiração e controlo cervical.
- Execução: sentar/ficar de pé, ombros relaxados, mover devagar, respirar 15 a 30 segundos, regressar ao centro sem impulso.
- Segurança: parar com dor aguda, tontura, formigueiro ou pressão na cabeça.

### Curl com halteres

- Descrição: flexão do cotovelo para bíceps e músculos do braço.
- Execução: segurar carga, evitar balanço, contrair no topo, descer controlado.
- Segurança: carga controlável e atenção a cotovelo/punho.

### Mobilidade de glúteos/posterior

- Descrição: mobilidade ou alongamento para melhorar amplitude confortável sem carga externa.
- Execução: posição confortável, tensão leve, respiração, saída lenta da posição.
- Segurança: não forçar dor nem ganhar amplitude com impulso.

## Testes criados

Ficheiro: `test/v076_exercise_catalog_quality_test.dart`

Cobertura:

- nenhum exercício visível do fixture tem descrição vazia;
- todos têm passos numerados;
- todos têm erros comuns;
- todos têm segurança;
- fonte de produção não contém placeholders/textos proibidos.

## Resultado da validação

- `flutter pub get`: OK
- `flutter analyze`: OK
- `flutter test`: OK, 130 testes passados
- `flutter build apk --release`: OK

## Limitações conhecidas

- As descrições são geradas por padrões por nome/grupo/equipamento. A v0.7.6 melhora qualidade e remove placeholders, mas não cria uma página editorial única escrita à mão para cada exercício individual.
- A próxima melhoria natural seria migrar o catálogo para metadata estruturada por exercício em vez de derivar parte dos campos pelo nome.
