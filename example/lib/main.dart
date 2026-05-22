import 'package:flutter/material.dart';
import 'package:nav_bar_circles/nav_bar_circles.dart';
import 'options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PillNavBar – Test Cases',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PillNavBar – Test Cases')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: [
          // Caso 1 – Mínimo: 1 ítem (límite inferior del assert)
          const _Case(
            label: '1 – Mínimo: 1 ítem',
            items: [PillNavItem(icon: Icons.home, label: 'Inicio')],
          ),

          // Caso 2 – 3 ítems con labels (tooltip visible)
          const _Case(
            label: '2 – 3 ítems',
            items: [
              PillNavItem(icon: Icons.home, label: 'Inicio'),
              PillNavItem(icon: Icons.search, label: 'Buscar'),
              PillNavItem(icon: Icons.person, label: 'Perfil'),
            ],
          ),

          // Caso 3 – 4 ítems sin labels, acción diferente por ítem
          const _Case3(),

          // Caso 4 – 4 ítems con colores personalizados
          const _Case(
            label: '4 – 4 ítems con colores personalizados',
            items: [
              PillNavItem(icon: Icons.home, label: 'Inicio'),
              PillNavItem(icon: Icons.explore, label: 'Explorar'),
              PillNavItem(icon: Icons.notifications, label: 'Alertas'),
              PillNavItem(icon: Icons.person, label: 'Perfil'),
            ],
            theme: PillNavBarTheme(
              activeColor: Colors.orange,
              inactiveColor: Colors.deepOrange,
              activeIconColor: Colors.white,
              inactiveIconColor: Colors.black54,
            ),
          ),

          // Caso 5 – Sin card (bare widget en pantalla)
          const _CaseRaw(
            label: '5 – Sin card: 5 ítems',
            items: [
              PillNavItem(icon: Icons.home, label: 'Inicio'),
              PillNavItem(icon: Icons.explore, label: 'Explorar'),
              PillNavItem(icon: Icons.add_circle_outline, label: 'Crear'),
              PillNavItem(icon: Icons.favorite, label: 'Me gusta'),
              PillNavItem(icon: Icons.notifications, label: 'Alertas'),
            ],
          ),

          // Caso 6 – Tema personalizado: tamaños grandes
          const _Case(
            label: '6 – Tamaños grandes (itemSize 80)',
            items: [
              PillNavItem(icon: Icons.home, label: 'Home'),
              PillNavItem(icon: Icons.search, label: 'Search'),
              PillNavItem(icon: Icons.person, label: 'Profile'),
            ],
            theme: PillNavBarTheme(
              itemSize: 80,
              iconSize: 32,
              connectorWidth: 20,
              connectorHeight: 22,
              activeInnerMargin: 12,
            ),
          ),

          // Caso 7 – Animación rápida (100 ms)
          const _Case(
            label: '7 – Animación rápida (100 ms)',
            items: [
              PillNavItem(icon: Icons.home, label: 'Home'),
              PillNavItem(icon: Icons.search, label: 'Search'),
              PillNavItem(icon: Icons.person, label: 'Profile'),
            ],
            theme: PillNavBarTheme(
              animationDuration: Duration(milliseconds: 100),
            ),
          ),

          // Caso 8 – Animación lenta con curva bounceOut (1000 ms)
          const _Case(
            label: '8 – Animación lenta bounceOut (1000 ms)',
            items: [
              PillNavItem(icon: Icons.home, label: 'Home'),
              PillNavItem(icon: Icons.search, label: 'Search'),
              PillNavItem(icon: Icons.person, label: 'Profile'),
            ],
            theme: PillNavBarTheme(
              animationDuration: Duration(milliseconds: 1000),
              animationCurve: Curves.bounceOut,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Widget auxiliar: muestra un caso de uso
// ─────────────────────────────────────────────
class _Case extends StatefulWidget {
  final String label;
  final List<PillNavItem> items;
  final PillNavBarTheme theme;

  const _Case({
    required this.label,
    required this.items,
    this.theme = const PillNavBarTheme(),
  });

  @override
  State<_Case> createState() => _CaseState();
}

class _CaseState extends State<_Case> {  
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(
              'Ítem activo: $_index  •  toca para cambiar',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Center(
              child: PillNavBar(
                items: widget.items,
                currentIndex: _index,
                onTap: (i) => setState(() => _index = i),
                theme: widget.theme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Caso 3: acción diferente por ítem
// ─────────────────────────────────────────────
class _Case3 extends StatefulWidget {
  const _Case3();

  @override
  State<_Case3> createState() => _Case3State();
}

class _Case3State extends State<_Case3> {
  int _index = 0;
  PillNavBarTheme _theme = const PillNavBarTheme();

  late final List<NavOption> _options;

  @override
  void initState() {
    super.initState();
    _options = [
      const HomeDialogOption(),
      const SearchScreenOption(),
      ChangeColorOption(onThemeChange: (t) => setState(() => _theme = t)),
      const ProfileSnackBarOption(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('3 – 4 ítems sin labels, acción por ítem',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(
              'Acción: ${_options[_index].description}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Center(
              child: PillNavBar(
                items: [for (final o in _options) PillNavItem(icon: o.icon)],
                currentIndex: _index,
                onTap: (i) {
                  setState(() => _index = i);
                  _options[i].execute(context);
                },
                theme: _theme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Widget auxiliar sin Card (bare)
// ─────────────────────────────────────────────
class _CaseRaw extends StatefulWidget {
  final String label;
  final List<PillNavItem> items;

  const _CaseRaw({
    required this.label,
    required this.items,
  });

  @override
  State<_CaseRaw> createState() => _CaseRawState();
}

class _CaseRawState extends State<_CaseRaw> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(
            'Ítem activo: $_index  •  toca para cambiar',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Center(
            child: PillNavBar(
              items: widget.items,
              currentIndex: _index,
              onTap: (i) => setState(() => _index = i),
            ),
          ),
        ],
      ),
    );
  }
}
