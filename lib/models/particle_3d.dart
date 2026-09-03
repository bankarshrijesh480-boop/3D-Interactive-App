import 'dart:math' as math;
import 'package:flutter/material.dart';

class Particle3D {
  double x, y, z;
  double vx, vy, vz;
  double mass;
  double baseRadius;
  double opacity;
  List<Offset> trailHistory = [];
  final int maxTrailLength = 12;

  Particle3D({
    required this.x,
    required this.y,
    required this.z,
    this.vx = 0,
    this.vy = 0,
    this.vz = 0,
    this.mass = 1.0,
    this.baseRadius = 2.0,
    this.opacity = 0.8,
  });

  void addToTrail(Offset position) {
    trailHistory.add(position);
    if (trailHistory.length > maxTrailLength) {
      trailHistory.removeAt(0);
    }
  }

  void clearTrail() {
    trailHistory.clear();
  }
}

class ParticleEngine {
  final int particleCount;
  final double width;
  final double height;
  late List<Particle3D> particles;
  double attractionForce = 0.85;
  double dampingFactor = 0.95;
  double particleMassScale = 1.0;
  late Offset pointerPosition;
  late Size canvasSize;

  ParticleEngine({
    required this.particleCount,
    required this.width,
    required this.height,
  }) {
    _initializeParticles();
    pointerPosition = Offset(width / 2, height / 2);
    canvasSize = Size(width, height);
  }

  void _initializeParticles() {
    particles = [];
    final random = math.Random();

    for (int i = 0; i < particleCount; i++) {
      final x = (random.nextDouble() - 0.5) * width;
      final y = (random.nextDouble() - 0.5) * height;
      final z = (random.nextDouble() - 0.5) * 1000;

      particles.add(
        Particle3D(
          x: x,
          y: y,
          z: z,
          vx: (random.nextDouble() - 0.5) * 2,
          vy: (random.nextDouble() - 0.5) * 2,
          vz: (random.nextDouble() - 0.5) * 2,
          mass: random.nextDouble() * 0.5 + 0.5,
          baseRadius: random.nextDouble() * 2.5 + 1.5,
          opacity: random.nextDouble() * 0.4 + 0.4,
        ),
      );
    }
  }

  void update(Offset mousePos, Size size) {
    pointerPosition = mousePos;
    canvasSize = size;

    for (var particle in particles) {
      // Calculate screen projection
      const double focalLength = 600.0;
      const double cameraDistance = 800.0;
      final double depthFactor = (cameraDistance + particle.z) / cameraDistance;

      if (depthFactor <= 0.1) continue;

      final double screenX =
          (particle.x * focalLength) / depthFactor + size.width / 2;
      final double screenY =
          (particle.y * focalLength) / depthFactor + size.height / 2;

      // Calculate distance to pointer
      final double dx = screenX - pointerPosition.dx;
      final double dy = screenY - pointerPosition.dy;
      final double distance = math.sqrt(dx * dx + dy * dy);

      // Apply attraction force
      const double smoothingDampener = 50.0;
      const double gravitationalConstant = 100000.0;
      final double force =
          (gravitationalConstant * particle.mass * particleMassScale) /
              (distance * distance + smoothingDampener);

      // Calculate normalized direction
      double forceX = 0, forceY = 0;
      if (distance > 1) {
        forceX = (dx / distance) * force * attractionForce * -1;
        forceY = (dy / distance) * force * attractionForce * -1;
      }

      // Update velocity with damping
      particle.vx = (particle.vx + forceX) * dampingFactor;
      particle.vy = (particle.vy + forceY) * dampingFactor;
      particle.vz = particle.vz * dampingFactor;

      // Update position
      particle.x += particle.vx;
      particle.y += particle.vy;
      particle.z += particle.vz;

      // Add to trail
      particle.addToTrail(Offset(screenX, screenY));

      // Boundary wrapping with smooth transition
      const double boundary = 400.0;
      if (particle.x.abs() > boundary) {
        particle.x = -particle.x.sign * boundary;
        particle.vx *= -0.5;
      }
      if (particle.y.abs() > boundary) {
        particle.y = -particle.y.sign * boundary;
        particle.vy *= -0.5;
      }
      if (particle.z.abs() > 500) {
        particle.z = -particle.z.sign * 500;
        particle.vz *= -0.5;
      }
    }
  }

  void updateAttractionForce(double value) {
    attractionForce = value;
  }

  void updateParticleMassScale(double value) {
    particleMassScale = value;
  }
}
