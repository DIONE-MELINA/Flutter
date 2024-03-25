import 'package:crud_operation/colors/colors.dart';
import 'package:crud_operation/firebase_options.dart';
import 'package:crud_operation/pages/Register/controller.dart';
import 'package:crud_operation/pages/Register/home/home.dart';
import 'package:crud_operation/pages/Register/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _myAppState();
}

class _myAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Pellets.darkmodethem,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ref
                  .read(userProvider.notifier)
                  .getUserData(snapshot.data!.email!);
              return Home();
            } else {
              return const LogIn();
            }
          }),
    );
  }
}
