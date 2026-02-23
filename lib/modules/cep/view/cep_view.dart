import 'package:brasil_fields/brasil_fields.dart';
import 'package:dadosbr/app_module.dart';
import 'package:dadosbr/core/ds/theme/app_colors.dart';
import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/cep/models/cep_model.dart';
import 'package:dadosbr/modules/cep/viewmodels/cep_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepView extends StatefulWidget {
  const CepView({super.key});

  @override
  State<CepView> createState() => _CepViewState();
}

class _CepViewState extends State<CepView> {
  final _controller = TextEditingController();
  final _viewmodel = getIt<CepViewmodel>();

  @override
  void dispose() {
    _controller.dispose();
    _viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar CEP')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            ValueListenableBuilder(
              valueListenable: _viewmodel,
              builder: (_, value, child) {
                final isLoading = value is LoadingState;
                return Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        readOnly: isLoading,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(ponto: false),
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
                      onPressed: isLoading
                          ? null
                          : () {
                              final cep = _controller.text.replaceAll(
                                RegExp(r'\D'),
                                '',
                              );
                              String? message;
                              if (cep.isEmpty) {
                                message = 'Digite o CEP completo';
                              } else if (cep.length != 8) {
                                message = 'Digite um CEP válido com 8 dígitos';
                              }

                              if (message != null) {
                                ScaffoldMessenger.of(
                                  context,
                                ).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor: AppColors.statusError,
                                  ),
                                );
                                return;
                              }
                              _viewmodel.fetchCepInfo(cep);
                            },
                      child: Text('Buscar'),
                    ),
                  ],
                );
              },
            ),

            ValueListenableBuilder(
              valueListenable: _viewmodel,
              builder: (_, state, child) {
                if (state is LoadingState) {
                  return CircularProgressIndicator();
                }
                if (state is SuccessState<CepModel>) {
                  final cep = state.data;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        spacing: 8,
                        children: [
                          SizedBox(
                            height: 80,
                            child: AspectRatio(
                              aspectRatio: 10 / 7,
                              child: Image.network(
                                'https://atlasescolar.ibge.gov.br/images/bandeiras/ufs/${cep.state.toLowerCase()}.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  'CEP: ${UtilBrasilFields.obterCep(cep.cep, ponto: false)}',
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  '${cep.city} - ${cep.state}',
                                  textAlign: TextAlign.start,
                                ),
                                if (cep.address != null)
                                  Text(
                                    '${cep.address}',
                                    textAlign: TextAlign.start,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is ErrorState<CepModel>) {
                  final error = state.exception as AppException;
                  return Text(
                    error.message,
                    style: TextStyle(color: AppColors.statusError),
                  );
                }
                return child!;
              },
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
