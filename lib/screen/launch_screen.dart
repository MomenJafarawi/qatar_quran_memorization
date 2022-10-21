import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qatar_quran_memorization/prefernces/shared_pref_controller.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        String route = SharedPrefController()
                    .getValueFor<bool>(key: prefKeys.loggedIn.name) ??
                false
            ? '/home_screen'
            : '/login_screen';
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(
            // color: Color(0xff46594e),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [
                Color(0xff46594e),
                Color(0xffc1c4c1),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
              // clipBehavior: Clip.antiAlias,
              height: 180,
              width: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/quran_logo.png',
                  ),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 470, right: 122),
          child: Text(
            'حلقات القرآن',
            style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
          ),
        )
      ],
    ));
  }
}
