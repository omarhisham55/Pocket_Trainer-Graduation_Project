import 'package:flutter/material.dart';

import '../components/components.dart';

class Nutrition extends StatelessWidget {
  const Nutrition({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: titleText(text: 'nutrition',color: Colors.black),);
  }
}