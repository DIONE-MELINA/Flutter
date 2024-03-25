import 'package:crud_operation/colors/colors.dart';
import 'package:crud_operation/pages/Register/controller.dart';
import 'package:crud_operation/pages/Register/home/home.dart';
import 'package:crud_operation/pages/Register/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogIn extends ConsumerStatefulWidget {
  const LogIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  bool _isloading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final RegExp emailVAlid =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 0),
      child: ListView(children: [
        const Text(
          textAlign: TextAlign.center,
          "LogIn to your account",
          style: TextStyle(
              letterSpacing: 2.0,
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Pellets.whiteColor),
              hintText: "email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: _passController,
          obscureText: true,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Pellets.whiteColor),
            hintText: "password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 400,
          decoration: const BoxDecoration(
              color: Pellets.greyColor,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),
          child: ElevatedButton(
              onPressed: _isloading ? null : _SignIn,
              child: _isloading
                  ? const CircularProgressIndicator()
                  : const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Pellets.whiteColor),
                    )),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
            child: const Text(
              "Don't have an account?Sign Up",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ))
      ]),
    ));
  }

  Future<void> _SignIn() async {
   
setState(() {
      _isloading = true;
  });
    
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passController.text);
      await ref.read(userProvider.notifier).getUserData(_emailController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  Home()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
        setState(() {
          _isloading = false;
        });
    }
  }
}

