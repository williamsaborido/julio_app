# Plano de Refatoração do Componente AppInput

Este plano descreve a estratégia para decompor o componente genérico `AppInput` em componentes especializados e integrar o uso de extensões para manipulação de dados, visando consistência e facilidade de manutenção.

## Objetivo
- Substituir o componente `AppInput` por componentes focados: `AppTextInput`, `AppDateInput`, `AppCurrencyInput` e `AppTimeInput`.
- Utilizar e expandir as extensões em `lib/core/extensions.dart` para todas as conversões de/para string.
- Reduzir a complexidade condicional e centralizar a lógica de formatação.

## Estratégia de Implementação

### 1. Expansão das Extensões (`3.41.7/lib/core/extensions.dart`)
Antes de criar os componentes, as extensões devem ser preparadas para suportar as novas necessidades:
- **Casing**: Adicionar `String.toTitleCase()` e `String.applyCasing(AppInputCasing)`.
- **Horário**: Adicionar `TimeOfDay.toBrString()` (HH:mm) e `String.toTime()`.
- **Limpeza**: Garantir que as extensões de moeda e data sejam robustas o suficiente para o uso nos formatters.

### 2. Criação dos Componentes Especializados
Cada componente utilizará as extensões do `core` para exibir e processar dados:

- **AppTextInput**:
  - Utiliza `String.applyCasing` para transformações em tempo real.
- **AppDateInput**:
  - Utiliza `DateTime.toBrString()` para exibição.
  - Utiliza `String.toDate()` para validação/conversão.
  - Abre o `showDatePicker` e atualiza o controller via extensão.
- **AppCurrencyInput**:
  - Utiliza `double.toBrCurrency()` para formatação.
  - Utiliza `String.toCurrency()` para extração de valores numéricos.
- **AppTimeInput**:
  - Utiliza `TimeOfDay.toBrString()` e `String.toTime()`.
  - Integra com `showTimePicker`.

### 3. Migração na View (`3.41.7/lib/view/lancamento/crud/lancamento_crud.dart`)
Substituir as instâncias de `AppInput` pelos novos componentes:
- Campo de **Data** -> `AppDateInput`
- Campo de **Placa** -> `AppTextInput`
- Campo de **Valor** -> `AppCurrencyInput`
- Campos de **Hora Extra** -> `AppTimeInput`

### 4. Limpeza
- Excluir `3.41.7/lib/components/app_input/`.
- Remover o enum `AppInputType` em `3.41.7/lib/enums/app_input_type.dart`.

## Status
- [x] Expandir `extensions.dart` com Casing e TimeOfDay.
- [x] Criar `AppTextInput`.
- [x] Criar `AppDateInput`.
- [x] Criar `AppCurrencyInput`.
- [x] Criar `AppTimeInput`.
- [x] Atualizar `LancamentoCrud` com os novos componentes.
- [x] Validar persistência de valores monetários e horários.
- [x] Excluir o componente `AppInput` original e o enum `AppInputType`.
