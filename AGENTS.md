# Flutter Application Implementation Prompt

Implement and refactor this Flutter application using a **production-grade, maintainable architecture** based on **DDD + Clean Architecture + SOLID principles**, with strong separation of concerns and an atomic widget/component architecture.

The implementation must prioritize **readability, maintainability, testability, scalability, and consistency**. Avoid over-engineering where it does not provide practical value.

---

## 1. Core Technology Stack

Use the following technologies:

* **Riverpod** — application state management and dependency injection.
* **GoRouter** — navigation, nested navigation, route guards, and deep linking.
* **Drift + SQLite** — local/offline database and persistent user/application state.
* **Dio** — HTTP client for backend APIs, interceptors, error handling, and content downloads.
* **Freezed + json_serializable** — immutable models, unions/sealed states, and JSON serialization.
* **DDD + Clean Architecture + SOLID** — application architecture and separation of concerns.
* **Responsive/adaptive UI** — support phones, tablets, desktop-sized screens, and different orientations.
* **Foldable support** — support different foldable postures and display configurations.

If a specialized Flutter package makes foldable/adaptive behavior significantly easier or more reliable, it is acceptable to use it.

---

# 2. Architecture

Use a **feature-first Clean Architecture**.

Recommended structure:

```text
lib/
├── app/
│   ├── app.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   ├── route_names.dart
│   │   └── route_guards.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   └── app_spacing.dart
│   └── bootstrap/
│       └── app_bootstrap.dart
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── network/
│   │   ├── dio_client.dart
│   │   ├── interceptors/
│   │   └── network_info.dart
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── tables/
│   │   └── daos/
│   ├── responsive/
│   │   ├── breakpoints.dart
│   │   ├── adaptive_layout.dart
│   │   └── foldable/
│   ├── result/
│   ├── utils/
│   └── widgets/
│       ├── buttons/
│       ├── cards/
│       ├── dialogs/
│       ├── loading/
│       ├── error/
│       └── empty/
│
├── features/
│   ├── feature_name/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   ├── value_objects/
│   │   │   └── use_cases/
│   │   │
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── remote/
│   │   │   │   └── local/
│   │   │   ├── dto/
│   │   │   ├── mappers/
│   │   │   └── repositories/
│   │   │
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── widgets/
│   │       ├── providers/
│   │       └── controllers/
│
└── main.dart
```

Adapt the structure when necessary, but preserve the architectural boundaries.

---

# 3. Domain Layer

The domain layer must contain **business logic only**.

It must NOT depend on:

* Flutter UI
* Dio
* Drift
* SQLite
* GoRouter
* Riverpod
* platform-specific APIs

Use:

### Entities

Represent business concepts using domain entities.

```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
  }) = _User;
}
```

Do not expose database tables or API DTOs directly to the presentation layer.

### Repository interfaces

Repositories belong to the domain layer.

```dart
abstract interface class UserRepository {
  Future<Result<User>> getUser(String id);

  Future<Result<void>> saveUser(User user);
}
```

The domain layer defines **what** the application needs, while the data layer determines **how** it is implemented.

### Use cases

Business operations should be represented through use cases when they contain meaningful application/business logic.

```text
GetUser
SaveUser
UpdateUser
DeleteUser
SyncUser
DownloadContent
```

Do not create meaningless use cases purely to increase the number of classes.

---

# 4. Data Layer

The data layer is responsible for external data sources.

Separate:

```text
Remote Data Source
Local Data Source
Repository Implementation
DTO
Mapper
```

Example:

```text
API
 ↓
RemoteDataSource
 ↓
DTO
 ↓
Mapper
 ↓
Domain Entity
 ↓
Repository
 ↓
Use Case
 ↓
Riverpod Controller
 ↓
UI
```

For local data:

```text
UI
 ↓
Controller
 ↓
Use Case
 ↓
Repository
 ↓
LocalDataSource
 ↓
Drift DAO
 ↓
SQLite
```

Never let UI widgets directly access:

* Dio
* Drift database
* DAO
* API DTOs

---

# 5. Dio Networking

Create a centralized Dio client.

Configure:

* Base URL
* Connection timeout
* Receive timeout
* Send timeout
* Request headers
* Authentication
* Logging in development
* Error normalization
* Retry only where appropriate

