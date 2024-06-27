import 'package:Guillmors_coffe/src/bloc/loggin_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {

  static Provider? _instancia;

  factory Provider({Key? key,required Widget child}){

    _instancia ??= Provider._internal(key: key, child: child);
    return _instancia!;
  }

  final loginBloc = LoginBloc();

  Provider._internal({Key? key,required Widget child})
    : super(key: key, child: child);
  
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc? of ( BuildContext context ){
    var as = context.dependOnInheritedWidgetOfExactType<Provider>()?.loginBloc ?? LoginBloc();
    return as;
  }
}