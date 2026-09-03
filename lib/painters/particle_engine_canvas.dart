import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/particle_3d.dart';

class ParticleEngineCanvas extends CustomPainter {
  final ParticleEngine engine;
  final Color trailColor;
  final Color particleColor;
  final bool showTrails;

  ParticleEngineCanvas({
    required this.engine,
    this.trailColor = const Color(0xFF00F2FE),
    this.particleColor = const Color(0xFF4FACFE),
    this.showTrails = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF0A0A0E),
    );

    // Draw particles sorted by depth (far to near)
    final sortedParticles = List<Particle3D>.from(engine.particles);
    sortedParticles.sort((a, b) => a.z.compareTo(b.z));

    for (var particle in sortedParticles) {
      const double focalLength = 600.0;
      const double cameraDistance = 800.0;
      final double depthFactor = (cameraDistance + particle.z) / cameraDistance;

      if (depthFactor <= 0.1) continue;

      final double screenX =
          (particle.x * focalLength) / depthFactor + size.width / 2;
      final double screenY =
          (particle.y * focalLength) / depthFactor + size.height / 2;

      // Check bounds
      if (screenX < -100 ||
          screenX > size.width + 100 ||
          screenY < -100 ||
          screenY > size.height + 100) {
        continue;
      }

      // Draw particle trail
      if (showTrails && particle.trailHistory.length > 1) {
        for (int i = 0; i < particle.trailHistory.length - 1; i++) {
          final start = particle.trailHistory[i];
          final end = particle.trailHistory[i + 1];
          final trailOpacity =
              (i / particle.trailHistory.length) * particle.opacity * 0.3;

          canvas.drawLine(
            start,
            end,
            Paint()
              ..color = trailColor.withOpacity(trailOpacity)
              ..strokeWidth = 0.8
              ..strokeCap = StrokeCap.round,
          );
        }
      }

      // Draw particle core with glow
      final radius = particle.baseRadius * math.sqrt(depthFactor);

      // Outer glow
      canvas.drawCircle(
        Offset(screenX, screenY),
        radius * 1.8,
        Paint()
          ..color = particleColor.withOpacity(particle.opacity * 0.15)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );

      // Middle ring
      canvas.drawCircle(
        Offset(screenX, screenY),
        radius,
        Paint()
          ..color = particleColor.withOpacity(particle.opacity * 0.6)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );

      // Core
      canvas.drawCircle(
        Offset(screenX, screenY),
        radius * 0.6,
        Paint()
          ..color = particleColor.withOpacity(particle.opacity * 0.95)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
      );
    }
  }

  @override
  bool shouldRepaint(ParticleEngineCanvas oldDelegate) {
    return true;
  }
}
