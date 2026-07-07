# Como adicionar um exercicio novo

1. Escolhe um `canonical_id` unico para o exercicio real.
2. Cria uma entrada de catalogo por contexto com `catalog_entry_key` proprio.
3. Mantem aliases antigos para preservar historico.
4. Define `primary_type`, `secondary_types`, equipamento, locais e filtros.
5. Escreve conteudo para iniciantes absolutos: posicao inicial, movimento, ritmo, respiracao, sensacoes corretas, erros, correcoes, regressao, progressao e quando evitar.
6. Corre `.\tool\run_quality_gate.ps1`.

## Exemplo: Adductor squeeze leve

- Nome: Adductor squeeze leve
- `canonical_id`: `adductor_squeeze_leve`
- Musculos: adutores, core leve e estabilizadores da anca
- Equipamento: bola, almofada ou toalha
- Execucao: deitar de barriga para cima, joelhos dobrados, objeto entre os joelhos, apertar suavemente 2 a 5 segundos, sentir parte interna das coxas, relaxar devagar.
- Evitar: dor aguda na virilha, lesao recente sem autorizacao clinica, dor no joelho com compressao ou desconforto lombar que aumenta.

Nao usar texto generico, tokens internos nem promessas clinicas.

