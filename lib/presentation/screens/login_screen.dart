import 'package:flutter/material.dart';
import 'package:vk_reels/core/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

const String _signUpUrl = 'https://vk.com/join';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _launchURL() async {
    if (!await launch(_signUpUrl)) throw 'Could not launch $_signUpUrl';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // add some space
              Flexible(
                child: Container(),
                flex: 1,
              ),
              // logo image
              Image.asset(
                'assets/diamond.png',
                color: primaryColor,
                height: 64.0,
              ),
              const SizedBox(
                height: 64.0,
              ),
              // app name
              Text(
                'VK-REELS',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 64,
              ),
              // login button
              InkWell(
                onTap: () {},
                child: Container(
                  child: const Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              // Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: _launchURL,
                    child: Container(
                      child: const Text(
                        "Sign up.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blueColor,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  )
                ],
              ),
              // Copyright info
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'All right reserved',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
