import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hairsalon_prokit/screens/BHLoginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:hairsalon_prokit/utils/BHColors.dart';
import 'package:hairsalon_prokit/utils/BHConstants.dart';
import 'package:hairsalon_prokit/utils/BHImages.dart';
import 'package:hairsalon_prokit/utils/BHWidgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Supabase için gerekli import

class BHRegistrationScreen extends StatefulWidget {
  static String tag = '/NewRegistrationScreen';

  @override
  NewRegistrationScreenState createState() => NewRegistrationScreenState();
}

class NewRegistrationScreenState extends State<BHRegistrationScreen> {
  bool _showPassword = false;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController fullNameCont = TextEditingController();
  TextEditingController dateOfBirthCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    fullNameFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    dobFocusNode.dispose();
    addressFocusNode.dispose();
  }

  Future<void> _register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth
          .signUp(email: emailCont.text, password: passwordCont.text, data: {
        'fullname': fullNameCont.text,
        'dateOfBirth': dateOfBirthCont.text,
        'address': addressCont.text
      });

      setState(() {
        isLoading = false;
      });

      if (response.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BHLoginScreen()) // const kaldırıldı
            );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Registration Failed')));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(BHColorPrimary);

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
                      controller: fullNameCont,
                      focusNode: fullNameFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Full Name",
                        labelStyle: secondaryTextStyle(),
                      ),
                    ),
                    TextFormField(
                      controller: passwordCont,
                      focusNode: passwordFocusNode,
                      obscureText: !_showPassword,
                      keyboardType: TextInputType.text,
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: secondaryTextStyle(),
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
                    TextFormField(
                      controller: emailCont,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(dobFocusNode);
                      },
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Email",
                        labelStyle: secondaryTextStyle(),
                      ),
                    ),
                    TextFormField(
                      controller: dateOfBirthCont,
                      keyboardType: TextInputType.datetime,
                      focusNode: dobFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(addressFocusNode);
                      },
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Date of Birth",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2014, 8),
                                lastDate: DateTime(2101));
                          },
                          child: Icon(Icons.calendar_today,
                              color: BHColorPrimary, size: 16),
                        ),
                        labelStyle: secondaryTextStyle(),
                      ),
                    ),
                    TextFormField(
                      controller: addressCont,
                      focusNode: addressFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Your Address",
                        suffixIcon: Icon(Icons.location_on,
                            color: BHColorPrimary, size: 18),
                        labelStyle: secondaryTextStyle(),
                      ),
                    ),
                    24.height,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          backgroundColor: BHColorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () {
                          _register(); // Sign up butonuna tıklandığında _register fonksiyonunu çağır
                        },
                        child: Text(
                          BHBtnSignUp,
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    24.height,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          finish(context);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: BHTxtAccount,
                            style: TextStyle(color: BHAppTextColorSecondary),
                            children: <TextSpan>[
                              TextSpan(
                                  text: BHBtnSignIn,
                                  style: TextStyle(color: BHColorPrimary))
                            ],
                          ),
                        ),
                      ),
                    ),
                    8.height,
                  ],
                ),
              ),
            ),
            BackButton(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
