# EXERCISE_CATALOG_REPORT — v0.8.0

Data: 2026-06-22

## Resultado

| Métrica | Resultado |
|---|---:|
| Entradas totais | 314 |
| Nomes únicos | 308 |
| Exercícios novos | 9 |
| Entradas revistas/enriquecidas | 314 |
| Entradas com todos os campos pedagógicos | 314 |
| Descrições duplicadas | 0 |
| Execuções duplicadas | 0 |
| Execuções genéricas/placeholder | 0 |
| Sem equipamento canónico | 0 |
| Sem músculo principal | 0 |
| Sem tags anatómicas | 0 |
| Pendentes | 0 |

Cada entrada tem descrição objetiva, passos numerados, erros comuns, segurança, regressão, progressão, respiração, postura, adaptação, músculo principal/secundários, equipamento e taxonomia canónica. O teste v0.8.0 exige pelo menos 11 passos concretos por execução.

## Exercícios novos

- Short foot / doming.
- Flexão ativa dos dedos do pé.
- Dorsiflexão do tornozelo com elástico.
- Inversão do tornozelo com elástico.
- Eversão do tornozelo com elástico.
- Flexão da anca em pé com elástico.
- Copenhagen plank com apoio.
- Extensão terminal do joelho com elástico.
- Abdução de anca deitada.

Estas adições fecham lacunas reais de pé intrínseco, dedos, tibial anterior, controlo multidirecional do tornozelo, flexores da anca, adutores, vasto medial e glúteos médio/mínimo. Não foram criados sinónimos artificiais nem variações apenas para aumentar a contagem.

## Cobertura anatómica

A matriz automática cobre todos os grupos pedidos: pescoço; trapézio superior/médio/inferior; escápulas, romboides e serrátil; peito superior/médio/inferior e peitoral menor; largura/espessura das costas, dorsal e redondos; lombar; três porções do deltoide e manguito; bíceps, braquial e braquiorradial; três cabeças do tríceps; antebraço, pronação, supinação, punho, dedos e pega; todas as funções de core pedidas; glúteos; quadríceps e vastos; posteriores de coxa; adutores/abdutores; flexores da anca; gémeos, sóleo, tibial, tornozelo e pés; cardio; mobilidade; Karate; Jiu-Jitsu.

Face está explicitamente excluída e o teste falha se surgir no catálogo ou na taxonomia.

## Equipamento e local

- Peso corporal disponível em todos os perfis.
- Casa sem equipamento não recebe bandas, barras, halteres, cabos ou máquinas.
- Casa com equipamento recebe apenas as capacidades selecionadas.
- Ginásio recebe máquinas, cabos, halteres, barras, discos, bancos e cardio.
- Exterior recebe caminhada, corrida e sprints.
- Dojo/tatami recebe Karate, Jiu-Jitsu, mobilidade e condicionamento compatível.
- “Mostrar todos” conserva entradas indisponíveis com razão explícita.

## Decisões científicas

- A seleção favorece padrões reconhecidos, progressão gradual e controlo técnico. A posição oficial do ACSM sustenta progressão individual de carga, volume e complexidade: https://pubmed.ncbi.nlm.nih.gov/19204579/
- O short-foot foi incluído como exercício de musculatura intrínseca/controlo do arco; um ensaio aleatorizado mostrou melhoria de função dinâmica do pé quando combinado com treino dos membros inferiores: https://pubmed.ncbi.nlm.nih.gov/37379736/
- O Copenhagen plank foi incluído como progressão de adutores, sempre com regressão apoiada; um ensaio randomizado por clusters mostrou redução de problemas de virilha com um programa de fortalecimento de adutores: https://pubmed.ncbi.nlm.nih.gov/29891614/
- A abdução lateral de anca foi incluída para glúteo médio/mínimo com orientação de rotação da anca; atividade dos abdutores muda com a rotação durante este exercício: https://pubmed.ncbi.nlm.nih.gov/24560168/

Estas fontes suportam as famílias e decisões de inclusão, não uma alegação de que cada variação é superior ou adequada a todas as pessoas.

## Exercícios excluídos

- Exercícios faciais: fora do âmbito explícito da release.
- Variações com diferenças apenas nominais: evitadas para não duplicar o catálogo.
- Movimentos de risco sem regressão clara ou benefício prático: não adicionados.
- Exercícios dependentes de marca/modelo específico: representados pela família canónica de equipamento.

## Grupos sem opção realista

Nenhum dos grupos anatómicos pedidos ficou sem uma opção realista. Nem todos os músculos possuem um isolamento seguro e útil; nesses casos são classificados como principais ou secundários de padrões compostos/controlo articular, sem inventar um exercício artificial.
