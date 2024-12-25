import 'package:flutter/material.dart';

class GVAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final double elevation;
  final bool centerTitle;

  const GVAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.elevation = 4.0,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: elevation,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      // leading: leading ?? Image(image: AssetImage('assets/images/logo.png')),
      actions: actions,
      iconTheme: const IconThemeData(color: Colors.black), // Ensures icons are black.
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Default app bar height.
}
