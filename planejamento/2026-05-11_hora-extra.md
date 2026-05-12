# Plano de Implementação: Campos de Hora Extra

## Objetivo
Incluir campos opcionais para controle de horas extras no modelo `Lancamento` e persistência no banco de dados SQLite.

## Campos Adicionados
- `valorHoraExtra`: Valor monetário da hora extra. Armazenado como `INTEGER` (centavos) no banco e `double` no sistema.
- `horaInicial`: Horário de início. No modelo é `TimeOfDay`, no banco é `INTEGER` (minutos desde a meia-noite).
- `horaFinal`: Horário de término. No modelo é `TimeOfDay`, no banco é `INTEGER` (minutos desde a meia-noite).

## Arquivos Chave
- `3.41.7/lib/models/lancamento.dart`: Atualização do modelo (importar `package:flutter/material.dart`).
- `3.41.7/lib/services/database.dart`: Migração do banco de dados.

## Passos de Implementação

### 1. Atualização do Modelo `Lancamento`
- Importar `package:flutter/material.dart` para usar `TimeOfDay`.
- Adicionar os campos como opcionais: `final TimeOfDay? horaInicial` e `final TimeOfDay? horaFinal`.
- Atualizar `toMap()`:
  ```dart
  'horaInicial': horaInicial != null ? (horaInicial!.hour * 60 + horaInicial!.minute) : null,
  'horaFinal': horaFinal != null ? (horaFinal!.hour * 60 + horaFinal!.minute) : null,
  ```
- Atualizar `fromMap()`:
  ```dart
  horaInicial: map['horaInicial'] != null ? TimeOfDay(hour: map['horaInicial'] ~/ 60, minute: map['horaInicial'] % 60) : null,
  ```
- Implementar o getter `minutosExtra`:
  ```dart
  int get minutosExtra {
    if (horaInicial == null || horaFinal == null) return 0;
    final inicio = horaInicial!.hour * 60 + horaInicial!.minute;
    final fim = horaFinal!.hour * 60 + horaFinal!.minute;
    return (fim > inicio) ? fim - inicio : 0;
  }
  ```

### 2. Migração do Banco de Dados
- Incrementar a versão do banco para `2` em `database.dart`.
- **Para novos usuários (`_onCreate`):** Atualizar o comando `CREATE TABLE` para incluir as colunas `valorHoraExtra`, `horaInicial` e `horaFinal` desde o início.
- **Para usuários existentes (`_onUpgrade`):** Implementar a lógica no método `_runMigration`:
  ```dart
  case 2:
    await db.execute('ALTER TABLE lancamento ADD COLUMN valorHoraExtra INTEGER');
    await db.execute('ALTER TABLE lancamento ADD COLUMN horaInicial INTEGER');
    await db.execute('ALTER TABLE lancamento ADD COLUMN horaFinal INTEGER');
    break;
  ```

## Verificação e Testes
- Validar se a migração ocorre sem erros ao abrir o banco.
- Testar a inserção de um lançamento com e sem os novos campos.
- Validar se o cálculo de `minutosExtra` está correto para intervalos no mesmo dia.
