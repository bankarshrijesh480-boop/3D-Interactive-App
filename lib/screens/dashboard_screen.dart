import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import '../models/particle_3d.dart';
import '../painters/particle_engine_canvas.dart';

class DashboardScreen extends StatefulWidget {
  final User user;

  const DashboardScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late ParticleEngine particleEngine;
  late Offset mousePosition;
  late AnimationController _fpsController;
  late AnimationController _updateController;
  int _frameCount = 0;
  int _fps = 0;
  double _attractionForce = 0.85;
  double _massScale = 1.0;
  Offset _pointerCoordinates = Offset.zero;
  DateTime _startTime = DateTime.now();
  int _particleIntensity = 50;
  String _colorMode = 'Neon Cyberpunk';

  @override
  void initState() {
    super.initState();
    particleEngine = ParticleEngine(
      particleCount: 250,
      width: 800,
      height: 600,
    );
    mousePosition = Offset.zero;

    _fpsController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _updateController = AnimationController(
      duration: const Duration(milliseconds: 16),
      vsync: this,
    )..repeat();

    _fpsController.addListener(_updateFPS);
    _updateController.addListener(_updateParticles);
  }

  void _updateFPS() {
    _frameCount++;
    if (_frameCount % 60 == 0) {
      setState(() {
        _fps = _frameCount ~/ 1;
        _frameCount = 0;
      });
    }
  }

  void _updateParticles() {
    setState(() {
      particleEngine.update(mousePosition, Size(800, 600));
      _pointerCoordinates = mousePosition;
      _particleIntensity = (particleEngine.particles
              .where((p) =>
                  (p.x.abs() < 200 && p.y.abs() < 200) ||
                  (p.vx.abs() > 1 || p.vy.abs() > 1))
              .length ~/
          2);
    });
  }

  @override
  void dispose() {
    _fpsController.dispose();
    _updateController.dispose();
    super.dispose();
  }

  String _getUptime() {
    final elapsed = DateTime.now().difference(_startTime);
    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes % 60;
    final seconds = elapsed.inSeconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0E),
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            mousePosition = event.localPosition;
          });
        },
        child: Stack(
          children: [
            // Particle Engine Background
            CustomPaint(
              painter: ParticleEngineCanvas(
                engine: particleEngine,
                trailColor: _colorMode == 'Arctic Aurora'
                    ? const Color(0xFF00D4FF)
                    : const Color(0xFF00F2FE),
                particleColor: _colorMode == 'Arctic Aurora'
                    ? const Color(0xFF0099CC)
                    : const Color(0xFF4FACFE),
              ),
              size: Size.infinite,
            ),
            // Glassmorphic Overlay Content
            SafeArea(
              child: Stack(
                children: [
                  // Top Navigation Bar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: _buildTopNavBar(),
                  ),
                  // Main Metrics Grid
                  Positioned(
                    top: 100,
                    left: 20,
                    right: 20,
                    child: _buildMetricsGrid(),
                  ),
                  // Control Panel
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: _buildControlPanel(),
                  ),
                  // Logout Button
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: _buildLogoutButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.white.withOpacity(0.04),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    widget.user.email ?? 'User',
                    style: GoogleFonts.orbitron(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF00F2FE),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'UPTIME',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.5),
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    _getUptime(),
                    style: GoogleFonts.orbitron(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4FACFE),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'FPS',
                  value: _fps.toString(),
                  icon: Icons.speed,
                  accentColor: const Color(0xFF00F2FE),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  title: 'POINTER X',
                  value: _pointerCoordinates.dx.toStringAsFixed(0),
                  icon: Icons.touch_app,
                  accentColor: const Color(0xFF4FACFE),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'POINTER Y',
                  value: _pointerCoordinates.dy.toStringAsFixed(0),
                  icon: Icons.touch_app,
                  accentColor: const Color(0xFFFF00FF),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  title: 'INTENSITY',
                  value: _particleIntensity.toString(),
                  icon: Icons.radar,
                  accentColor: const Color(0xFFFFD700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color accentColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.white.withOpacity(0.04),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.1),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.6),
                      letterSpacing: 1,
                    ),
                  ),
                  Icon(icon, color: accentColor, size: 16),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.white.withOpacity(0.04),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PARTICLE CONTROLS',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.6),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              _buildSlider(
                label: 'Attraction Force',
                value: _attractionForce,
                min: 0.1,
                max: 2.0,
                onChanged: (val) {
                  setState(() {
                    _attractionForce = val;
                    particleEngine.updateAttractionForce(val);
                  });
                },
              ),
              const SizedBox(height: 12),
              _buildSlider(
                label: 'Particle Mass Scale',
                value: _massScale,
                min: 0.1,
                max: 3.0,
                onChanged: (val) {
                  setState(() {
                    _massScale = val;
                    particleEngine.updateParticleMassScale(val);
                  });
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Color Mode',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  DropdownButton<String>(
                    value: _colorMode,
                    dropdownColor: const Color(0xFF1A1A2E),
                    underline: Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'Neon Cyberpunk',
                        child: Text(
                          'Neon Cyberpunk',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF4FACFE),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Arctic Aurora',
                        child: Text(
                          'Arctic Aurora',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF4FACFE),
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _colorMode = value ?? 'Neon Cyberpunk');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            Text(
              value.toStringAsFixed(2),
              style: GoogleFonts.orbitron(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00F2FE),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 6,
              elevation: 4,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 12,
            ),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: const Color(0xFF00F2FE),
            inactiveColor: Colors.white.withOpacity(0.1),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF0055).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFF0055).withOpacity(0.8),
                      const Color(0xFFFF0055).withOpacity(0.6),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Logout',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
