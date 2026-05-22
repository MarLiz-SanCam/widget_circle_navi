

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nav_bar_circles/src/nav_theme.dart';
import 'package:nav_bar_circles/src/nav_item.dart';

class PillNavBar extends StatelessWidget {
  final List<PillNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final PillNavBarTheme theme;

  const PillNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.theme = const PillNavBarTheme(),
  }) : assert(
          items.length >= 1 && items.length <= 5,
          'PillNavBar: mínimo 1 ítem, máximo 5.',
        );

  @override
  Widget build(BuildContext context) {
    final double step = theme.itemSize + theme.connectorWidth;
    final double totalWidth = theme.itemSize + step * (items.length - 1);
    final double innerSize = theme.itemSize - theme.activeInnerMargin * 2;

    return SizedBox(
      width: totalWidth,
      height: theme.itemSize,
      child: Stack(
        children: [
          // ── Capa 1: fondo unificado (sin costuras) ──
          CustomPaint(
            size: Size(totalWidth, theme.itemSize),
            painter: _NavBackgroundPainter(
              itemCount: items.length,
              itemSize: theme.itemSize,
              connectorWidth: theme.connectorWidth,
              connectorHeight: theme.connectorHeight,
              color: theme.inactiveColor,
            ),
          ),

          // ── Capa 2: círculo interior del ítem activo ──
          AnimatedPositioned(
            duration: theme.animationDuration,
            curve: theme.animationCurve,
            left: currentIndex * step + theme.activeInnerMargin,
            top: theme.activeInnerMargin,
            child: Container(
              width: innerSize,
              height: innerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.activeColor,
              ),
            ),
          ),

          // ── Capa 3: áreas táctiles + iconos ──
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(items.length * 2 - 1, (i) {
              // Posiciones impares → espacio del conector (no interactivo)
              if (i.isOdd) {
                return SizedBox(
                  width: theme.connectorWidth,
                  height: theme.itemSize,
                );
              }
              final index = i ~/ 2;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap(index);
                },
                behavior: HitTestBehavior.opaque,
                child: Tooltip(
                  message: items[index].label ?? '',
                  child: SizedBox(
                    width: theme.itemSize,
                    height: theme.itemSize,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: theme.animationDuration,
                        child: Icon(
                          items[index].icon,
                          key: ValueKey(
                            '${items[index].icon.codePoint}_${index == currentIndex}',
                          ),
                          size: theme.iconSize,
                          color: index == currentIndex
                              ? theme.activeIconColor
                              : theme.inactiveIconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}


class _NavBackgroundPainter extends CustomPainter {
  final int itemCount;
  final double itemSize;
  final double connectorWidth;
  final double connectorHeight;
  final Color color;

  const _NavBackgroundPainter({
    required this.itemCount,
    required this.itemSize,
    required this.connectorWidth,
    required this.connectorHeight,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double r = itemSize / 2;
    final double step = itemSize + connectorWidth;

    // 1) Conectores primero (rectángulos redondeados entre centros de círculos)
    for (int i = 0; i < itemCount - 1; i++) {
      final double cx1 = i * step + r;
      final double cx2 = (i + 1) * step + r;
      final rect = Rect.fromLTRB(
        cx1,
        r - connectorHeight / 2,
        cx2,
        r + connectorHeight / 2,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(connectorHeight / 2)),
        paint,
      );
    }

    // 2) Círculos encima (tapan los extremos del conector → unión perfecta)
    for (int i = 0; i < itemCount; i++) {
      canvas.drawCircle(Offset(i * step + r, r), r, paint);
    }
  }

  @override
  bool shouldRepaint(_NavBackgroundPainter old) =>
      old.itemCount != itemCount ||
      old.color != color ||
      old.connectorHeight != connectorHeight ||
      old.connectorWidth != connectorWidth ||
      old.itemSize != itemSize;
}
