# v0.9.1

- Revisão pedagógica completa dos 315 exercícios do catálogo: objetivo curto e específico, execução em lista de 4 a 7 passos, erros comuns em lista e versões mais fácil/difícil concretas.
- Corrigida a linguagem errada de equipamento (exercícios de peso corporal deixaram de falar em "carga"; cada tipo de equipamento tem instruções próprias).
- Flexão diamante, Curl arrastado com halteres e Tate press ensinados corretamente, passo a passo.
- Novo modal de detalhes do exercício com secções (Resumo, Objetivo, Como fazer, Erros comuns, Variações, Segurança) e listas verticais legíveis no telemóvel.
- Migração segura: instalações existentes recebem os textos novos sem tocar em exercícios personalizados, treinos, séries, medidas, fotos ou objetivos.
- Novos testes e quality gate impedem regressões de conteúdo.
- Atualizada versão da app para v0.9.1.

# v0.9.0

- Corrigida a filtragem de exercícios por músculo específico: cada foco anatómico mostra apenas os exercícios certos, tendo em conta o local de treino e o equipamento.
- Corrigida a disponibilidade por local: corda de saltar e cabo de vassoura no ginásio, corrida em subida exige exterior, Karate sem tatami e drills de solo de Jiu-Jitsu com tatami ou tapete.
- Revistos um a um os textos dos exercícios: cerca de 75 exercícios receberam passos de execução específicos escritos de raiz para principiantes.
- Corrigidos exercícios com instruções da família errada (Curl de perna, Extensão de perna, Leg press).
- Removidas frases genéricas das instruções e reforçados os testes de qualidade do catálogo.
- Atualizada versão da app para v0.9.0.

# v0.8.0

- Corrigido isolamento de objetivos e milestones por perfil.
- Corrigido isolamento de equipamentos e locais por perfil.
- Corrigidos filtros anatómicos dos exercícios.
- Revistas descrições e execuções individuais dos exercícios.
- Expandido catálogo de exercícios por músculo, equipamento e local.
- Corrigido encoding corrompido.
- Corrigida associação de templates a exercícios.
- Melhoradas validações e testes.
- Atualizada versão da app para v0.8.0.

## Build técnico

A versão pública, o nome da release e o `build-name` são sempre `0.8.0`.
Android/iOS podem exigir um `build-number` inteiro e crescente; nesse caso ele
é fornecido ao comando de build sem acrescentar `+25` ou outro sufixo à versão
pública.
