## 0.2.0

- **FIX**: Corrigido um problema crítico na geração de código onde múltiplas classes em um único arquivo causavam a duplicação de `import`s, resultando em arquivos `.easy.dart` inválidos. O gerador agora processa a biblioteca inteira de uma vez, garantindo um cabeçalho de importação único e correto.
- **DOCS**: Melhorias na documentação (`README.md`), incluindo instruções para configurar o `build.yaml` para saídas de build customizadas.

## 0.1.0

- Lançamento inicial: Geração de `fromJson/toJson/validate/*Safe` com validação, fallback e *issue tracking*.
