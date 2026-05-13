import 'package:flutter/material.dart';
import 'package:julio_app/core/extensions.dart';

class AppDateInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final DateTime? initialValue;
  final String? Function(String?)? validator;
  final ValueChanged<DateTime?>? onChanged;

  const AppDateInput({
    super.key,
    required this.label,
    required this.icon,
    this.initialValue,
    this.validator,
    this.onChanged,
  });

  @override
  State<AppDateInput> createState() => _AppDateInputState();
}

class _AppDateInputState extends State<AppDateInput> {
  late final TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
    _controller = TextEditingController(
      text: _selectedDate?.toBrString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text = pickedDate.toBrString();
      });
      widget.onChanged?.call(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: widget.validator,
      readOnly: true,
      onTap: _handleTap,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
