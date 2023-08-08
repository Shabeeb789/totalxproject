import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:total_x_work/providers/providers.dart';
import 'package:total_x_work/screens/userdatas.dart';

import '../services/user_service.dart';
import '../utils/responsive.dart';

class DetailPage extends ConsumerWidget {
  DetailPage({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(imageProvider);

    Future<File> savepermanantly(String imagepath) async {
      final directory = await getApplicationDocumentsDirectory();
      final name = basename(imagepath);
      final image = File('${directory.path}/$name');

      return File(imagepath).copy(image.path);
    }

    getimage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        // final imagetemporary = File(image.path);
        final imagepermanent = await savepermanantly(image.path);

        ref.read(imageProvider.notifier).state = imagepermanent;
      } on PlatformException catch (e) {
        print("failed to pick image: $e");
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(32, context),
            vertical: Responsive.height(70, context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your\nDetails",
                style: TextStyle(
                    height: 1.5,
                    fontSize: Responsive.width(28, context),
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 32, 28, 119)),
              ),
              SizedBox(
                height: Responsive.height(20, context),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Select Image from!",
                                style: TextStyle(
                                    fontSize: Responsive.height(20, context),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Responsive.height(10, context),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  customButton(
                                    context: context,
                                    image: "assets/images/gallery.png",
                                    title: "Gallery",
                                    onclick: () {
                                      getimage(ImageSource.gallery);
                                    },
                                  ),
                                  customButton(
                                    context: context,
                                    image: "assets/images/camera.png",
                                    title: "Camera",
                                    onclick: () {
                                      getimage(ImageSource.camera);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      images != null
                          ? CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(
                                images,
                              ))
                          : const CircleAvatar(
                              radius: 80,
                              child: Icon(
                                Icons.person,
                                size: 100,
                              ),
                            ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.camera_alt_sharp,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.height(20, context),
              ),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: Responsive.height(20, context),
              ),
              TextField(
                controller: age,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  hintText: "Age",
                  hintStyle: TextStyle(color: Colors.black),
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
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize:
                        Size(double.infinity, Responsive.height(50, context)),
                  ),
                  child: const Text(
                    "Upload",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.height(20, context),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 87, 191, 243),
                  ),
                  onPressed: () async {
                    await ref.read(authServiceProvider).logout();
                  },
                  child: const Text("Log out")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Userdata(),
          ));
        },
        child: const Icon(Icons.account_circle),
      ),
    );
  }
}

Widget customButton({
  required BuildContext context,
  required String image,
  required String title,
  required VoidCallback onclick,
}) {
  return Card(
    color: Colors.white,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: Responsive.width(70, context),
          height: Responsive.height(70, context),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: onclick,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: Responsive.height(10, context),
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
