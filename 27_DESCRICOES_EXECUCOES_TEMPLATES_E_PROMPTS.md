# 27 - Descrições, execuções, templates e prompts

## Objetivo

Este ficheiro define como escrever descrições corretas, úteis e consistentes para cada exercício da EveFit.

A regra base é:

```text
A descrição deve ensinar execução, objetivo, contexto e segurança.
Não basta dizer que músculo trabalha.
```

## Template global

```text
Título
Objetivo
Domínio principal
Domínios secundários
Alvo principal
Alvos secundários
Equipamento
Local
Nível
Quando usar
Posição inicial
Execução passo a passo
Respiração
Ritmo ou tempo
Erros comuns
Versão mais fácil
Versão mais difícil
Cuidados de segurança
Filtros onde deve aparecer
```

## Templates por domínio

| Domínio | Campos obrigatórios | Atenção especial |
| --- | --- | --- |
| Musculação | objetivo, músculos, equipamento, setup, execução, tempo, respiração, erros, progressão, segurança | carga, amplitude, controlo, séries de aproximação |
| Cardio | objetivo, modalidade, intensidade, duração, ritmo, sinais, regressão, progressão, segurança | zona, impacto, respiração, superfície |
| Artes marciais | objetivo técnico, guarda/base, passos, aplicação, erros, parceiro, contacto, segurança, limitação | controlo, não prometer eficácia real |
| Mobilidade | articulação, função, amplitude ativa, ritmo, respiração, compensações, regressão, progressão | controlo ativo, sem dor |
| Elasticidade | zona alvo, método, intensidade, tempo, entrada, manutenção, respiração, saída, cuidados | sensação controlada, não dor |
| Recuperação | objetivo, sistema, intensidade, duração, como saber que está leve, sinais de alerta | não criar fadiga |
| Aquecimento | treino alvo, zona alvo, dose, execução, como saber que está pronto, erro de fadiga | preparar sem cansar |
| Prevenção | capacidade alvo, progressão, dose, técnica, sinais de irritação, limites | não prometer evitar lesões |

## Exemplos de má e boa descrição

| Problema | Errado | Correto |
| --- | --- | --- |
| Vago | Trabalha costas. | Trabalha costas largura com foco no dorsal, mantendo escápulas controladas e cotovelos a puxar para baixo. |
| Sem execução | Faz remada. | Inclina o tronco, mantém coluna estável, puxa o cotovelo para trás e controla a descida. |
| Sem segurança | Alongar até sentir bastante. | Mantém sensação leve a moderada e para se houver dor, formigueiro ou pressão articular. |
| Sem contexto | Caminha 10 minutos. | Caminha 10 minutos em ritmo fácil como cooldown, terminando com respiração controlada. |
| Promessa falsa | Evita lesões no ombro. | Ajuda a melhorar controlo e tolerância do ombro, sem garantir prevenção de lesões. |

## Template de musculação

```text
Objetivo:
Explica o padrão e o músculo principal.

Posição inicial:
Define banco, pega, pés, coluna, escápulas e carga.

Execução:
1. Inicia com controlo.
2. Move pela articulação certa.
3. Mantém o alvo sob tensão.
4. Controla a fase de retorno.
5. Termina sem perder postura.

Erros comuns:
- Compensar com lombar.
- Usar balanço.
- Perder amplitude útil.
- Escolher carga que destrói técnica.

Segurança:
Define dor, amplitude, spotter, articulações e regressões.
```

## Template de cardio

```text
Objetivo:
Define se é aquecimento, zona 2, intervalado, HIIT, sprint ou recuperação.

Intensidade:
Usa conversa, respiração, RPE ou frequência cardíaca quando disponível.

Execução:
1. Começa leve.
2. Entra no ritmo definido.
3. Mantém técnica e respiração.
4. Termina com cooldown quando necessário.

Erros comuns:
- Ir rápido demais.
- Ignorar impacto.
- Saltar aquecimento em HIIT ou sprints.
```

## Template de artes marciais

```text
Objetivo técnico:
Define base, golpe, defesa, queda, escape ou transição.

Execução:
1. Começa em posição segura.
2. Faz o movimento por fases.
3. Mantém guarda, base e distância.
4. Adiciona velocidade só depois de controlo.
5. Em parceiro, começa cooperativo.

Limitação:
Não prometer vitória em defesa pessoal.
A prioridade é distância, segurança, saída e controlo.
```

## Template de mobilidade

```text
Objetivo:
Controlar amplitude ativa de uma articulação.

Execução:
1. Entra numa posição estável.
2. Move devagar.
3. Evita compensações.
4. Mantém respiração.
5. Usa amplitude sem dor.

Erro comum:
Transformar mobilidade em alongamento passivo.
```

## Template de elasticidade

```text
Objetivo:
Ganhar tolerância numa posição alongada.

Execução:
1. Entra devagar na posição.
2. Para numa sensação leve a moderada.
3. Respira.
4. Mantém pelo tempo definido.
5. Sai devagar.

Erro comum:
Forçar dor ou articulação em vez de alongar tecido alvo.
```

## Template de recuperação

```text
Objetivo:
Baixar fadiga, tensão, rigidez ou ativação.

Execução:
1. Mantém intensidade baixa.
2. Faz o método pelo tempo definido.
3. Verifica se estás melhor ou igual.
4. Para se houver sinais de alerta.

Erro comum:
Transformar recuperação em treino escondido.
```

## Prompt mestre para gerar descrições uma a uma

```text
Para cada exercício do catálogo, gera uma ficha pt-PT com o template do domínio correto.
Usa o concept_id e os filtros para manter consistência.
Não inventes equipamento.
Não inventes músculo alvo.
Não dupliques exercícios.
Quando um exercício cruzar domínios, mantém a mesma entidade e ajusta apenas contexto, intensidade e objetivo.
Inclui sempre cuidados de segurança.
Para defesa pessoal, nunca prometas vitória numa luta real.
Para prevenção, nunca prometas evitar lesões.
Para recuperação, mantém intensidade baixa.
Para mobilidade, foca controlo ativo.
Para elasticidade, foca tolerância em posição alongada.
```

## Testes obrigatórios de texto

```text
nenhuma descrição fica com menos de objetivo, setup, execução, erros e segurança
nenhum exercício usa músculos errados
nenhum exercício usa equipamento inexistente
nenhum exercício de parceiro ignora parceiro
nenhum exercício de queda ignora superfície segura
nenhuma descrição usa linguagem vaga como faz normalmente
nenhuma descrição promete cura, prevenção total ou eficácia real em defesa pessoal
português deve ser pt-PT
```

## Próximo ficheiro

```text
28_TESTES_QA_E_AUDITORIA_CATALOGO.md
```
