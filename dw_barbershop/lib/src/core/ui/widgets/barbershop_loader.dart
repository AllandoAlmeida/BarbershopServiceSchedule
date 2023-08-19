import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BarbershopLoader extends StatelessWidget {
  const BarbershopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: Color.fromARGB(66, 209, 131, 23),
        size: 60,
      ),
    );
  }
}
