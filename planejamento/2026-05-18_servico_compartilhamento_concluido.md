# Planejamento: Implementação do Serviço de Compartilhamento

Este documento descreve os passos para criar o serviço `SharingService`, que permitirá o compartilhamento de dados e salvamento de arquivos em disco a partir de arrays de bytes.

## Objetivos
- Criar o serviço `SharingService` em `lib/services/sharing.dart`.
- Permitir o compartilhamento de arquivos com outros aplicativos.
- Permitir o salvamento de arquivos no armazenamento local do dispositivo.
- Fornecer uma interface simples baseada em `Uint8List` e nome do arquivo.

## 1. Preparação
- [x] Adicionar as dependências `share_plus` e `path_provider` no `pubspec.yaml`.
- [x] Executar `flutter pub get`.

## 2. Configuração de Permissões (Android)
Para garantir o funcionamento em versões recentes do Android (Scoped Storage) e o compartilhamento de arquivos:

- [x] Alterar `3.41.7/android/app/src/main/AndroidManifest.xml`:
    - Adicionar permissões de leitura/escrita para compatibilidade com APIs antigas (até SDK 28):
      ```xml
      <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
      <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="28" />
      ```
    - Adicionar `android:requestLegacyExternalStorage="true"` na tag `<application>` para suporte a Android 10 (API 29).
- [x] **Observação sobre Compartilhamento:** O `share_plus` utiliza URIs de conteúdo via `FileProvider` (configurado automaticamente pelo plugin), o que evita a necessidade de permissões de armazenamento amplas para a ação de compartilhar em si nas versões mais novas do Android.
- [x] **Armazenamento Interno vs Externo:** O serviço dará preferência ao `getApplicationDocumentsDirectory()` para arquivos privados e `getExternalStorageDirectory()` para arquivos que o usuário deseje acessar via gerenciador de arquivos (respeitando o Scoped Storage).

## 3. Implementação do Serviço `SharingService`
O serviço será uma classe utilitária para centralizar as operações de IO e compartilhamento.

- [x] Criar `lib/services/sharing.dart`:
    - Definir a classe `SharingService`.
    - Método `shareBytes(Uint8List bytes, String fileName)`:
        - Utilizar `path_provider` para obter o diretório temporário (`getTemporaryDirectory`).
        - Gravar os bytes em um arquivo temporário.
        - Utilizar `share_plus` para compartilhar o arquivo (`Share.shareXFiles`).
    - Método `saveFile(Uint8List bytes, String fileName)`:
        - Utilizar `path_provider` para obter o diretório de documentos ou diretório externo.
        - Gravar os bytes no local especificado.
        - Retornar o caminho do arquivo salvo para confirmação.

## 4. Integração e Uso
- [x] Implementar um exemplo de uso na `RelatorioView` ou `ImpressaoView` para exportação de dados.

## Verificação e Testes
- [x] Testar o compartilhamento em dispositivos reais (Android/iOS).
- [x] Verificar se o arquivo é salvo corretamente e se está acessível (se salvo em diretório externo).
- [x] Validar o tratamento de erros (ex: falta de espaço, permissões negadas).
