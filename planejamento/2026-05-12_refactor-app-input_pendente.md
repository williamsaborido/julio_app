# Plano de Refatoração do Componente AppInput

Este plano descreve a estratégia para decompor o componente genérico `AppInput` em componentes especializados, visando simplificar a manutenção e facilitar a inclusão de novos tipos de entrada, como `TimeOfDay`.

## Objetivo
- Substituir o componente `AppInput` por três componentes focados: `AppTextInput`, `AppDateInput` e `AppCurrencyInput`.
- Preparar a base para a implementação futura do `AppTimeInput`.
- Reduzir a complexidade condicional dentro de um único arquivo.

## Estratégia de Implementação

### 1. Criação dos Novos Componentes (Estrutura de Pastas)
Cada novo componente terá sua própria pasta dedicada em `3.41.7/lib/components/`, seguindo o padrão atual do projeto:

- `3.41.7/lib/components/app_text_input/app_text_input.dart`
- `3.41.7/lib/components/app_date_input/app_date_input.dart`
- `3.41.7/lib/components/app_currency_input/app_currency_input.dart`

### 2. Mapeamento de Propriedades e Responsabilidades
Cada arquivo conterá apenas a lógica necessária para sua especialidade:

- **AppTextInput**: Trata strings, `casing` e `maxLength`.
- **AppDateInput**: Trata `DateTime`, formatação BR e integração com `showDatePicker`.
- **AppCurrencyInput**: Trata valores monetários (double/int cents) e máscara de moeda.

### 3. Migração e Substituição na View
A principal alteração ocorrerá em `3.41.7/lib/view/lancamento/crud/lancamento_crud.dart`, onde cada instância de `AppInput` será substituída:

- O campo de **Data** passará a usar `AppDateInput`.
- O campo de **Placa** passará a usar `AppTextInput`.
- O campo de **Valor** passará a usar `AppCurrencyInput`.

### 4. Limpeza e Exclusão Definitiva
Após a migração de todas as referências no projeto:
- Excluir a pasta e o arquivo `3.41.7/lib/components/app_input/app_input.dart`.
- Remover o enum `AppInputType` em `3.41.7/lib/enums/app_input_type.dart`.

### 5. Preparação para TimeOfDay
- Após a refatoração, criar o `AppTimeInput` em `3.41.7/lib/components/app_time_input/app_time_input.dart`, utilizando a lógica de persistência já existente (minutos desde a meia-noite).

## Status
- [ ] Criar `AppTextInput` em sua própria pasta.
- [ ] Criar `AppDateInput` em sua própria pasta.
- [ ] Criar `AppCurrencyInput` em sua própria pasta.
- [ ] Atualizar `LancamentoCrud` com as novas versões especializadas.
- [ ] Validar comportamentos e validações no CRUD.
- [ ] Excluir o componente `AppInput` original e o enum `AppInputType`.
- [ ] (Bônus) Implementar `AppTimeInput`.
