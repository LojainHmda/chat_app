import 'package:chat_app/core/utils/routes/app_routes.dart';
import 'package:chat_app/features/auth/views/login_page.dart';
import 'package:chat_app/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/chat/views/pages/chat_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (_) => const LoginPage(), settings: settings);

      case AppRoutes.chat:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit= ChatCubit();
                    cubit.getMessages();
                    return cubit;
                  },
                  child: const ChatPage(),
                ),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(title: const Text('Not Found')),
                  body: const Center(child: Text('Page not found')),
                ));
    }
  }
}
