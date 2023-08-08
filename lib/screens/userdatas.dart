import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Userdata extends ConsumerWidget {
  const Userdata({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Users"),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              tileColor: const Color.fromARGB(255, 228, 230, 230),
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
              ),
              title: const Text("shabeeb"),
              subtitle: const Text("22"),
            ),
          );
        },
      )),
    );
  }
}
