# Planejamento: Adição da Tela de Configurações (Interface)

Este planejamento descreve a criação da interface para a tela de configurações, que será acessada através de um novo botão na `LancamentoHomeView`. O modal permitirá configurar o tema do sistema e o valor da hora extra.

## Objetivo
Substituir o atual alternador de brilho por um botão de configurações que abre um modal contendo:
- Seleção de tema (Claro, Escuro, Sistema) via Radio Group.
- Entrada para o valor da hora extra via `AppCurrencyInput`.
- Botão "FECHAR" com estilo idêntico ao de "SALVAR" da tela de CRUD.

## Arquivos e Contextos Chave
- `lib/core/system_theme.dart`: Necessário adicionar método para definir o tema diretamente.
- `lib/view/lancamento/home/lancamento_home_view.dart`: Local de alteração do botão da AppBar.
- `lib/view/config/config_view.dart`: Novo arquivo que conterá o widget do modal.
- `lib/view/lancamento/crud/lancamento_crud_view.dart`: Referência para o estilo do botão de salvar.

## Etapas de Implementação

### 1. Preparação do SystemTheme (`lib/core/system_theme.dart`)
- Adicionar um método `setTheme(ThemeMode mode)` para permitir a seleção direta via radio buttons.

### 2. Criação da View de Configurações (`lib/view/config/config_view.dart`)
- Criar o widget `ConfigView` como um `StatefulWidget`.
- Implementar o layout do modal:
    - Título "Configurações" (pode ser um Text no topo da Column).
    - Seção para "Tema":
        - `RadioListTile<ThemeMode>` para `ThemeMode.light` (Claro).
        - `RadioListTile<ThemeMode>` para `ThemeMode.dark` (Escuro).
        - `RadioListTile<ThemeMode>` para `ThemeMode.system` (Sistema).
    - Seção para "Valor Hora Extra":
        - Utilizar o componente `AppCurrencyInput`.
    - Botão "FECHAR":
        - Seguir o padrão de layout de `LancamentoCrudView` (Row -> Expanded -> ElevatedButton).
        - Texto: "FECHAR".
        - Ação: Atualizar o tema no `SystemTheme` e fechar o modal via `Navigator.pop`.

### 3. Alteração na Home (`lib/view/lancamento/home/lancamento_home_view.dart`)
- Remover o `IconButton` de `_toggleTheme`.
- Adicionar um novo `IconButton` com `Icons.settings`.
- Implementar o método `_openSettings()` que utiliza o `showModal` herdado de `BaseState` para exibir o `ConfigView`.

## Verificação e Testes
- **Interface:** Verificar se o modal abre corretamente com os cantos arredondados.
- **Navegação:** Confirmar se o botão "FECHAR" fecha o modal.
- **Funcionalidade de Tema:** Garantir que a troca de tema no modal reflete no aplicativo.
- **Estilo:** Validar se o botão "FECHAR" está visualmente idêntico ao botão "SALVAR" do CRUD (Row com Expanded ocupando a largura total).
