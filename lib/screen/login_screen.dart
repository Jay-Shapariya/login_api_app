import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_api_app/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Login",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Please Login",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.useridController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "User ID", hintText: "Enter username"),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => TextFormField(
                  obscureText: controller.isObscure.value,
                  controller: controller.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.isObscure.value =
                            !controller.isObscure.value;
                      },
                      icon: controller.isObscure.value
                          ? const Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                            ),
                    ),
                    labelText: "Password",
                    hintText: "Enter password",
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.onLoginButtonPressed();
                  }
                },
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
