import 'package:creativepromotionweb/core/utils/references.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/textfield.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    final screenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .3),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.loginBackground),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * .13),
                  Image.asset(AppAssets.logo, height: screenHeight * .4),
                  SizedBox(height: screenHeight * .1),
                  TextFieldWidget(
                    controller: loginController.email,
                    hintText: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!value.isEmail) {
                        return 'Please enter correct email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * .025),
                  TextFieldWidget(
                    suffixIcon: IconButton(
                      icon: Icon(
                        !loginController.obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: !loginController.obscurePassword
                            ? Colors.grey
                            : Colors.blue,
                      ),
                      onPressed: loginController.signinpasswordstatus,
                    ),
                    hintText: "Password",
                    obscureText: !loginController.obscurePassword,
                    controller: loginController.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plese Enter Your Password Here";
                      }
                      // if (value.length < 8) {
                      //   return "Please Enter Password with 8 Characters";
                      // }

                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * .015),
                  GetBuilder<LoginController>(
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: loginController.isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newValue) {
                              loginController.isChecked =
                                  !loginController.isChecked;
                              loginController.update();
                            },
                          ),
                          Flexible(
                            child: RichText(
                                text: TextSpan(
                                    text: 'I agree to the ',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms and conditions',
                                    style: const TextStyle(
                                        color: Colors.blueAccent, fontSize: 14),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => launchPrivacyPolicyURL(),
                                  ),
                                  const TextSpan(
                                      text: ' and',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                  TextSpan(
                                    text: ' Privacy Policy',
                                    style: const TextStyle(
                                        color: Colors.blueAccent, fontSize: 14),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => launchPrivacyPolicyURL(),
                                  )
                                ])),
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * .015),
                  SizedBox(
                    width: Get.width,
                    child: AppButton(
                      onTap: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        loginController.login();
                      },
                      title: "Login",
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      color: AppColor.red,
                    ),
                  ),
                  SizedBox(height: screenHeight * .15),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
