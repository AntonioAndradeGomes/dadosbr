import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/cep/models/cep_model.dart';
import 'package:dadosbr/modules/cep/repositories/cep_repository.dart';
import 'package:flutter/material.dart';

class CepViewmodel extends ValueNotifier<ViewState<CepModel>> {
  final CepRepository _cepRepository;

  CepViewmodel({required CepRepository cepRepository})
    : _cepRepository = cepRepository,
      super(const IdleState());

  Future<void> fetchCepInfo(String cep) async {
    value = const LoadingState();
    final result = await _cepRepository.getCepInfo(cep);
    result.fold(
      (cepInfo) => value = SuccessState(cepInfo),
      (error) => value = ErrorState(error),
    );
  }
}
