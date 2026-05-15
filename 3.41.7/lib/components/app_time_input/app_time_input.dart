import 'package:flutter/material.dart';
import 'package:julio_app/core/extensions.dart';

class AppTimeInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final TimeOfDay? initialValue;
  final String? Function(String?)? validator;
  final ValueChanged<TimeOfDay?>? onChanged;

  const AppTimeInput({
    super.key,
    required this.label,
    required this.icon,
    this.controller,
    this.initialValue,
    this.validator,
    this.onChanged,
  });

  @override
  State<AppTimeInput> createState() => _AppTimeInputState();
}

class _AppTimeInputState extends State<AppTimeInput> {
  late final TextEditingController _controller;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialValue;
    _controller = widget.controller ?? TextEditingController(
      text: _selectedTime?.toBrString() ?? '',
    );
  }

  @override
  void dispose() {
    if (widget.controller == null){
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleTap() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _controller.text = pickedTime.toBrString();
      });
      widget.onChanged?.call(pickedTime);
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
