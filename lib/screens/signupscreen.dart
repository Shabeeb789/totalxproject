import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_x_work/services/user_service.dart';

import '../providers/providers.dart';
import '../utils/responsive.dart';

class SignUp extends ConsumerWidget {
  SignUp({super.key});

  final TextEditingController signupemailcontroller = TextEditingController();
  final TextEditingController spasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semailError = ref.watch(emailProvider);
    final spasswordError = ref.watch(passwordProvider);
    final hidepassword = ref.watch(hidepasswordsignupProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Responsive.height(86, context),
                horizontal: Responsive.width(32, context)),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tell Us About You!",
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
                        ref.read(emailProvider.notifier).state = false;
                      } else {
                        ref.read(emailProvider.notifier).state = true;
                      }
                    },
                    controller: signupemailcontroller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorText: semailError ? null : "please enter email",
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
                        ref.read(passwordProvider.notifier).state = false;
                      } else {
                        ref.read(passwordProvider.notifier).state = true;
                      }
                    },
                    controller: spasswordcontroller,
                    obscureText: hidepassword,
                    decoration: InputDecoration(
                      errorText: spasswordError
                          ? null
                          : "password must be 8 characters",
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: const Icon(Icons.fingerprint_outlined),
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (hidepassword == true) {
                              ref
                                  .read(hidepasswordsignupProvider.notifier)
                                  .state = false;
                            } else {
                              ref
                                  .read(hidepasswordsignupProvider.notifier)
                                  .state = true;
                            }
                          },
                          icon: Icon(!hidepassword
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: Responsive.height(20, context),
                  ),
                  SizedBox(
                    height: Responsive.height(20, context),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // height: Responsive.height(100, context),
                    child: ElevatedButton(
                      onPressed: () async {
                        await ref.read(authServiceProvider).signup(
                            signupemailcontroller.text,
                            spasswordcontroller.text);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: Responsive.height(20, context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
