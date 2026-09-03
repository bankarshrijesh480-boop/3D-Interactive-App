import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';

class GlassmorphicInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final VoidCallback? onSuffixTap;

  const GlassmorphicInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onSuffixTap,
  }) : super(key: key);

  @override
  State<GlassmorphicInput> createState() => _GlassmorphicInputState();
}

class _GlassmorphicInputState extends State<GlassmorphicInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(_isFocused ? 0.12 : 0.06),
            Colors.white.withOpacity(_isFocused ? 0.08 : 0.03),
          ],
        ),
        border: Border.all(
          color: _isFocused
              ? const Color(0xFF00F2FE).withOpacity(0.8)
              : Colors.white.withOpacity(0.1),
          width: _isFocused ? 2 : 1.5,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.95),
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: widget.label,
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.4),
                fontSize: 15,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                widget.icon,
                color: _isFocused
                    ? const Color(0xFF00F2FE)
                    : Colors.white.withOpacity(0.4),
              ),
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      onTap: widget.onSuffixTap,
                      child: Icon(
                        widget.obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
