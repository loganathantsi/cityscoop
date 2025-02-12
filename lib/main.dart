import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/dialog_terms/dialog_terms_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'login.dart';

void main() {
  runApp(CityScoop());
}

class CityScoop extends StatelessWidget {
  const CityScoop({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<DialogTermsBloc>(
          create: (context) => DialogTermsBloc(),
        ),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}


