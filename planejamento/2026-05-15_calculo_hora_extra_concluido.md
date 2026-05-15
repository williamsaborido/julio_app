# Planejamento: Cálculo Automático de Horas Extras - Concluído

Este documento descreve as alterações necessárias para que o sistema calcule o valor da hora extra automaticamente quando os horários inicial ou final forem alterados, utilizando o valor base configurado no sistema.

## Objetivos
- [x] Injetar o serviço `Configuration` no `LancamentoCrudController`.
- [x] Implementar o cálculo proporcional (1h = 60min) no controller.
- [x] Disparar o cálculo apenas quando os inputs de hora mudarem.
- [x] Garantir que o campo de valor da hora extra permaneça editável.

## 1. Alterações no `LancamentoCrudController`
- [x] Atualizar o construtor para aceitar `Configuration config` como parâmetro obrigatório.
- [x] Adicionar o método `_calculateOvertime()`:
    - Se `horaInicial` ou `horaFinal` forem nulos, não faz nada.
    - Converte ambos para minutos totais desde a meia-noite.
    - Calcula a diferença (`final - inicial`).
    - Calcula o valor: `(minutos / 60) * config.valorHoraExtra`.
    - Atribui o resultado a `valorHoraExtra` e chama `notifyListeners()`.
- [x] Atualizar os setters de `horaInicial` e `horaFinal` para chamar `_calculateOvertime()`.

## 2. Alterações no `LancamentoCrudView`
- [x] No `initState`, passar `context.read<Configuration>()` ao instanciar o controller.

## 3. Alterações no `LancamentoHoraExtraForm`
- [x] Garantir que o `AppCurrencyInput` do valor da hora extra reaja às mudanças de valor vindas do controller (o valor calculado deve ser exibido imediatamente).

## Premissas
- Não há suporte para virada de dia (a hora final sempre será posterior à inicial).
- O cálculo ocorre apenas na mudança das horas; a edição manual do valor resultante é permitida e não dispara novo cálculo.

## Verificação e Testes
- [x] Configurar um valor de hora extra (ex: R$ 60,00).
- [x] No CRUD, definir 08:00 às 09:00 e verificar se o valor calculado é R$ 60,00.
- [x] Definir 08:00 às 08:30 e verificar se o valor calculado é R$ 30,00.
- [x] Alterar o valor manualmente e verificar se ele é mantido até que uma das horas seja alterada novamente.

