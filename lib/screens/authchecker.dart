import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_x_work/screens/loginscreen.dart';
import 'package:total_x_work/screens/userdetail.dart';
import 'package:total_x_work/services/user_service.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateProvider).when(
          data: (data) {
            if (data == null) {
              return LoginScreen();
            } else {
              return DetailPage();
            }
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        );
  }
}
