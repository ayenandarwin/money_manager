import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:money_manager_app/presentation/screens/navi_screen.dart';
import 'package:money_manager_app/service/authorizeService.dart';
import 'package:money_manager_app/service/hive_service.dart';
import 'package:money_manager_app/utils/color.dart';
import 'package:money_manager_app/utils/global.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  bool _remember = false;
  String? rememberName;
  String? rememberPassword;
  bool showPassword = false;
  bool isloading = false;

  var _isObscured;
  bool? isChecked = false;

  @override
  void initState() {
    _isObscured = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // bool? isChecked = false;

    return Scaffold(
      //backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: size.height / 2),
              height: size.height / 5 * 2.1,
              decoration: BoxDecoration(
                color: primary,
                //  color: Constants.green3,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 130),
                Center(
                  child: Image.asset(
                    'assets/images/wallet.png',
                    width: 60,
                    height: 60,
                    // scale: 0.1,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Money",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Tracker",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: MediaQuery.of(context).size.width * 0.85,
                        // height: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 16),
                            Center(
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: emailController,
                                focusNode: emailFocusNode,
                                //  keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "email",
                                  labelStyle: TextStyle(fontSize: 12),
                                  suffixIcon: Icon(Icons.email_outlined),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                obscureText: _isObscured,
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                decoration: InputDecoration(
                                  labelText: "password",
                                  labelStyle: TextStyle(fontSize: 12),
                                  suffixIcon: IconButton(
                                    icon:
                                        _isObscured
                                            ? Icon(Icons.visibility_outlined)
                                            : Icon(
                                              Icons.visibility_off_outlined,
                                            ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured = !_isObscured;
                                      });
                                    },
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _remember = !_remember;
                                    });
                                  },
                                  child:
                                      _remember
                                          ? Icon(
                                            Icons.check_box,
                                            color: primary,
                                            size: 25,
                                          )
                                          : Icon(
                                            Icons.check_box_outline_blank,
                                            color: primary,
                                            size: 25,
                                          ),
                                ),
                                Text(
                                  "Remember User",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(.9),
                                    fontSize: 12,
                                  ),
                                ),

                                SizedBox(width: 45),
                                Consumer(
                                  builder: (context, ref, child) {
                                    return isloading
                                        ? Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.22,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.0575,
                                          padding: EdgeInsets.all(15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: primary,
                                          ),
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              //strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                        : GestureDetector(
                                          onTap: () {
                                            // Get.off(() => const MainScreen());
                                            emailFocusNode.unfocus();
                                            passwordFocusNode.unfocus();
                                            if (emailController.text != "" &&
                                                passwordController.text != "") {
                                              setState(() {
                                                isloading = true;
                                              });
                                              ref
                                                  .watch(authServiceProvider)
                                                  .login(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                  )
                                                  .then((value) async {
                                                    var status =
                                                        value["accessToken"];
                                                    if (status.isNotEmpty) {
                                                      var token =
                                                          value["accessToken"]; // <-- Fix here

                                                      if (token != null) {
                                                        // await SharedPref.setData(
                                                        //   key: SharedPref.token,
                                                        //   value: "$token",
                                                        // );
                                                        await HiveCacheManager()
                                                            .saveToken(token);
                                                      }

                                                      debugPrint(
                                                        'token $token',
                                                      );
                                                      if (_remember) {
                                                        debugPrint("Remember");
                                                      }

                                                      Global.isLogIn = true;
                                                      Global.loginStatus();
                                                      setState(() {
                                                        isloading = false;
                                                      });
                                                      Get.off(
                                                        () => MainScreen(),
                                                      );
                                                    } else {
                                                      setState(() {
                                                        isloading = false;
                                                        emailController.clear();
                                                        passwordController
                                                            .clear();
                                                        Get.snackbar(
                                                          "Alert",
                                                          "အကောင့်ဝင်ခြင်း မအောင်မြင်ပါ",
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                        );
                                                      });
                                                    }
                                                  });
                                            } else {
                                              Get.snackbar(
                                                "Alert",
                                                "Please Enter Required Field",
                                                backgroundColor:
                                                    Colors.redAccent,
                                              );
                                            }
                                          },
                                          child: Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.22,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.0575,
                                            padding: EdgeInsets.all(15),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: primary,
                                            ),
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