Use interceptors for cross-cutting concerns such as:

```text
Authentication
Request ID
Logging
Token refresh
Error normalization
```

Do not put business logic inside Dio interceptors.

Create a consistent network error model.

For example:

```text
NetworkException
UnauthorizedException
ForbiddenException
NotFoundException
ValidationException
ServerException
TimeoutException
ConnectionException
```

The UI should not need to understand Dio-specific exceptions.

---

# 6. Drift + SQLite

Use Drift as the persistence layer.

Keep database-specific implementation isolated inside:

```text
core/database/
```

or the relevant feature's:

```text
data/datasources/local/
```

Use:

* Tables
* DAOs
* Queries
* Migrations
* Transactions where required

Do not expose Drift-generated table objects outside the data layer.

Map database records into domain entities.

Support offline-first behavior where appropriate:

```text
UI
 ↓
Repository
 ├── Local datasource
 └── Remote datasource
```

The repository should determine whether data comes from:

* local database
* remote API
* cache
* synchronization

The UI should not make this decision.

---

# 7. Freezed + json_serializable

Use Freezed for:

* immutable DTOs
* immutable state objects
* sealed/unions
* domain models where appropriate

Use `json_serializable` for API serialization.

Example state:

```dart
@freezed
sealed class UserState with _$UserState {
  const factory UserState.initial() = UserInitial;

  const factory UserState.loading() = UserLoading;

  const factory UserState.loaded(User user) = UserLoaded;

  const factory UserState.error(AppException error) = UserError;
}
```

Avoid mutable state.

Run code generation correctly and keep generated files out of manual edits.

---

# 8. Riverpod

Use Riverpod for:

* Dependency injection
* Application state
* Async state
* Repository providers
* Use-case providers
* Controllers/notifiers

Dependency direction should remain:

```text
Presentation
     ↓
Application / Use Case
     ↓
Domain
     ↑
Data implementation
```

Riverpod providers should compose dependencies rather than contain large business logic.

Prefer:

```text
Provider
  → Repository
  → Use Case
  → Controller
```

instead of putting everything inside a single `Notifier`.

Avoid global mutable singletons.

Use Riverpod's lifecycle features appropriately:

* `autoDispose`
* `family`
* scoped providers
* provider overrides for testing

---

# 9. GoRouter

Centralize routing.

Use:

```text
app/router/app_router.dart
app/router/route_names.dart
app/router/route_guards.dart
```

Requirements:

* Type-safe route organization where practical
* Deep linking
* Nested routes
* Authentication redirects
* Route guards
* Correct back navigation
* State restoration where appropriate

Do not navigate directly using hard-coded strings throughout widgets.

Avoid:

```dart
context.go('/some/random/path');
```

Prefer centralized route definitions/helpers.

---

# 10. Responsive UI

The UI must adapt to different screen sizes.

Support at minimum:

```text
Small phone
Large phone
Tablet
Large tablet
Desktop-sized window
Landscape
Portrait
```

Do not design the application around a single fixed screen size.

Use adaptive breakpoints.

Example conceptual layout:

```text
Compact
  → bottom navigation
  → single-column layout

Medium
  → navigation rail
  → wider content

Expanded
  → navigation rail/sidebar
  → multi-column layout
```

Avoid excessive `MediaQuery.of(context).size.width` checks scattered throughout the application.

Create reusable responsive utilities such as:

```dart
Breakpoints
AdaptiveLayout
ResponsiveBuilder
```

Prefer constraints and available layout space over device-specific checks.

---

# 11. Foldable Device Support

The application must support foldable devices.

Handle:

* Folded/closed posture
* Half-open/tabletop posture
* Fully open posture
* Portrait
* Landscape
* Hinge/fold regions
* Display feature changes
* Window resizing

Do NOT assume:

```text
screen width = device type
```

Instead, derive layout from the current available display configuration.

Use Flutter's display-feature/window APIs or a suitable maintained package if it significantly simplifies implementation.

Important:

### Folded/closed mode

Navigation and interactive elements must remain usable.

Do not depend on an invisible/obscured area of the display.

### Half-open/tabletop mode

Allow adaptive layouts such as:

