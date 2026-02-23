import 'package:brasil_fields/brasil_fields.dart';
import 'package:dadosbr/core/ds/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepView extends StatefulWidget {
  const CepView({super.key});

  @override
  State<CepView> createState() => _CepViewState();
}

class _CepViewState extends State<CepView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar CEP')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      labelText: 'CEP',
                      hintText: 'Digite o CEP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final cep = _controller.text.replaceAll(RegExp(r'\D'), '');
                    String? message;
                    if (cep.isEmpty) {
                      message = 'Digite o CEP completo';
                    } else if (cep.length != 8) {
                      message = 'Digite um CEP válido com 8 dígitos';
                    }

                    if (message != null) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: AppColors.statusError,
                        ),
                      );
                    }
                  },
                  child: Text('Buscar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
