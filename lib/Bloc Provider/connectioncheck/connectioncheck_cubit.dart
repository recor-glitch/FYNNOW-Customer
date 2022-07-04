import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'connectioncheck_state.dart';

class ConnectioncheckCubit extends Cubit<ConnectioncheckState> {
  Connectivity connectivity;
  ConnectioncheckCubit({required this.connectivity})
      : super(ConnectioncheckLoading()) {
    connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        emit(CheckDisconnected());
      }
    });
    connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(CheckDisconnected());
      } else {
        emit(CheckConnected());
      }
    });
  }
}
