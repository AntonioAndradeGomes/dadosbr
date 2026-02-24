import 'package:brasil_fields/brasil_fields.dart';
import 'package:dadosbr/core/ds/ui/search_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CnpjView extends StatefulWidget {
  const CnpjView({super.key});

  @override
  State<CnpjView> createState() => _CnpjViewState();
}

class _CnpjViewState extends State<CnpjView> {
  final _controller = TextEditingController();

  void _submit() {}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Buscar CNPJ')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchInputWidget(
                titleButton: 'Buscar',
                controller: _controller,
                label: "CNPJ",
                hint: "Digite o CNPJ",
                onSubmit: _submit,
                keyboardType: TextInputType.number,

                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
