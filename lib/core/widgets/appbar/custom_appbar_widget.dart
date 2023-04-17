import 'package:bitely/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/image/image_constants.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../init/notifier/auth_notifier.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  CustomAppbarWidget({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            if (title != "Days") {
              Navigator.pop(context);
            }
          }),
      title: Text(title),
      actions: [
        ElevatedButton(
            child: Image.asset(ImageConstants.instance.power),
            onPressed: () async {
              await context.read<AuthProvider>().signOut().whenComplete(() =>
                  NavigationService.instance
                      .navigateToPageClear(path: NavigationConstants.LOGIN));
            })
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 50.0);
}
