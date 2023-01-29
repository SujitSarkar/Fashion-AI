import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Opacity(
            opacity: 0.2,
            child: ModalBarrier(dismissible: false, color: Colors.black)),
        Center(child: Lottie.asset('assets/lotties/loading_lottie.json',
            width: 80,
            fit: BoxFit.fitWidth),),
      ],
    );
  }
}
