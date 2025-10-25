// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:flutter/material.dart';

class AnimatedCard extends StatelessWidget {
  const AnimatedCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
  });
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => Container(
    margin: margin,
    child: Material(
      color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      elevation: elevation ?? 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    ),
  );
}
