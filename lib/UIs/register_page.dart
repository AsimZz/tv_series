import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/UIs/login_page.dart';
import 'package:tv_series/blocs/register_bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
        create: (_) => RegisterBloc(), child: SignupPage());
  }
}

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _usernameController.addListener(_onUsernameChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        print(state);
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(state.authFailMessage), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Color(0xFF9E1F28),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Creating User please wait...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Color(0xFF2FD20A),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Account Created Successfully!!'),
                    Icon(Icons.check_circle),
                  ],
                ),
              ),
            );
        }
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'REGISTER PAGE',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 37,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9E1F28)),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: 90,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFFD72C38),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                          hintText: 'Choose a username',
                                          border: InputBorder.none),
                                      autovalidate: true,
                                      autocorrect: false,
                                      validator: (_) {
                                        return !state.isUsernameValid
                                            ? 'Invalid Username'
                                            : null;
                                      }),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                          hintText: 'Enter your Email',
                                          border: InputBorder.none),
                                      autovalidate: true,
                                      autocorrect: false,
                                      validator: (_) {
                                        return !state.isEmailValid
                                            ? 'Invalid Email'
                                            : null;
                                      }),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                      obscureText: true,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                          hintText: 'Create Password',
                                          border: InputBorder.none),
                                      autovalidate: true,
                                      autocorrect: false,
                                      validator: (_) {
                                        return !state.isPasswordValid
                                            ? 'Invalid Password'
                                            : null;
                                      }),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                      controller: _confirmPasswordController,
                                      decoration: InputDecoration(
                                          hintText: 'Confirm Password',
                                          border: InputBorder.none),
                                      autovalidate: true,
                                      autocorrect: false,
                                      obscureText: true,
                                      validator: (_) {
                                        return !(state.isPasswordConfirmed)
                                            ? 'No match!!'
                                            : null;
                                      }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              _onsignupButtonPressed();
                            },
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                height: 50,
                                width: 160.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFD45253),
                                      Color(0xFF9E1F28),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF9E1F28),
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'SIGNUP',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Already have an account?',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                                child: Text('Login Now',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9E1F28))),
                              )
                            ],
                          ),
                          //  Center(child: CircularProgressIndicator())
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    _registerBloc.add(
      UsernameChanged(username: _usernameController.text),
    );
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onConfirmPasswordChanged() {
    _registerBloc.add(ConfirmPasswordChanged(
      isPasswordConfirmed:
          _confirmPasswordController.text == _passwordController.text,
    ));
  }

  void _onsignupButtonPressed() {
    _registerBloc.add(
      SignUpButtonPressed(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text),
    );
  }
}
