import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/UI/provider/auth_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/auth_states.dart';
import 'package:nova_store/nova_store/UI/widgets/snack_bar.dart';
import 'package:nova_store/nova_store/UI/widgets/styled_button.dart';
import 'package:nova_store/nova_store/UI/widgets/text_input.dart';
import 'package:nova_store/nova_routes.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', width: 350),
                  // SizedBox(height: 20),
                  TextInput(
                    controller: _nameController,
                    validate: (name) {
                      if (name!.length < 3) {
                        return 'Should be more than 2 letter!';
                      }
                      return null;
                    },
                    hintText: 'Name',

                    isPass: false,
                  ),
                  SizedBox(height: 12),
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
                  SizedBox(height: 12),
                  TextInput(
                    controller: _passController,
                    validate: (pass) {
                      if (pass!.length < 8) {
                        return 'Enter a Stronger Password';
                      }
                      return null;
                    },
                    hintText: 'Password',

                    isPass: true,
                  ),
                  SizedBox(height: 12),
                  TextInput(
                    controller: _confirmPassController,
                    validate: (pass) {
                      if (pass != _passController.text) {
                        return 'Should be same of password';
                      }
                      return null;
                    },
                    hintText: 'Confirm Password',

                    isPass: true,
                  ),
                  SizedBox(height: 12),
                  TextInput(
                    controller: _phoneController,
                    validate: (phone) {
                      if (phone!.length != 10) {
                        return 'Enter the correct Phone Number';
                      }
                      return null;
                    },
                    hintText: 'Phone',

                    isPass: false,
                  ),
                  SizedBox(height: 17),
                  BlocBuilder<AuthCubit, AuthStates>(
                    builder: (context, state) => StyledButton(
                      onpressed: () {
                        signup(context);
                      },
                      buttonContent: State is OnLoadingState
                          ? CircularProgressIndicator()
                          : Text(
                              'SignUp',
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
                      ).pushReplacementNamed(NovaRoutes.login);
                    },
                    child: Text('Do You Already Have an Account? Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(
        context,
      ).signUp(_emailController.text, _passController.text);
    }
  }
}
