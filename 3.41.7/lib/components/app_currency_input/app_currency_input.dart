import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:julio_app/core/extensions.dart';

class AppCurrencyInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final double? initialValue;
  final String? Function(String?)? validator;
  final ValueChanged<double>? onChanged;

  const AppCurrencyInput({
    super.key,
    required this.label,
    required this.icon,
    this.controller,
    this.initialValue,
    this.validator,
    this.onChanged,
  });

  @override
  State<AppCurrencyInput> createState() => _AppCurrencyInputState();
}

class _AppCurrencyInputState extends State<AppCurrencyInput> {
  late final TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue?.toBrCurrency() ?? '');
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: widget.validator,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          final numericString = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
          final value = (double.tryParse(numericString) ?? 0) / 100;
          final formatted = value.toBrCurrency();

          widget.onChanged?.call(value);

          return TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }),
      ],
    );
  }
}
