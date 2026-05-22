import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nav_bar_circles/nav_bar_circles.dart';

void main() {
  const items = [
    PillNavItem(icon: Icons.home, label: 'Home'),
    PillNavItem(icon: Icons.person, label: 'Perfil'),
    PillNavItem(icon: Icons.search, label: 'Buscar'),
  ];

  Widget buildWidget({int index = 0, ValueChanged<int>? onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: PillNavBar(
            items: items,
            currentIndex: index,
            onTap: onTap ?? (_) {},
          ),
        ),
      ),
    );
  }

  testWidgets('renderiza el número correcto de íconos', (tester) async {
    await tester.pumpWidget(buildWidget());
    expect(find.byType(Icon), findsNWidgets(items.length));
  });

  testWidgets('onTap devuelve el índice correcto', (tester) async {
    int tapped = -1;
    await tester.pumpWidget(buildWidget(onTap: (i) => tapped = i));
    await tester.tap(find.byIcon(Icons.person));
    await tester.pump();
    expect(tapped, 1);
  });

  testWidgets('animación completa sin errores', (tester) async {
    await tester.pumpWidget(buildWidget(index: 0));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  test('assert falla con más de 6 ítems', () {
    expect(
      () => PillNavBar(
        items: List.generate(7, (_) => const PillNavItem(icon: Icons.circle)),
        currentIndex: 0,
        onTap: (_) {},
      ),
      throwsAssertionError,
    );
  });

  testWidgets('respeta tema personalizado', (tester) async {
    const customTheme = PillNavBarTheme(
      activeColor: Colors.red,
      inactiveColor: Colors.green,
      itemSize: 50,
      iconSize: 18,
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: PillNavBar(
            items: items,
            currentIndex: 0,
            onTap: (_) {},
            theme: customTheme,
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  test('assert falla con 0 ítems', () {
    expect(
      () => PillNavBar(items: [], currentIndex: 0, onTap: (_) {}),
      throwsAssertionError,
    );
  });

  testWidgets('acepta exactamente 1 ítem', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: PillNavBar(
            items: const [PillNavItem(icon: Icons.home)],
            currentIndex: 0,
            onTap: (_) {},
          ),
        ),
      ),
    ));
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('acepta exactamente 6 ítems', (tester) async {
    final sixItems = List.generate(
      6,
      (i) => PillNavItem(icon: Icons.circle, label: 'Item $i'),
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: PillNavBar(
            items: sixItems,
            currentIndex: 0,
            onTap: (_) {},
          ),
        ),
      ),
    ));
    expect(find.byType(Icon), findsNWidgets(6));
  });


    testWidgets('cambia índice activo correctamente', (tester) async {
    int currentIndex = 0;

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) => MaterialApp(
          home: Scaffold(
            body: Center(
              child: PillNavBar(
                items: items,
                currentIndex: currentIndex,
                onTap: (i) => setState(() => currentIndex = i),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(currentIndex, 2);

    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    expect(currentIndex, 0);
  });

testWidgets('CustomPainter pinta sin errores con 2 ítems', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: PillNavBar(
            items: const [
              PillNavItem(icon: Icons.home),
              PillNavItem(icon: Icons.person),
            ],
            currentIndex: 0,
            onTap: (_) {},
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

}
