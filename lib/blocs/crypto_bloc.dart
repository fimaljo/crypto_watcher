import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/models/currency.dart';
import 'package:equatable/equatable.dart';

import 'package:crypto_app/models/data_error.dart';
import '../../services/data_repo.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;

  CryptoBloc({required CryptoRepository cryptoRepository})
      : _cryptoRepository = cryptoRepository,
        super(CryptoState.start()) {
    on<Start>((event, emit) => _start(emit));
    on<RefreshCoins>((event, emit) => _getCoins(emit));
  }

  Future<CryptoState> _getCoins(Emitter<CryptoState> emit) async {
    try {
      final coins = await _cryptoRepository.getCurrencies();
      emit(state.copyWith(coins: coins, status: Status.loaded));
      return state;
    } on DataError catch (err) {
      emit(state.copyWith(
        failure: err,
        status: Status.error,
      ));
      return state;
    }
  }

  Future<CryptoState> _start(Emitter<CryptoState> emit) async {
    state.copyWith(status: Status.loading);
    return _getCoins(emit);
  }
}
