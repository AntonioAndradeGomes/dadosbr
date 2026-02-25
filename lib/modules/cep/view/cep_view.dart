import 'package:brasil_fields/brasil_fields.dart';
import 'package:dadosbr/app_module.dart';
import 'package:dadosbr/core/ds/ui/app_exception_widget.dart';
import 'package:dadosbr/core/ds/ui/search_input_widget.dart';
import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/cep/models/cep_model.dart';
import 'package:dadosbr/modules/cep/viewmodels/cep_viewmodel.dart';
import 'package:dadosbr/modules/cep/widgets/cep_card_widget.dart';
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
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _viewmodel.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
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
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    FocusScope.of(context).unfocus();
    _viewmodel.fetchCepInfo(cep);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Buscar CEP')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                ValueListenableBuilder(
                  valueListenable: _viewmodel,
                  builder: (_, value, child) {
                    final isLoading = value is LoadingState;
                    return SearchInputWidget(
                      focusNode: _focusNode,
                      titleButton: 'Buscar',
                      controller: _controller,
                      label: "CEP",
                      hint: "Digite o CEP",
                      onSubmit: _submit,
                      keyboardType: TextInputType.number,
                      isLoading: isLoading,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter(ponto: false),
                      ],
                    );
                  },
                ),

                ValueListenableBuilder(
                  valueListenable: _viewmodel,
                  builder: (_, state, child) {
                    if (state is LoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is SuccessState<CepModel>) {
                      final cep = state.data;
                      return CepCardWidget(cep: cep);
                    }
                    if (state is ErrorState<CepModel>) {
                      final error = state.exception as AppException;
                      return AppExceptionWidget(exception: error);
                    }
                    return child!;
                  },
                  child: const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
