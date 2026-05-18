# Planejamento: Conversão de Widget para PDF (WYSIWYG)

Este documento descreve a estratégia para converter o conteúdo visual do widget `ImpressaoView` diretamente em um documento PDF, utilizando `Provider` para injeção de dependências e `RepaintBoundary` para captura visual.

## Objetivos
- Implementar a captura visual de um widget Flutter para formato de imagem.
- Converter a imagem capturada em um documento PDF de alta qualidade.
- Integrar com o `SharingService` para permitir o compartilhamento do PDF resultante.
- Adicionar um Floating Action Button (FAB) para disparar a ação de compartilhamento na `ImpressaoView`.
- Utilizar `Provider` para injetar o `PdfService` e outras dependências no `Scaffold` da `ImpressaoView`.
- Capturar especificamente o conteúdo dentro do primeiro `Padding` (filho do `SingleChildScrollView`).

## 1. Preparação
- [x] Adicionar a dependência `pdf` no `pubspec.yaml`.
- [x] Executar `flutter pub get`.

## 2. Injeção de Dependências e Binds
- [x] Criar/Atualizar `lib/view/relatorio/impressao_view.dart` (ou um arquivo de bind dedicado):
    - Implementar a estrutura de `Provider` em volta do `Scaffold` da `ImpressaoView`.
    - Injetar instâncias de `PdfService` e `SharingService`.
    - Se necessário, criar uma classe `ImpressaoController` para gerenciar o estado da tela e a lógica de compartilhamento.

## 3. Ajustes na Interface (`ImpressaoView`)
- [x] Modificar `lib/view/relatorio/impressao_view.dart`:
    - Adicionar uma `GlobalKey` para identificar o widget alvo.
    - Estruturar o `body` com um `SingleChildScrollView`.
    - Envolver o primeiro widget `Padding` (conteúdo principal) em um `RepaintBoundary` associado à chave.
    - Adicionar um `FloatingActionButton` ao `Scaffold`:
        - Ícone: `Icons.share` ou `Icons.picture_as_pdf`.
        - Ação: Acessar os serviços via `context.read<PdfService>()` (ou via controller) e disparar a captura.

## 4. Implementação do Gerador de PDF (`PdfService`)
- [x] Criar `lib/services/pdf_service.dart`:
    - Implementar um método `captureWidgetToPdf(GlobalKey key)`:
        1. Obter o `RenderRepaintBoundary` a partir da chave.
        2. Converter o boundary em um `ui.Image` (usando `pixelRatio: 3.0`).
        3. Converter o `ui.Image` em bytes (PNG).
        4. Criar um documento `pw.Document` (pacote `pdf`).
        5. Inserir uma página contendo a imagem capturada.
        6. Retornar os bytes do PDF (`doc.save()`).

## 5. Fluxo de Compartilhamento
- [x] No clique do FAB na `ImpressaoView`:
    1. Chamar `PdfService.captureWidgetToPdf(key)`.
    2. Enviar os bytes resultantes para `SharingService.shareBytes(bytes, 'relatorio.pdf')`.

## Considerações Técnicas
- **Injeção de Dependências:** O uso de `Provider` garante que a `ImpressaoView` seja testável e que as dependências sejam facilmente substituíveis por mocks se necessário.
- **Captura de Scroll:** O `RepaintBoundary` capturará apenas o que está atualmente renderizado.
- **Resolução:** `pixelRatio: 3.0` é o padrão recomendado para manter a legibilidade do texto convertido em imagem dentro do PDF.

## Verificação e Testes
- [ ] Verificar se as dependências são injetadas corretamente via `Provider`.
- [ ] Validar a nitidez do texto no PDF gerado.
- [ ] Testar o compartilhamento em dispositivos reais.
