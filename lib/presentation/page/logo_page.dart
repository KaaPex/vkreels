import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LogoPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Image.asset(
              'assets/diamond.png',
              color: Colors.white,
              height: 64.0,
            ),
            Text(
              'VK-REELS',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 64,
            ),
            const CircularProgressIndicator(),
            Flexible(
              child: Container(),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
