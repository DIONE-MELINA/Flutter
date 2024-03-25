import "package:crud_operation/colors/colors.dart";
import "package:crud_operation/pages/Register/controller.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  //naming variables are adviced to be placed in the state of the widget and not the build context
  ///setState are not called in the build method
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final RegExp emailVAlid =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ListView(
            children: [
              const Text(
                textAlign: TextAlign.center,
                "Register",
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
                controller: _nameController,
                decoration: const InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(color: Pellets.whiteColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Pellets.whiteColor),
                    hintText: "email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid email";
                  } else if (!emailVAlid.hasMatch(value)) {
                    return "Please enter a valid email";
                  } else {
                    return null;
                  }
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid Password";
                  } else if (value.length <= 5) {
                    return "password must be greater then 5";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 400,
                decoration: const BoxDecoration(
                    color: Pellets.greyColor,
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(20))),
                child: ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18, color: Pellets.whiteColor),
                          )),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Already have an account?Sign In",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passController.text);
        await ref
            .read(userProvider.notifier)
            .fetchUserData(_nameController.text, _emailController.text);
        if (mounted) {
          Navigator.pop(context);
        }
        /*Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));*/
      }
    } catch (e) {
      if(mounted){
       ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
