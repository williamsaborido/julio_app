# Julio App :)

Uma aplicação Flutter simples e eficiente desenvolvida para a contabilização e rastreio de ganhos financeiros.

## 🚀 Propósito

O **Julio App** foi criado para facilitar o registro de entradas financeiras, permitindo um controle organizado de ganhos. A aplicação é especialmente útil para quem precisa registrar lançamentos com informações de data, valor, ciclo e, opcionalmente, identificação por placa (ideal para profissionais autônomos ou controle de frotas).

## 🛠️ Funcionamento

A aplicação opera de forma intuitiva, permitindo o gerenciamento completo (CRUD) dos lançamentos:

-   **Listagem:** Visualização clara de todos os ganhos registrados, com formatação monetária brasileira (R$).
-   **Criação e Edição:** Adição de novos registros com validação de campos.
-   **Exclusão:** Remoção de registros com confirmação de segurança.
-   **Temas:** Suporte total a temas claro (Light) e escuro (Dark), respeitando a preferência do usuário.
-   **Persistência:** Todos os dados são salvos localmente utilizando o banco de dados SQLite, garantindo que as informações não sejam perdidas ao fechar o app.

## 🏗️ Arquitetura e Tecnologias

O projeto segue padrões de desenvolvimento modernos e uma arquitetura desacoplada:

-   **Flutter SDK:** Framework principal.
-   **Padão Repository:** Isolamento total da lógica de acesso a dados da camada de interface.
-   **SQLite (sqflite):** Persistência local robusta.
-   **Provider:** Gerenciamento de estado de forma reativa e eficiente.
-   **Material 3:** Design system moderno com suporte a cores adaptativas.
-   **Localização:** Configurado para `pt_BR` utilizando o pacote `intl`.

## 📦 Como Executar

Certifique-se de ter o Flutter instalado em sua máquina.

1.  Navegue até a pasta do projeto:
    ```bash
    cd 3.41.7
    ```
2.  Instale as dependências:
    ```bash
    flutter pub get
    ```
3.  Execute o aplicativo:
    ```bash
    flutter run
    ```

---
*Desenvolvido com foco em simplicidade e robustez.*
