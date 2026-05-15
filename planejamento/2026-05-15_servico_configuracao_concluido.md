# Planejamento: Implementação do Serviço Configuration

Este documento descreve os passos para criar o serviço `Configuration`, que centralizará a gestão de preferências do usuário (tema e valor de hora extra) com persistência local.

## Objetivos
- Criar o serviço `Configuration` em `lib/services/configuration.dart`.
- Implementar persistência usando `shared_preferences` com formato JSON.
- Substituir e remover a classe `SystemTheme`.
- Integrar o serviço na `ConfigView` e no `main.dart`.

## 1. Preparação
- [x] Adicionar a dependência `shared_preferences` no `pubspec.yaml`.
- [x] Executar `flutter pub get`.

## 2. Implementação do Serviço `Configuration`
O serviço será um `ChangeNotifier` para manter a compatibilidade com a reatividade atual.

- [x] Criar `lib/services/configuration.dart`:
    - Definir a classe `Configuration extends ChangeNotifier`.
    - Atributos privados: `_themeMode` (ThemeMode) e `_valorHoraExtra` (int - centavos).
    - Getters: `theme` (ThemeMode) e `valorHoraExtra` (double - convertido).
    - Métodos:
        - `init()`: Carrega os dados do `SharedPreferences`, faz o parse do JSON e atualiza os estados internos.
        - `setTheme(ThemeMode)`: Altera o tema, salva e notifica ouvintes.
        - `toggleTheme()`: Alterna entre os temas, salva e notifica.
        - `setValorHoraExtra(double)`: Converte para centavos, altera, salva e notifica.
        - `_save()`: Serializa os dados para JSON e grava no storage.

## 3. Integração no `main.dart`
- [x] Tornar a função `main()` assíncrona.
- [x] Inicializar o serviço `Configuration` antes de `runApp`.
- [x] No `MultiProvider`:
    - Remover `ChangeNotifierProvider<SystemTheme>`.
    - Adicionar `ChangeNotifierProvider<Configuration>.value` (usando a instância já inicializada).
- [x] No `MaterialApp`:
    - Atualizar o `themeMode` para ler de `context.watch<Configuration>().theme`.

## 4. Atualização da Interface (`ConfigView`)
- [x] Em `lib/view/config/config_view.dart`:
    - Substituir `SystemTheme` por `Configuration`.
    - No `initState`, carregar o valor inicial da hora extra vindo do serviço.
    - **Otimização de Persistência:** Utilizar uma variável local `_valorHoraExtra` para armazenar o valor enquanto o usuário digita.
    - No `onChanged` do `AppCurrencyInput`, atualizar apenas a variável local.
    - **Salvamento no Fechamento:** No método `_onClose`, chamar `_configuration.setValorHoraExtra(_valorHoraExtra)` antes de fechar o modal, evitando múltiplas escritas no storage durante a digitação.
    - **Controle de Navegação:** Impedir o fechamento do modal por gestos (ex: arrastar para baixo) para garantir que o salvamento ocorra através do botão "FECHAR".
    - Garantir que a lista de rádios de tema aponte para o novo serviço.

## 5. Limpeza e Refatoração
- [x] Em `lib/view/lancamento/home/lancamento_home_view.dart`:
    - Remover a referência ao `SystemTheme` (que não estava sendo usada de fato no build, apenas instanciada).
- [x] Remover o arquivo `lib/core/system_theme.dart`.
- [x] Executar `flutter analyze` para garantir que não restaram referências órfãs.

## Verificação e Testes
- [x] Verificar se a alteração de tema persiste após reiniciar o app.
- [x] Verificar se o valor da hora extra persiste após reiniciar o app.
- [x] Validar se o valor da hora extra no storage está em formato inteiro (centavos) dentro do JSON.
- [x] Confirmar se o `toggleTheme` (se usado futuramente) funciona conforme esperado.
