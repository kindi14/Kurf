import 'package:flutter/material.dart';

class KurfInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const KurfInputField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    this.validator,
  });

  @override
  State<KurfInputField> createState() => _KurfInputFieldState();
}

class _KurfInputFieldState extends State<KurfInputField> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      style: const TextStyle(color: Colors.white),
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: Colors.white70),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() => _obscure = !_obscure);
                },
              )
            : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
