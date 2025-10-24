import 'package:firebase_auth/firebase_auth.dart';

class AuthStates {}

class OnInitialState extends AuthStates {}

class OnLoadingState extends AuthStates {}

class OnSuccessState extends AuthStates {
  final User user;
  OnSuccessState({required this.user});
}

class OnErrorState extends AuthStates {
  final String errorMessage;
  OnErrorState({required this.errorMessage});
}
