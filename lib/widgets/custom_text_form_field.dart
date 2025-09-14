import 'package:flutter/material.dart';

// A custom text form field to reduce boilerplate
class CustomTextFormField extends StatefulWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
    );
  }
}