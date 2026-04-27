import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:julio_app/enums/app_input_casing.dart';
import 'package:julio_app/enums/app_input_type.dart';

class AppInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final AppInputType type;
  final int? maxLength;
  final AppInputCasing? casing;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  const AppInput({
    super.key,
    required this.label,
    required this.icon,
    required this.type,
    this.maxLength,
    this.casing = AppInputCasing.none,
    this.validator,
    this.onChanged,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  final _controller = TextEditingController();
  final _dateFormatter = DateFormat('dd/MM/yyyy');
  final _currencyFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChangedHandler);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChangedHandler);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: widget.validator,
      readOnly: widget.type == AppInputType.date,
      maxLength: widget.type == AppInputType.text ? widget.maxLength : null,
      onTap: widget.type == AppInputType.date ? _handleTap : null,
      keyboardType: _getKeyboardType(widget.type),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        labelText: widget.label,
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        if (widget.type == AppInputType.currency)
          TextInputFormatter.withFunction(_formatCurrency),
        if (widget.type == AppInputType.text && widget.casing != AppInputCasing.none)
          TextInputFormatter.withFunction(_formatCasing),
      ],
    );
  }

  void _onChangedHandler() {
    widget.onChanged?.call(_controller.text);
  }

  void _handleTap() {
    if (widget.type == AppInputType.date) {
      // Implement date picker logic here
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      ).then((pickedDate) {
        if (pickedDate != null) {
          // Handle the selected date
          _controller.text = _dateFormatter.format(pickedDate);
        }
      });
    }
  }

  TextEditingValue _formatCurrency(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    double newVal =
        double.tryParse(newValue.text.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

    return TextEditingValue(text: _currencyFormatter.format(newVal / 100));
  }

  TextEditingValue _formatCasing(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = switch (widget.casing) {
      AppInputCasing.uppercase => newValue.text.toUpperCase(),
      AppInputCasing.lowercase => newValue.text.toLowerCase(),
      AppInputCasing.capitalize => newValue.text
          .split(' ')
          .map((word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : '')
          .join(' '),
      _ => newValue.text,
    };

    return newValue.copyWith(
      text: newText,
      selection: newValue.selection,
    );
  }

  TextInputType _getKeyboardType(AppInputType type) {
    switch (type) {
      case AppInputType.number:
        return TextInputType.number;
      case AppInputType.date:
        return TextInputType.datetime;
      case AppInputType.currency:
        return TextInputType.numberWithOptions(decimal: true);
      case AppInputType.text:
        return TextInputType.text;
    }
  }
}
