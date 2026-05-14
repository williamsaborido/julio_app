# Plano de Ajuste de Rotas e Dependências (Opção 1: Navigator Aninhado)

Este plano descreve a implementação de um escopo de dependências para o módulo de `Lancamento` utilizando um `Navigator` aninhado dentro do `LancamentoBind`.

## Objetivo
- Centralizar o fornecimento do `LancamentoRepository` para as telas de Home e CRUD.
- Isolar a lógica de navegação da feature `Lancamento` do `main.dart`.
- Garantir que o repositório seja instanciado uma única vez por ciclo de vida da funcionalidade.

## Estratégia de Implementação

### 1. Refatoração do `LancamentoBind` (`3.41.7/lib/view/lancamento/lancamento_bind.dart`)
- Converter para `StatelessWidget`.
- Envolver as rotas internas com `Provider<LancamentoRepository>`.
- Implementar um `Navigator` interno com `onGenerateRoute`.

```dart
class LancamentoBind extends StatelessWidget {
  const LancamentoBind({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => LancamentoRepository(context.read()),
      child: Navigator(
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => const HomeView(),
                settings: settings,
              );
            case '/crud':
              return MaterialPageRoute(
                builder: (_) => const LancamentoCrud(),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
```

### 2. Ajuste no `main.dart` (`3.41.7/lib/main.dart`)
- Reduzir a complexidade do mapa de rotas global.
- Definir a entrada única para o fluxo de lançamentos.

```dart
// No MaterialApp:
initialRoute: '/lancamentos',
routes: {
  '/lancamentos': (_) => const LancamentoBind(),
},
```

### 3. Ajuste nas Telas e Navegação
- As telas `HomeView` e `LancamentoCrud` continuarão usando `context.read<LancamentoRepository>()` normalmente.
- A navegação dentro das telas usará nomes relativos (ex: `navigateTo('/crud')`).

## Considerações de UX
- Como estamos usando um `Navigator` aninhado, será necessário envolver o `Navigator` do `LancamentoBind` em um `PopScope` caso deseje que o botão "voltar" do sistema (Android) navegue entre as telas internas antes de sair do módulo/app.

## Status
- [x] Implementar alteração no `LancamentoBind`.
- [x] Simplificar `main.dart`.
- [x] Validar injeção de dependência no CRUD.
