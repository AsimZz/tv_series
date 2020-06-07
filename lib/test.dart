// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tv_series/UIs/login_page.dart';
// import 'package:tv_series/UIs/register_page.dart';
// import 'package:tv_series/blocs/register_bloc/register_bloc.dart';

// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     _onsignupButtonPressed() {
//       RegisterBloc()
//         ..add(
//           SignUpButtonPressed(
//               username: _usernameController.text,
//               email: _emailController.text,
//               password: _passwordController.text,
//               confirmPassword: _confirmPasswordController.text),
//         );
//     }

//     return Scaffold(
//         body: BlocProvider<RegisterBloc>(
//             create: (BuildContext context) => RegisterBloc(),
//             child: BlocListener<RegisterBloc, RegisterState>(
//               listener: (context, state) {
//                 print(state);
//                 if (state is RegisterFailure) {
//                   Scaffold.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('${state.error}'),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//               child: BlocBuilder<RegisterBloc, RegisterState>(
//                   builder: (context, state) {
//                 return Container(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                           ),
//                           child: SingleChildScrollView(
//                             child: Padding(
//                               padding: EdgeInsets.all(30),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   SizedBox(
//                                     height: 50,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Text(
//                                       'REGISTER PAGE',
//                                       style: TextStyle(
//                                           fontFamily: 'Poppins',
//                                           fontSize: 37,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF9E1F28)),
//                                       textAlign: TextAlign.start,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 90,
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color: Color(0xFFD72C38),
//                                               blurRadius: 20,
//                                               offset: Offset(0, 10))
//                                         ]),
//                                     child: Column(
//                                       children: <Widget>[
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                   bottom: BorderSide(
//                                                       color:
//                                                           Colors.grey[200]))),
//                                           child: TextField(
//                                             controller: _usernameController,
//                                             decoration: InputDecoration(
//                                                 hintText: 'Choose a username',
//                                                 border: InputBorder.none),
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                   bottom: BorderSide(
//                                                       color:
//                                                           Colors.grey[200]))),
//                                           child: TextField(
//                                             controller: _emailController,
//                                             decoration: InputDecoration(
//                                                 hintText: 'Enter your Email',
//                                                 border: InputBorder.none),
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                   bottom: BorderSide(
//                                                       color:
//                                                           Colors.grey[200]))),
//                                           child: TextField(
//                                             controller: _passwordController,
//                                             decoration: InputDecoration(
//                                                 hintText: 'Create Password',
//                                                 border: InputBorder.none),
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                   bottom: BorderSide(
//                                                       color:
//                                                           Colors.grey[200]))),
//                                           child: TextField(
//                                             controller:
//                                                 _confirmPasswordController,
//                                             decoration: InputDecoration(
//                                                 hintText: 'Confirm Password',
//                                                 border: InputBorder.none),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 40,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       _onsignupButtonPressed();
//                                       if (state is RegisterSuccess) {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     LoginPage()));
//                                       }
//                                     },
//                                     child: Center(
//                                       child: Container(
//                                         margin: EdgeInsets.all(10.0),
//                                         height: 50,
//                                         width: 160.0,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10.0),
//                                           gradient: LinearGradient(
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                             colors: [
//                                               Color(0xFFD45253),
//                                               Color(0xFF9E1F28),
//                                             ],
//                                           ),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Color(0xFF9E1F28),
//                                               offset: Offset(0.0, 2.0),
//                                               blurRadius: 6.0,
//                                             ),
//                                           ],
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'SIGNUP',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold,
//                                               letterSpacing: 1.8,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 30,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text('Already have an account?',
//                                           style: TextStyle(
//                                               fontFamily: 'Poppins',
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black)),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       RegisterPage()));
//                                         },
//                                         child: Text('Login Now',
//                                             style: TextStyle(
//                                                 fontFamily: 'Poppins',
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Color(0xFF9E1F28))),
//                                       )
//                                     ],
//                                   ),
//                                   Center(
//                                     child: Container(
//                                       child: state is RegisterLoading
//                                           ? CircularProgressIndicator()
//                                           : Text(''),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               }),
//             )));
//   }
// }
