import 'package:flutter/material.dart';
import 'package:tv_series/UIs/get_user_page.dart';
import 'package:tv_series/UIs/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/blocs/login_bloc/login_bloc.dart';
import 'package:tv_series/blocs/tv_search_bloc/bloc/bloc.dart';
import 'blocs/authentication_bloc/bloc/authentication_bloc.dart';
import 'blocs/user_info_bloc/user_info_bloc.dart';

void main() => runApp(
      BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc()..add(AppStarted());
        },
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return Container(
              child: Center(child: Text('Fuck')),
            );
          }
          if (state is AuthenticationAuthenticated) {
            final String token = state.token;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => TvSearchBloc(),
                ),
                BlocProvider<UserInfoBloc>(create: (_) => UserInfoBloc()),
              ],
              child: GetUserPage(token: token),
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<UserInfoBloc>(
                  create: (context) => UserInfoBloc(),
                ),
                BlocProvider<LoginBloc>(
                    create: (BuildContext context) => LoginBloc(
                          authenticationBloc:
                              BlocProvider.of<AuthenticationBloc>(context),
                        )),
              ],
              child: LoginPage(),
            );
          }
          if (state is AuthenticationLoading) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
