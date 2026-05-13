import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:julio_app/core/extensions.dart';
import 'package:julio_app/enums/app_input_casing.dart';

class AppTextInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final int? maxLength;
  final AppInputCasing casing;
  final String? initialValue;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const AppTextInput({
    super.key,
    required this.label,
    required this.icon,
    this.maxLength,
    this.casing = AppInputCasing.none,
    this.initialValue,
    this.validator,
    this.onChanged,
  });

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
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
      validator: widget.validator,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
      inputFormatters: [
        if (widget.casing != AppInputCasing.none)
          TextInputFormatter.withFunction((oldValue, newValue) {
            final text = newValue.text.applyCasing(widget.casing);
            return newValue.copyWith(
              text: text,
              selection: newValue.selection,
            );
          }),
      ],
    );
  }
}
