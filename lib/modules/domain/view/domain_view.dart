import 'package:dadosbr/app_module.dart';
import 'package:dadosbr/core/ds/ui/app_exception_widget.dart';
import 'package:dadosbr/core/ds/ui/search_input_widget.dart';
import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/domain/models/domain_model.dart';
import 'package:dadosbr/modules/domain/viewmodel/domain_viewmodel.dart';
import 'package:dadosbr/modules/domain/widgets/domain_card_widget.dart';
import 'package:flutter/material.dart';

class DomainView extends StatefulWidget {
  const DomainView({super.key});

  @override
  State<DomainView> createState() => _DomainViewState();
}

class _DomainViewState extends State<DomainView> {
  final _controller = TextEditingController();
  final _viewmodel = getIt<DomainViewmodel>();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _viewmodel.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final dominio = _controller.text.trim();
    if (dominio.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Digite o Domínio completo'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    FocusScope.of(context).unfocus();
    _viewmodel.fetchDomainInfo(dominio);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Buscar Domínio')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                ValueListenableBuilder(
                  valueListenable: _viewmodel,
                  builder: (context, value, child) {
                    final isLoading = value is LoadingState;
                    return SearchInputWidget(
                      focusNode: _focusNode,
                      titleButton: 'Buscar',
                      controller: _controller,
                      label: "Domínio",
                      hint: "Digite o Domínio",
                      onSubmit: _submit,
                      keyboardType: TextInputType.text,
                      isLoading: isLoading,
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _viewmodel,
                  builder: (_, state, child) {
                    if (state is LoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is SuccessState<DomainModel>) {
                      final domainInfo = state.data;
                      return DomainCardWidget(domainModel: domainInfo);
                    }
                    if (state is ErrorState<DomainModel>) {
                      final error = state.exception as AppException;
                      return AppExceptionWidget(exception: error);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
