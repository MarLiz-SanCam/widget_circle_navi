import 'package:flutter/material.dart';
import 'package:nav_bar_circles/nav_bar_circles.dart';

/// Interfaz común para cada opción del caso 3.
abstract class NavOption {
  IconData get icon;
  String get description;
  void execute(BuildContext context);
}

/// ─── Opción 1: Abre un AlertDialog ───────────────────────────────────────────
class HomeDialogOption implements NavOption {
  const HomeDialogOption();

  @override
  IconData get icon => Icons.home;

  @override
  String get description => 'Abre un AlertDialog';

  @override
  void execute(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Inicio'),
        content: const Text('Bienvenido a la pantalla de inicio.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

/// ─── Opción 2: Navega a otra pantalla ────────────────────────────────────────
class SearchScreenOption implements NavOption {
  const SearchScreenOption();

  @override
  IconData get icon => Icons.search;

  @override
  String get description => 'Navega a otra pantalla';

  @override
  void execute(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const _SearchScreen()),
    );
  }
}

class _SearchScreen extends StatelessWidget {
  const _SearchScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar')),
      body: const Center(
        child: Text('Pantalla de búsqueda', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

/// ─── Opción 3: Cambia el color del nav ───────────────────────────────────────
class ChangeColorOption implements NavOption {
  final void Function(PillNavBarTheme) onThemeChange;

  const ChangeColorOption({required this.onThemeChange});

  static const _palette = [
    (active: Color(0xFF009688), inactive: Color(0xFF80CBC4)), // teal
    (active: Color(0xFF9C27B0), inactive: Color(0xFFCE93D8)), // purple
    (active: Color(0xFFF44336), inactive: Color(0xFFEF9A9A)), // red
    (active: Color(0xFF3F51B5), inactive: Color(0xFF9FA8DA)), // indigo
  ];
  static int _step = 0;

  @override
  IconData get icon => Icons.palette;

  @override
  String get description => 'Cambia el color del nav';

  @override
  void execute(BuildContext context) {
    _step = (_step + 1) % _palette.length;
    onThemeChange(PillNavBarTheme(
      activeColor: _palette[_step].active,
      inactiveColor: _palette[_step].inactive,
    ));
  }
}

/// ─── Opción 4: Muestra un SnackBar ───────────────────────────────────────────
class ProfileSnackBarOption implements NavOption {
  const ProfileSnackBarOption();

  @override
  IconData get icon => Icons.person;

  @override
  String get description => 'Muestra un SnackBar';

  @override
  void execute(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil del usuario abierto'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
