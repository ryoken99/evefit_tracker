# Script Canónico EveFit v1.0

## Regra central

Os pilares classificam. Os atributos identificam e distinguem. A prescrição
define como o exercício é utilizado numa sessão.

```text
CLASSIFICAÇÃO = raiz de capacidade + intenção de treino
              + conceito de treino + contexto de utilização

IDENTIDADE = atributos técnicos e mecânicos

UTILIZAÇÃO = contexto + prescrição + condições disponíveis
```

- Os pilares dizem o que o exercício representa.
- Os atributos dizem qual é o exercício.
- A prescrição diz como será utilizado naquela sessão.

## Quatro pilares

1. **Raiz de capacidade**: grande capacidade ou habilidade desenvolvida.
2. **Intenção de treino**: adaptação ou resultado específico procurado.
3. **Conceito de treino**: ação funcional ou ideia de treino.
4. **Contexto de utilização**: momento ou finalidade de uso na sessão.

Os quatro pilares são eixos conceptuais. Não são valores classificatórios e
não formam uma hierarquia pai-filho.

## Raízes de capacidade aprovadas

| ID | Nome | Definição |
|---|---|---|
| `muscular_capacity` | Força e capacidade muscular | Capacidade de produzir, sustentar, controlar ou tolerar força muscular. |
| `cardio_conditioning` | Cardio e condicionamento | Capacidade cardiorrespiratória, resistência geral e capacidade de sustentar ou recuperar de esforço. |
| `speed_power` | Velocidade e potência | Capacidade de produzir movimento ou força rapidamente. |
| `mobility` | Mobilidade | Amplitude ativa, controlo articular e acesso controlado a posições. |
| `flexibility` | Flexibilidade | Amplitude passiva e tolerância ao alongamento dos tecidos. |
| `motor_control_coordination` | Controlo motor e coordenação | Organização, precisão, equilíbrio, estabilidade, reação e controlo do movimento. |
| `technique_skill` | Técnica e habilidade | Aprendizagem ou aperfeiçoamento de uma técnica, gesto ou habilidade concreta. |
| `breathing_regulation` | Respiração e regulação corporal | Mecânica respiratória, controlo da respiração, consciência e regulação corporal. |

Estas oito raízes não têm filhos aprovados nesta fundação.

## Contextos aprovados

| ID | Nome | Definição |
|---|---|---|
| `warmup` | Aquecimento | Preparação gradual do corpo, movimento ou técnica para uma atividade posterior. |
| `activation` | Ativação | Preparação específica de músculos, articulações, padrões ou controlo neuromotor. |
| `recovery_cooldown` | Recuperação e retorno à calma | Redução progressiva da intensidade e apoio à recuperação após esforço. |
| `prevention_adaptation_return` | Prevenção, adaptação e retorno à função | Desenvolvimento gradual de controlo, tolerância e capacidade de retorno a uma atividade. |

Não existe um quinto contexto escondido. O contexto de treino principal não
está aprovado e não é injetado nas pesquisas.

## Intenções e conceitos

A existência dos dois eixos está aprovada. Os vocabulários não estão.

- Intenções aprovadas: **0**.
- Conceitos aprovados: **0**.
- Valores `draft` não são apresentados nem usados em pesquisas.

Não devem ser inferidos exemplos, opções ou listas para preencher a interface.

## Atributos

Os atributos técnicos e mecânicos identificam e distinguem exercícios. A
fundação define apenas o contrato estrutural de uma futura definição de
atributo: identificador, nome, descrição, grupo, cardinalidade, tipo de valor,
estado de aprovação e versão.

Não estão aprovados vocabulários de músculos, articulações, padrões,
equipamentos, superfícies, trajetórias ou posições. Atributos aprovados: **0**.

## Identidade e variações

Um exercício canónico é uma ação concreta, reconhecível e tecnicamente
distinta. A identidade pode mudar com alterações significativas da técnica,
mecânica, trajetória, posição corporal, articulações ativas, ação articular,
aplicação da força, suporte, contacto, alvo funcional, finalidade técnica ou
relação com objeto ou parceiro.

Uma variação preserva a identidade técnica e mecânica essencial. A pergunta de
controlo é: **A técnica e a mecânica fundamentais permanecem essencialmente
iguais?**

Esta fundação não cria assinaturas, heurísticas, linhas de variação ou deteção
automática de duplicados.

## Protocolos e prescrição

Protocolos não são exercícios. A prescrição não define identidade. HIIT,
Tabata, EMOM, AMRAP, circuito, supersérie e intervalos não são criados como
exercícios, pilares, conceitos ou opções de pesquisa nesta fase.

## Filtros como pinças

Um filtro é um conjunto estruturado de critérios. Pode capturar qualquer futuro
exercício canónico que satisfaça esses critérios, sem possuir listas fixas de
IDs. Um exercício pode ser encontrado por várias pinças sem ser duplicado.

O contrato `canonical_core_search/0.1` suporta múltiplos critérios, mas a
interface atual produz exatamente um critério aprovado por pesquisa:

- uma raiz de capacidade; ou
- um contexto de utilização.

A pesquisa nunca contém resultados fixos, caminhos de nós, IDs legacy ou
subcategorias proprietárias.

## Aprovado

- Quatro pilares conceptuais.
- Oito raízes de capacidade.
- Quatro contextos de utilização.
- Distinção entre classificação, identidade e utilização.
- Atributos como camada de identidade.
- Princípios de exercício e variação.
- Protocolos separados de exercícios.
- Filtros como queries estruturadas.

## Por aprovar

- Intenções oficiais.
- Conceitos oficiais.
- Atributos e vocabulários oficiais.
- Subfiltros.
- Schema final de exercícios.
- Primeiro exercício canónico.
- Combinações visíveis de critérios.
- Contexto de treino principal.

## Limites da fundação

A versão `0.1` é uma fundação interna, não um schema final imutável. Não altera
a base de dados, não cria persistence, não adiciona exercícios e não converte
conteúdo legacy. O repositório ativo de pesquisa devolve uma lista real vazia
até existir conteúdo canónico aprovado.
