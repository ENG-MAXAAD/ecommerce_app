import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const Gap(16),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset("assets/img/banner1.jpg"),
            ),
          ),
          const Gap(kPadding),
          const Text(
            "WELCOME!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          const Text(
            "Please enter your credentials to sign up",
            style: TextStyle(
                // fontSize: 24,
                ),
          ),
          const Gap(kPadding),
          Container(
            width: 80,
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xff0EBE7F),
            ),
          ),
          const Gap(kPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  prefixIcon: Icon(
                    IconlyBold.profile,
                    color: Color(0xff0EBE7F),
                  )),
            ),
          ),
          const Gap(kPadding * 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: TextField(
              controller: username,
              decoration: const InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  prefixIcon: Icon(
                    IconlyBold.profile,
                    color: Color(0xff0EBE7F),
                  )),
            ),
          ),
          const Gap(kPadding * 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                prefixIcon: Icon(
                  IconlyBold.lock,
                  color: Color(0xff0EBE7F),
                ),
              ),
            ),
          ),
          const Gap(8),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                      child: const RegisterScreen(),
                      type: PageTransitionType.fade)),
              child: const Text(
                "All ready have an account?",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const Gap(kPadding),
          Consumer<UserProvider>(builder: (context, cont, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: kPadding),
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                  onPressed: cont.loginState == LoginState.loading
                      ? null
                      : () => cont.register(
                          name: name.text,
                          username: username.text,
                          password: password.text,
                          onSuccess: (user) {
                            password.clear();
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                    child: const LoginScreen(),
                                    type: PageTransitionType.fade),
                                (route) => false);
                          },
                          onError: (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  error.toString(),
                                ),
                              ),
                            );
                          }),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0EBE7F),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: cont.loginState == LoginState.loading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white),
                        )),
            );
          })
        ]),
      ),
    );
  }
}
