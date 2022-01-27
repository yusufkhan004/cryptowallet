import 'package:cryptowallet/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:cryptowallet/domain/core/value_validators.dart';
import 'package:cryptowallet/infrastructure/auth/auth_failure_or_success.dart';
import 'package:cryptowallet/pages/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        if (state.authFailureOrSuccess == AuthFailureOrSuccess.success()) {
          showInSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.blue,
                content: Text('Success'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.emailAlreadyInUse()) {
          showInSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Email Already In Use'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.invalidEmailAndPassword()) {
          showInSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.blue,
                content: Text('Invalid Email And Password'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.serverError()) {
          showInSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Server Error'),
              ));
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 50,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Form(
            autovalidate: state.showErrorMessages,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email Address',
                      ),
                      autocorrect: false,
                      autofocus: false,
                      onChanged: (value) =>
                          BlocProvider.of<SignInFormBloc>(context)
                              .add(SignInFormEvent.emailChange(value)),
                      validator: (_) => validateEmailAddress(
                              BlocProvider.of<SignInFormBloc>(context)
                                  .state
                                  .emailAddress)
                          ? null
                          : "Invalid Email",
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        autocorrect: false,
                        autofocus: false,
                        obscureText: true,
                        onChanged: (value) =>
                            BlocProvider.of<SignInFormBloc>(context)
                                .add(SignInFormEvent.passwordChange(value)),
                        validator: (_) => validatePassword(
                                BlocProvider.of<SignInFormBloc>(context)
                                    .state
                                    .password)
                            ? null
                            : 'Short Password'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        const Text(
                          'Forget your password?',
                          style: TextStyle(
                            color: Color(0xff347af0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // ignore: deprecated_member_use
                Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<SignInFormBloc>(context)
                            .add(SignInFormEvent.signInWithEmailAndPassword());
                      },
                      color: const Color(0xff347af0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(
                          color: Color(0xff347af0),
                        ),
                      ),
                      child: Container(
                        width: 160,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        const Text(
                          'Dont\'t have an account?',
                          style: TextStyle(
                            color: Color(0xff485068),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpPage();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up?',
                            style: TextStyle(
                              color: Color(0xff347af0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showInSnackBar(BuildContext context, Widget snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: snackBar));
  }
}
