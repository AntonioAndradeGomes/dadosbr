import 'package:brasil_fields/brasil_fields.dart';
import 'package:dadosbr/app_module.dart';
import 'package:dadosbr/core/ds/ui/app_exception_widget.dart';
import 'package:dadosbr/core/ds/ui/search_input_widget.dart';
import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_model.dart';
import 'package:dadosbr/modules/cpnj/viewmodels/cnpj_viewmodel.dart';
import 'package:dadosbr/modules/cpnj/widgets/cnpj_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CnpjView extends StatefulWidget {
  const CnpjView({super.key});

  @override
  State<CnpjView> createState() => _CnpjViewState();
}

class _CnpjViewState extends State<CnpjView> {
  final _controller = TextEditingController();
  final _viewmodel = getIt<CnpjViewmodel>();
  final _focusNode = FocusNode();
  void _submit() {
    final cnpj = _controller.text.replaceAll(RegExp(r'\D'), '');
    String? message;
    if (cnpj.isEmpty) {
      message = 'Digite o CNPJ completo';
    } else if (cnpj.length != 14) {
      message = 'Digite um CNPJ válido com 14 dígitos';
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
    _viewmodel.fetchCnpjInfo(cnpj);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Buscar CNPJ')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ValueListenableBuilder(
                  valueListenable: _viewmodel,
                  builder: (_, value, child) {
                    final isLoading = value is LoadingState;
                    return SearchInputWidget(
                      focusNode: _focusNode,
                      titleButton: 'Buscar',
                      controller: _controller,
                      label: "CNPJ",
                      hint: "Digite o CNPJ",
                      onSubmit: _submit,
                      keyboardType: TextInputType.number,
                      isLoading: isLoading,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CnpjInputFormatter(),
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

                    if (state is SuccessState<CnpjModel>) {
                      final cnpj = state.data;
                      return CnpjCardWidget(cnpj: cnpj);
                    }

                    if (state is ErrorState<CnpjModel>) {
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
