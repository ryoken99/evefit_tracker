EVEFIT SETE CONTEXTOS E REGISTO CANÓNICO DE INTENÇÕES v0.1
PUBLICAÇÃO FINAL AUTORIZADA COMO EVEFIT v1.1.4

Entregar este bundle integralmente ao Codex.

O ficheiro de ordem vinculativo é:
EveFit_Seven_Contexts_Training_Intentions_v0.1_Codex_Order_RELEASE_v1.1.4.md

As fontes canónicas obrigatórias são:
EveFit_Training_Intentions_Production_Registry_v0.4.md
EveFit_Training_Intentions_Production_Registry_v0.4.1.md

O Codex deve verificar o ficheiro SHA256SUMS antes de executar.
A v0.4.1 prevalece nas correções localizadas.
A v0.4 deve permanecer byte-for-byte inalterada.
A v0.4.1 deve permanecer byte-for-byte inalterada.

Separação runtime/auditoria:
- o histórico v0.3 é validado integralmente pelo gerador e pelo manifest;
- o histórico completo não é carregado no runtime;
- a projeção runtime não contém IDs v0.3 nem razões de consolidação;
- adaptation_outcome é apresentado como “Resultado de adaptação”.

A ordem foi revista por decisão explícita de Sandro:
- a implementação funcional é feita primeiro e mantém 1.1.3+5;
- depois de todos os gates verdes, o Sol integra o PR funcional;
- o Sol prepara e integra a release 1.1.4+6;
- o Release Gate pós-merge é obrigatório;
- a tag anotada v1.1.4 e a GitHub Release estável/latest são publicadas apenas depois da validação total;
- o APK final chama-se EveFit-v1.1.4-seven-contexts-training-intentions-release.apk;
- apenas o GPT-5.6 Sol pode integrar, criar tag e publicar a release.

Não parar no PR draft quando todos os gates estiverem verdes.
Parar apenas perante uma condição de blocker definida na ordem ou depois de a v1.1.4 estar publicada e verificada.
