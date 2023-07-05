import 'package:flutter/material.dart';

class BhhhAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BhhhAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 10,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      shadowColor: Colors.black26,
      title: const Text(
        "bhhh noise.",
        style: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
