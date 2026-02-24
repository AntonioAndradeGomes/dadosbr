import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String titleButton;
  final String? label;
  final String? hint;
  final bool isLoading;
  final VoidCallback onSubmit;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const SearchInputWidget({
    required this.titleButton,
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isLoading = false,
    required this.onSubmit,
    required this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            readOnly: isLoading,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onEditingComplete: onSubmit,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              isDense: true,
              labelText: label,
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : onSubmit,
          child: Text(titleButton, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
