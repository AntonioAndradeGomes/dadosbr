import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/domain/models/domain_model.dart';
import 'package:dadosbr/modules/domain/repositories/domain_repository.dart';
import 'package:flutter/material.dart';

class DomainViewmodel extends ValueNotifier<ViewState<DomainModel>> {
  final DomainRepository _domainRepository;

  DomainViewmodel({required DomainRepository domainRepository})
    : _domainRepository = domainRepository,
      super(const IdleState());

  Future<void> fetchDomainInfo(String domain) async {
    value = const LoadingState();
    final result = await _domainRepository.getDomainInfo(domain);
    result.fold(
      (domainInfo) => value = SuccessState(domainInfo),
      (error) => value = ErrorState(error),
    );
  }
}