```text
┌──────────────────────┐
│                      │
│      Content         │
│                      │
├──────────────────────┤
│   Controls / Info    │
│                      │
└──────────────────────┘
```

### Fully open

Use the larger available layout:

```text
┌──────────┬──────────────────────┐
│          │                      │
│   Nav    │       Content        │
│          │                      │
└──────────┴──────────────────────┘
```

Always account for the hinge/display feature when positioning interactive content.

---

# 12. Adaptive Navigation

Navigation must adapt to available space.

Example:

```text
Compact:
BottomNavigationBar / NavigationBar

Medium:
NavigationRail

Expanded:
NavigationRail / Sidebar
```

The selected navigation item must remain synchronized with GoRouter.

Do not determine the selected index using fragile string matching scattered throughout the UI.

Create a centralized route → navigation destination mapping.

Navigation must continue working correctly in:

* folded mode
* half-open mode
* open mode
* orientation changes
* window resizing

---

# 13. Atomic Widget Architecture

Build UI using small reusable components.

Prefer:

```text
Page
 ├── Section
 │    ├── Widget
 │    │    ├── Component
 │    │    └── Component
 │    └── Widget
 └── Section
```

Instead of large:

```text
build()
```

methods containing hundreds of lines.

Examples:

```text
UserPage
UserHeader
UserAvatar
UserInformation
UserActions
UserCard
LoadingView
ErrorView
EmptyView
```

Each widget should have a single responsibility.

Avoid premature abstraction.

Create a reusable component when:

* It is reused
* It has independent behavior
* It represents a meaningful UI concept
* It makes the parent widget significantly easier to understand

---

# 14. Separation of Concerns

Strictly separate:

### UI

Responsible for:

* Rendering
* User interaction
* Layout
* Animations
* Visual state

### Presentation/Application

Responsible for:

* UI state
* Calling use cases
* Coordinating user actions

### Domain

Responsible for:

* Business rules
* Entities
* Value objects
* Repository contracts
* Business use cases

### Data

Responsible for:

* API
* Database
* Serialization
* DTOs
* Repository implementations
* Mapping

### Infrastructure/Core

Responsible for:

* Networking
* Database setup
* Logging
* Error handling
* Platform integrations
* Shared utilities

---

# 15. SOLID Principles

Apply SOLID consistently.

### Single Responsibility

A class/widget should have one clear reason to change.

### Open/Closed

Prefer extensible abstractions over modifying unrelated implementations.

### Liskov Substitution

Implement interfaces without violating their expected behavior.

### Interface Segregation

Prefer small focused interfaces.

### Dependency Inversion

High-level business logic must depend on abstractions, not Dio/Drift/etc.

---

# 16. Error Handling

Create a unified application error model.

Example:

```text
AppException
├── NetworkException
├── AuthenticationException
├── AuthorizationException
├── ValidationException
├── DatabaseException
├── CacheException
└── UnknownException
```

Convert low-level errors into application/domain-friendly errors.

The UI should receive a predictable error representation.

Avoid:

```dart
catch (e) {
  print(e);
}
```

throughout the application.

Use structured logging.

---

# 17. Loading / Error / Empty States

Every async screen should explicitly handle:

```text
Initial
Loading
Success
Empty
Error
```

Avoid duplicating these patterns in every screen.

Create reusable components:

```text
AppLoading
AppErrorView
AppEmptyView
AppRetryButton
```

---

# 18. Offline-First Behavior

Where appropriate:

```text
Remote API
    ↓
Repository
    ↓
SQLite
    ↓
UI
```

Prefer cached/local data when it improves the user experience.

Implement synchronization explicitly.

Avoid hidden synchronization logic inside widgets.

For content downloads:

```text
Dio
 ↓
Download manager
 ↓
Local file/database
 ↓
Domain repository
 ↓
UI
```

Support:

* progress
* cancellation
* retry
* failure handling
* existing-file detection

---

# 19. Performance

The implementation must be efficient.

Pay attention to:

* unnecessary widget rebuilds
* provider rebuilds
* expensive database queries
* unnecessary API calls
* large lists
* image loading
* disk I/O
* synchronous work on the UI thread

Use:

```text
const widgets
select()
family()
autoDispose
pagination
lazy loading
cached data
```

where appropriate.

Do not optimize prematurely; optimize measurable bottlenecks.

---

