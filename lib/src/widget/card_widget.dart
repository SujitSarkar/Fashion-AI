import 'package:flutter/Material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.child, this.bagColor}) : super(key: key);
  final Widget child;
  final Color? bagColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: bagColor??Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: child,
    );
  }
}
