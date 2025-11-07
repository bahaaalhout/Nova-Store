import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Data/auth_firebase.dart';
import 'package:nova_store/nova_store/UI/provider/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(OnInitialState());

  isLoggedIn() {
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      emit(OnSuccessState(user: auth.currentUser!));
      return true;
    }
    return false;
  }

  login(String email, String password) async {
    emit(OnLoadingState());
    try {
      var user = await AuthFirebase.login(email, password);
      emit(OnSuccessState(user: user.user!));
    } catch (e) {
      emit(OnErrorState(errorMessage: e.toString()));
    }
  }

  signUp(String email, String password) async {
    emit(OnLoadingState());
    try {
      var user = await AuthFirebase.signUp(email, password);
      emit(OnSuccessState(user: user.user!));
    } catch (e) {
      emit(OnErrorState(errorMessage: e.toString()));
    }
  }
}
