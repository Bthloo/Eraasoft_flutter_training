import 'package:flutter/material.dart';

import '../../components/drawer.dart';

class HomeSceen extends StatelessWidget {
  const HomeSceen({super.key});
static const String routeName = 'homescreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
