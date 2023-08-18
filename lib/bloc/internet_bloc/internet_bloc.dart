import 'dart:async';

import 'package:check_internet_usingbloc/bloc/internet_bloc/internet_event.dart';
import 'package:check_internet_usingbloc/bloc/internet_bloc/internet_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent,InternetState>{

  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

    InternetBloc() : super(InternetInitialState()){     // super intialise the bloc
       on<InternetLosTEvent>((event, emit) => emit(InternetLostState()));
       on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    connectivitySubscription =  _connectivity.onConnectivityChanged.listen((result) {
         if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
           add(InternetGainedEvent());
         }else{
           add(InternetLosTEvent());
         }
       });

    }

    @override
  Future<void> close() {
    // TODO: implement close
      connectivitySubscription?.cancel();
    return super.close();
  }
}