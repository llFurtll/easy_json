## 0.3.0

*   **FEAT**: O gerador agora respeita a configuração `build_extensions` definida no `build.yaml`. Isso permite que os usuários personalizem o diretório de saída dos arquivos gerados (ex: `lib/generated/`), e os `import`s nos arquivos `.easy.dart` serão criados corretamente, apontando para o local configurado.
*   **DOCS**: Adicionada uma seção ao `README.md` explicando como excluir os arquivos gerados da análise estática no `analysis_options.yaml`, melhorando a experiência do desenvolvedor.

## 0.2.0

*   Versão inicial do pacote com as funcionalidades principais de serialização, desserialização segura e validação.