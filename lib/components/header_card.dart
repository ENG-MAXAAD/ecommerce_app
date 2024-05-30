import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class HeaderCard extends StatelessWidget {
  final UserModel user;
  const HeaderCard({
    super.key,
    required this.user,
    // required UserModel userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, cont, child) {
      return Row(
        children: [
          Expanded(
            child: ListTile(
              leading: InkWell(
                onLongPress: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("${kEndpoint}/${user.photo}" ??
                      "https://avatars.githubusercontent.com/u/11613304?v=4"),
                ),
              ),
              title: Text(cont.user.name ?? "Zakaria Ahmed "),
              subtitle: const Text("Welcome Back"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: kPadding),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartScreen())),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.green,

                // color: Colors.white,
              ),
            ),
          )
        ],
      );
    });
  }
}
