# EveFit v1.1.6 - Landing EFT

## Objetivo

A v1.1.6 introduz a nova identidade visual de arranque da EveFit sem alterar o domínio funcional da aplicação.

## Alterações visíveis

- Landing page EFT em ecrã inteiro.
- Composição tecnológica PCB em azul-escuro, violeta e dourado.
- Lettering EFT metálico integrado na arte.
- Ação acessível `Tocar para continuar`.
- Transição curta para o ecrã `Escolher perfil`.
- Fundo coordenado no seletor de perfis, sem lettering EFT.

## Arte e assets

Os dois assets finais derivam da arte aprovada e mantêm a mesma geometria de circuitos e nodes. O segundo asset reconstrói a zona do lettering sem sombra, marca ou artefacto residual.

| Asset | Dimensões | Bytes | SHA-256 |
|---|---:|---:|---|
| `assets/branding/eft_landing_background.jpg` | 941 x 1672 | 532766 | `E539DA410230A5D2E5BAAE6F6496C8BB6C76E80DFF4E650E1A48CDD77E1A0C70` |
| `assets/branding/eft_profile_background.jpg` | 941 x 1672 | 538480 | `4D222CF0F2B838D9E8D391E39F062199A4DAF33581B30682AFD3BED70DAF5BA3` |

Foi usado JPEG de qualidade elevada porque a composição não necessita de transparência, o formato é suportado nativamente pelo Flutter e apresentou uma redução substancial de tamanho sem compressão visível.

## Comportamento

- A landing aparece em cada arranque real da aplicação.
- Tocar no ecrã avança uma única vez.
- Rebuild, rotação e regresso do background não reiniciam a landing.
- Perfil ativo, PIN e persistência continuam com o comportamento existente.
- A transição respeita `disableAnimations` e `accessibleNavigation`.

## Acessibilidade

- A área de continuação ocupa todo o ecrã seguro.
- A ação expõe nome, função de botão e gesto de toque a tecnologias assistivas.
- O CTA permanece texto Flutter nativo.
- O seletor mantém cartões, estados e ações nativos, com scrim para contraste.

## Compatibilidade

- Versão: `1.1.6+8`.
- Package: `com.sandro.evefittracker`.
- Atualização suportada: `1.1.5+7 → 1.1.6+8`.
- Schema SQLite 22 e migrations inalterados.
- Perfis, PIN, dados, treinos e históricos preservados.

## Limites

- Não foram alterados ontologia, catálogo de exercícios, domínio de treino ou lógica de perfis.
- Não foi adicionado onboarding nem temporizador obrigatório.
- O lettering EFT pertence à arte; o CTA e a semântica permanecem nativos.

## Validação

Os resultados finais de analyze, testes, Android smoke, upgrade, build e inspeção do APK são registados em `EveFit_v1.1.6_Release_Report.md`.
