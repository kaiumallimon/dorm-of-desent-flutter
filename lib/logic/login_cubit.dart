import 'package:dorm_of_decents/data/models/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;
  
  LoginSuccess({required this.loginResponse});

  @override
  List<Object?> get props => [loginResponse];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}


// Login cubit