# 20. Testing

Architecture must make testing easy.

Add tests for:

### Domain

* Entities
* Value objects
* Use cases
* Business rules

### Data

* Repository implementations
* Mappers
* API handling
* Database operations

### Presentation

* Controllers/notifiers
* Provider behavior

### Widget

* Responsive layouts
* Loading/error/empty states
* Navigation behavior

### Foldable

Test different:

```text
Compact
Medium
Expanded
Folded
Half-open
Open
Portrait
Landscape
```

Use dependency injection/provider overrides for tests.

---

# 21. Code Quality Rules

Follow these rules strictly:

* No business logic inside widgets.
* No direct Dio usage inside widgets.
* No direct Drift usage inside widgets.
* No API DTOs exposed to UI.
* No database models exposed to UI.
* No hard-coded API URLs.
* No hard-coded magic numbers where constants are appropriate.
* Avoid deeply nested widgets.
* Avoid giant classes.
* Avoid giant files.
* Avoid duplicated logic.
* Avoid unnecessary abstractions.
* Prefer composition over inheritance.
* Prefer immutable data.
* Prefer explicit naming.
* Keep functions small and focused.
* Keep imports organized.
* Use `const` wherever possible.
* Use meaningful names instead of abbreviations.
* Do not suppress analyzer warnings without a valid reason.
* Do not use `dynamic` unless genuinely necessary.
* Avoid `!` null assertions when safer alternatives exist.

---

# 22. UI Design Principles

The UI should feel:

* Clean
* Consistent
* Modern
* Responsive
* Accessible
* Platform-aware
* Easy to navigate

Maintain a centralized design system for:

```text
Colors
Typography
Spacing
Radius
Elevation
Icons
Buttons
Inputs
Cards
Dialogs
Navigation
```

Avoid random styling values throughout widgets.

---

# 23. Implementation Process

Before modifying code:

1. Inspect the existing project structure.
2. Identify the current architecture.
3. Identify existing dependencies.
4. Identify existing features.
5. Identify reusable components.
6. Identify technical debt.
7. Identify navigation structure.
8. Identify current state management.
9. Identify current API/database implementations.
10. Identify existing responsive/foldable behavior.

Then propose the smallest architecture changes necessary.

Do not rewrite the entire project unnecessarily.

---

## Implementation Order

Implement in this order:

```text
1. Core architecture
2. Dependency injection
3. Error/result abstractions
4. Networking
5. Database
6. Domain entities
7. Repository contracts
8. Data sources
9. Repository implementations
10. Use cases
11. Riverpod providers/controllers
12. GoRouter
13. Responsive system
14. Foldable/adaptive system
15. Atomic UI components
16. Feature pages
17. Tests
18. Refactoring
19. Static analysis
20. Final verification
```

---

# 24. Before Finishing

Run and verify:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter test integration_test
```

If the project uses different scripts, use the project's existing commands.

Fix all analyzer errors introduced by the implementation.

Do not leave TODOs for core functionality.

---

# 25. Final Architecture Goal

The final dependency direction should conceptually look like:

```text
                    ┌─────────────────┐
                    │  Presentation   │
                    │ Flutter + UI     │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │   Application   │
                    │ Riverpod /      │
                    │ Controllers     │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │     Domain      │
                    │ Entities        │
                    │ Use Cases       │
                    │ Repository APIs │
                    └────────┬────────┘
                             │
                    ┌────────┴────────┐
                    ▼                 ▼
             ┌─────────────┐   ┌─────────────┐
             │    Data     │   │Infrastructure│
             │ Repository  │   │ Dio / Drift │
             │ DTO / DAO   │   │ SQLite      │
             └─────────────┘   └─────────────┘
```

The important rule is:

> **Business logic must not depend on Flutter, Dio, Drift, SQLite, or other infrastructure details.**

The application should remain easy to modify if the backend, database, navigation implementation, or UI framework details change.

---

# Expected Result

Implement the requested feature/functionality while preserving this architecture.

The final code should be:

**Clean → Readable → Testable → Modular → Responsive → Foldable-ready → Maintainable → Scalable**

Do not sacrifice architecture quality merely to make the implementation shorter.
Do not over-engineer simple features.
Use the simplest design that preserves the architectural boundaries above.
