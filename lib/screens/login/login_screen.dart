import 'package:bloc_practice/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('eve.holt@reqres.in'),
              Text('cityslicka'),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen:
                    (previous, current) => previous.email != current.email,
                builder:
                    (context, state) => TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      onChanged:
                          (value) => context.read<LoginBloc>().add(
                            EmailChanged(email: value),
                          ),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
              ),
              SizedBox(height: 20),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen:
                    (previous, current) =>
                        previous.password != current.password,
                builder:
                    (context, state) => TextFormField(
                      keyboardType: TextInputType.text,
                      focusNode: passwordFocusNode,
                      onChanged:
                          (value) => context.read<LoginBloc>().add(
                            PasswordChanged(password: value),
                          ),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
              ),
              SizedBox(height: 30),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.loginStatus == LoginStatus.loading) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('Submitting')),
                      );
                  }
                  if (state.loginStatus == LoginStatus.success) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state.loginStatus == LoginStatus.error) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) => false,
                  builder:
                      (context, state) => ElevatedButton(
                        onPressed:
                            () => context.read<LoginBloc>().add(LoginApi()),
                        child: const Text('Login'),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
