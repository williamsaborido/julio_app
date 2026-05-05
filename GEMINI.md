# Julio App

A simple Flutter application designed for accounting and tracking financial gains.

## Project Overview

- **Purpose:** Accounting and tracking financial gains.
- **Main Technologies:**
  - **Flutter SDK:** ^3.11.5
  - **State Management:** `provider` (MultiProvider used in `main.dart`).
  - **Localization:** `intl` (configured for Brazilian Portuguese `pt_BR` in components).
  - **Design System:** Material 3 with adaptive light/dark theme support.
  - **Persistence:** SQLite via `sqflite`.

## Project Structure

The core logic and UI are located in the `3.41.7/lib` directory:

- `components/`: Custom, reusable UI elements (AppInput, AppCard, dialogs).
- `core/`: Fundamental application infrastructure (BaseState, SystemTheme).
- `enums/`: Standardized enumerations (AppInputType, LancamentoCiclo, etc.).
- `models/`: Domain models.
  - `table.dart`: Base class `Table` with an `int id` and a `toMap()` contract.
  - `lancamento.dart`: Data model for financial records, decoupled from database metadata.
- `services/`: Business logic and persistence layers.
  - `database.dart`: SQLite database service. Handles initialization, migrations, and low-level CRUD.
  - `repository.dart`: Abstract base class for repositories. Centralizes `tableName` and `fromMap` factory logic.
  - `lancamento_repository.dart`: Concrete repository for `Lancamento`, defining the table name and mapping logic.
- `view/`: Screen-level widgets and features.

## Architecture: Refined Repository Pattern

The project uses a highly decoupled data access layer:

1.  **Domain Models (`Table`):** Models are pure data structures. They implement `toMap()` for persistence but are unaware of which database table they belong to.
2.  **Repositories:** The repository is the sole authority on database metadata.
    - `tableName`: An abstract getter implemented in concrete repositories.
    - `fromMap()`: An abstract factory method implemented in concrete repositories to reconstruct objects from database rows.
3.  **Database Service:** A singleton utility that provides safe, standardized access to SQLite, including optimized monetary storage (integers as cents).

## Building and Running

Commands should be executed within the `3.41.7` directory.

- **Setup:** `flutter pub get`
- **Execution:** `flutter run`
- **Analysis:** `flutter analyze`

## Development Conventions

- **Monetary Values:** Always store as integers (cents) in the DB. Convert to/from double in the model's mapping logic.
- **Schema Safety:** Use `CHECK` constraints in the database (e.g., limiting string lengths) and validate data at the model level.
- **Code Style:** Follow Dart's `lowerCamelCase` for methods and variables. Use `base`, `final`, or `sealed` modifiers for class hierarchies as per Dart 3 standards.
