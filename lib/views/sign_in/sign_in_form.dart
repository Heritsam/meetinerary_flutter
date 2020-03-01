import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetinerary/views/sign_in/bloc/bloc.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscure = true;

  void _signInButtonPressed() {
    BlocProvider.of<SignInBloc>(context).add(
      SignInButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 8.0),
                    Text(
                      'Meetinerary',
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w800,
                          fontSize: 32.0
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Please sign into the app',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 56.0),
                    Card(
                      elevation: 0.0,
                      color: Colors.blueGrey[50],
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Email address',
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      elevation: 0.0,
                      color: Colors.blueGrey[50],
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                            color: Colors.black45,
                          ),
                        ),
                        obscureText: _isObscure,
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed:
                            state is! SignInLoading ? _signInButtonPressed : null,
                        child:
                            state is! SignInLoading ? Text('Sign in') : CircularProgressIndicator(),
                        elevation: 0.0,
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
