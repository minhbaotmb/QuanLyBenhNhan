import 'package:flutter/material.dart';

class UnFocus extends StatelessWidget {
  final Widget child;

  const UnFocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Dùng để bọc form. Để un-focus keyboard
    return GestureDetector(
      child: child,
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  static void unfocusControls(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
