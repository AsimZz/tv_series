import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/UIs/home_page.dart';
import 'package:tv_series/blocs/user_info_bloc/user_info_bloc.dart';

class GetUserPage extends StatefulWidget {
  final String token;
  GetUserPage({this.token});

  @override
  _GetUserPageState createState() => _GetUserPageState();
}

class _GetUserPageState extends State<GetUserPage> {
  @override
  void initState() {
    BlocProvider.of<UserInfoBloc>(context)
        .add(GetUserInfoEvent(token: widget.token));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.token);
    return Scaffold(
      body: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          if (state is LoadingUserInfoState) {
            return Container(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }
          if (state is LoadedUserInfoState) {
            print('FUCK:${state.response}');
            return HomePage(response: state.response);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
