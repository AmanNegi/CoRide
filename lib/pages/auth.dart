import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:co_ride/globals.dart';
import 'package:co_ride/pages/home_page.dart';
import 'package:co_ride/widgets/action_button.dart';

class AuthPage extends StatefulWidget {
  static const String route = "/LoginPage";

  const AuthPage({super.key});
  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  String email = "", password = "", userName = "";
  late double height, width;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accentColor,
                      Theme.of(context).primaryColor,

                      // Color(0xFF03045e),
                      // Color(0xFF0077b6),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.045 * getHeight(context),
              left: 0.1 * getHeight(context),
              right: 0.1 * getHeight(context),
              child: Image.asset("assets/logo_transparent.png"),
            ),
            Positioned(
              top: 0.255 * getHeight(context),
              left: 0.1 * getHeight(context),
              right: 0.1 * getHeight(context),
              child: const Center(
                child: Text(
                  "Co-Ride",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.285 * getHeight(context),
              left: 0.1 * getHeight(context),
              right: 0.1 * getHeight(context),
              child: const Center(
                child: Text(
                  "Take a Ride, make a difference",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.1 * getHeight(context),
              left: 0,
              right: 0,
              bottom: 0,
              child: _getCard(context),
            ),
          ],
        ),
      ),
    );
  }

  _getCard(BuildContext context) {
    return PageView.builder(
        controller: controller,
        itemCount: 2,
        itemBuilder: (context, index) {
          return _getForm(context, index == 0);
        });
  }

  _getForm(BuildContext context, bool isLogin) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            color: Theme.of(context).cardColor,
            elevation: 20,
            shadowColor: Colors.white30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isLogin ? "Login" : "Signup",
                      style: const TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      )),
                  const SizedBox(height: 12),
                  if (!isLogin)
                    _buildTextField("Username", (e) => userName = e.trim()),
                  _buildTextField("Email", (e) => email = e.trim()),
                  _buildTextField("Password", (e) => password = e.trim()),
                  const SizedBox(height: 20),
                  ActionButton(
                    onPressed: () async {
                      goToPage(context, const HomePage(), clearStack: true);
                    },
                    text: "Proceed",
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      controller.animateToPage(
                        isLogin ? 1 : 0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    child: RichText(
                      text: TextSpan(style: GoogleFonts.poppins(), children: [
                        TextSpan(
                            text: isLogin
                                ? "Don't have an account?"
                                : "Already have an account?",
                            style: const TextStyle(color: Colors.black)),
                        TextSpan(
                            text: isLogin ? " Sign Up" : " Login",
                            style: TextStyle(color: accentColor))
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTextField(String text, Function onChange) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          onChanged: (e) => onChange(e),
          decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 20.0)),
        ),
      ),
    );
  }
}
