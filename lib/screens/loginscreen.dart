import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_x_work/providers/providers.dart';
import 'package:total_x_work/screens/signupscreen.dart';

import 'package:total_x_work/utils/responsive.dart';

import '../services/user_service.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailError = ref.watch(errorProvider);
    final passwordError = ref.watch(passwordErrorProvider);
    final hiddensignin = ref.watch(hiddenpassworedsigninProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Responsive.height(86, context),
                horizontal: Responsive.width(32, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: Responsive.width(24, context),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Make it work, make it right, make it fast",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive.width(14, context)),
                ),
                SizedBox(
                  height: Responsive.height(20, context),
                ),
                TextField(
                  onChanged: (value) {
                    if (value == "") {
                      ref.read(errorProvider.notifier).state = false;
                    } else {
                      ref.read(errorProvider.notifier).state = true;
                    }
                  },
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    errorText: emailError ? null : "please enter email",
                    enabledBorder: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    prefixIcon: const Icon(Icons.email),
                    hintText: "E-Mail",
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(20, context),
                ),
                TextField(
                  onChanged: (value) {
                    if (value == "") {
                      ref.read(passwordErrorProvider.notifier).state = false;
                    } else {
                      ref.read(passwordErrorProvider.notifier).state = true;
                    }
                  },
                  controller: passwordcontroller,
                  obscureText: hiddensignin,
                  decoration: InputDecoration(
                    errorText:
                        passwordError ? null : "password must be 8 characters",
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    prefixIcon: const Icon(Icons.fingerprint_outlined),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (hiddensignin == true) {
                            ref
                                .read(hiddenpassworedsigninProvider.notifier)
                                .state = false;
                          } else {
                            ref
                                .read(hiddenpassworedsigninProvider.notifier)
                                .state = true;
                          }
                        },
                        icon: Icon(!hiddensignin
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: Responsive.width(190, context)),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(20, context),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, Responsive.height(40, context)),
                      backgroundColor: Colors.black),
                ),
                SizedBox(
                  height: Responsive.height(20, context),
                ),
                const Center(child: Text("OR")),
                SizedBox(
                  height: Responsive.height(20, context),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await ref.read(authServiceProvider).signInWithGoogle();
                  },
                  icon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      "assets/images/google.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  label: const Text(
                    "Login with google",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1),
                      minimumSize:
                          Size(double.infinity, Responsive.height(40, context)),
                      backgroundColor: const Color(0xFFD3F0FF)),
                ),
                SizedBox(
                  height: Responsive.height(20, context),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone_android,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Login with phone",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1),
                        backgroundColor: Color(0xFFD3F0FF)),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(20, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
