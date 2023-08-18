import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/internet_bloc/internet_bloc.dart';
import '../bloc/internet_bloc/internet_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetBloc,InternetState>(
            listener:(context,state){
              if(state is InternetGainedState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Internet  Connected!"),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
              }
             else if(state is InternetLostState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Internet not Connected!"),
                    backgroundColor: Colors.red,
                ),
              );
             }
            },
            builder:(context,state){
      if( state is InternetGainedState){        // = = to check value  and is  use to check data Type
             return Text("Connected!");
           }else if(state is InternetLostState){
             return Text("NotConnected!");
           }else{
             return Text("Loading!...");
           }
        }

        ),
      ),
      )
    );
  }
}
