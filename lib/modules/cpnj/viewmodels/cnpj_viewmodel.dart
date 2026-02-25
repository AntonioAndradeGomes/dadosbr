import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_model.dart';
import 'package:dadosbr/modules/cpnj/repositories/cnpj_repository.dart';
import 'package:flutter/material.dart';

class CnpjViewmodel extends ValueNotifier<ViewState<CnpjModel>> {
  final CnpjRepository _cnpjRepository;

  CnpjViewmodel({required CnpjRepository cnpjRepository})
    : _cnpjRepository = cnpjRepository,
      super(const IdleState());

  Future<void> fetchCnpjInfo(String cnpj) async {
    value = const LoadingState();
    final result = await _cnpjRepository.getCnpjInfo(cnpj);
    result.fold(
      (cnpjInfo) => value = SuccessState(cnpjInfo),
      (error) => value = ErrorState(error),
    );
  }
}
