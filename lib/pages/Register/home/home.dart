import 'package:crud_operation/colors/colors.dart';
import 'package:crud_operation/pages/Register/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Users = ref.watch(userProvider).user;

    return Scaffold(
      backgroundColor: Pellets.whiteColor,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {},
              leading: CircleAvatar(
                  radius: 30.0,
                  child:
                      Image(image: NetworkImage(Users.photoUrl, scale: 1.0))),
              title: Text(Users.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const Text(
              "Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(Users.name,
                style: const TextStyle(color: Colors.black, fontSize: 13)),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const Text(
              "Email",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              Users.email,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                "Click to go to my github page",
                style: TextStyle(
                  color: Pellets.blackColor,
                  fontSize: 15,
                ),
              ),
              TextButton(
                  onPressed: _launchURL, child: Icon(Icons.arrow_forward_ios)),
            ]),
          ],
        ),
      )),
    );
  }
}

Future<void> _launchURL() async {
  const url = "https://github.com/DIONE-MELINA";
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw "Could not launch $url";
  }
}
