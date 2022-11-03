import 'package:flutter/material.dart';

AppBar appBarHome(AnimationController controller) => AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: null,
        icon: AnimatedIcon(
          icon: AnimatedIcons.arrow_menu,
          progress: controller,
        ),
      ),
    );
