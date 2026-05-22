<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->
# nav_bar_circles 
floating circle-style navigation bar for flutter

## Usage

```dart
PillNavBar(
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
  items: const [
    PillNavItem(icon: Icons.home,   label: 'Home'),
    PillNavItem(icon: Icons.person, label: 'Perfil'),
  ],
)
```

## Customization

```dart
PillNavBar(
  theme: PillNavBarTheme(
    activeColor:       Colors.purple,
    inactiveColor:     Colors.grey.shade800,
    activeIconColor:   Colors.white,
    inactiveIconColor: Colors.grey,
  ),
  ...
)
```
