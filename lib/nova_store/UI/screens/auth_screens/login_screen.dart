import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/UI/provider/auth_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/auth_states.dart';
import 'package:nova_store/nova_store/UI/widgets/snack_bar.dart';
import 'package:nova_store/nova_store/UI/widgets/styled_button.dart';
import 'package:nova_store/nova_store/UI/widgets/text_input.dart';
import 'package:nova_store/nova_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is OnSuccessState) {
          Navigator.of(context).pushReplacementNamed(NovaRoutes.home);
        } else if (state is OnErrorState) {
          ShowSnackBar().snackBar(context, state.errorMessage);
        }
      },
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png'),
                  // SizedBox(height: 20),
                  TextInput(
                    controller: _emailController,
                    validate: (email) {
                      if (!email!.contains("@gmail.com")) {
                        return 'Enter a Valid Email Address';
                      }
                      return null;
                    },
                    hintText: 'Email',

                    isPass: false,
                  ),
                  SizedBox(height: 10),
                  TextInput(
                    controller: _passController,
                    validate: (pass) {
                      if (pass!.length < 8) {
                        return 'Enter The Correct Password';
                      }
                      return null;
                    },
                    hintText: 'Password',

                    isPass: true,
                  ),
                  SizedBox(height: 17),
                  BlocBuilder<AuthCubit, AuthStates>(
                    builder: (context, state) => StyledButton(
                      onpressed: () {
                        login(context);
                      },
                      buttonContent: State is OnLoadingState
                          ? CircularProgressIndicator()
                          : Text(
                              'Login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(NovaRoutes.signup);
                    },
                    child: Text('You dont have an account? SignUp'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(
        context,
      ).login(_emailController.text, _passController.text);
    }
  }
}
