import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hairsalon_prokit/screens/BHRegistrationScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:hairsalon_prokit/utils/BHColors.dart';
import 'package:hairsalon_prokit/utils/BHConstants.dart';
import 'package:hairsalon_prokit/utils/BHImages.dart';
import 'package:hairsalon_prokit/utils/BHWidgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase

import 'BHDashedBoardScreen.dart';
import 'BHForgotPasswordScreen.dart';

class BHLoginScreen extends StatefulWidget {
  static String tag = '/LoginScreen';

  @override
  BHLoginScreenState createState() => BHLoginScreenState();
}

class BHLoginScreenState extends State<BHLoginScreen> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  bool _showPassword = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    changeStatusColor(BHColorPrimary);
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusColor(Colors.transparent);
    emailFocusNode.dispose();
    passWordFocusNode.dispose();
  }

  Future<void> signInUser(String email, String password) async {
    try {
      // Await the sign-in response from Supabase
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Check if sign-in was successful based on the presence of a user object
      if (response.user != null) {
        // Handle successful sign-in (e.g., navigate to dashboard)
        print(response.user);
        print('Sign-in successful!');
        // Assuming you have a BHDashedBoardScreen:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BHDashedBoardScreen()),
        );
      } else {
        // Handle unsuccessful sign-in (e.g., display error message)
        print('Sign-in failed!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign In Failed'),
          ),
        );
      }
    } on Exception catch (e) {
      // Handle any exceptions that might occur during sign-in
      print('Sign-in error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign In Failed: $e'),
        ),
      );
    } finally {
      // Optionally, reset the loading state (if applicable)
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BHColorPrimary,
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  BHAppLogo,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.srcATop),
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 200),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: context.cardColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailCont,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passWordFocusNode);
                      },
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Email",
                        labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                      ),
                    ),
                    TextFormField(
                      controller: passwordCont,
                      focusNode: passWordFocusNode,
                      obscureText: !_showPassword,
                      keyboardType: TextInputType.text,
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: BHColorPrimary,
                              size: 20),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(BHTxtForgetPwd,
                              style: TextStyle(
                                  color: BHAppTextColorSecondary, fontSize: 14))
                          .onTap(
                        () {
                          BHForgotPasswordScreen().launch(context);
                        },
                      ),
                    ),
                    16.height,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BHColorPrimary,
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () {
                          signInUser(emailCont.text, passwordCont.text);
                        },
                        child: Text(
                          BHBtnSignIn,
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                                height: 1,
                                color: BHAppDividerColor,
                                margin: EdgeInsets.only(right: 10))
                            .expand(),
                        Text(BHTxtOrSignIn, style: secondaryTextStyle()),
                        Container(
                                height: 1,
                                color: BHAppDividerColor,
                                margin: EdgeInsets.only(left: 10))
                            .expand(),
                      ],
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(BHTwitterIcon, height: 40, width: 40),
                        SvgPicture.asset(BHFacebookIcon, height: 40, width: 40),
                        SvgPicture.asset(BHPinterestIcon,
                            height: 40, width: 40),
                      ],
                    ),
                    24.height,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text.rich(
                        TextSpan(
                          text: "You don't have an account! ",
                          style: TextStyle(color: BHAppTextColorSecondary),
                          children: <TextSpan>[
                            TextSpan(
                                text: BHBtnSignUp,
                                style: TextStyle(color: BHColorPrimary)),
                          ],
                        ),
                      ).onTap(
                        () {
                          BHRegistrationScreen().launch(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
