import 'package:auth/auth/login/service/controller/logincontroller.dart';
import 'package:auth/core/constants.dart';
import 'package:auth/core/services/scaffold_service.dart';
import 'package:auth/core/view/commonbackground.dart';
import 'package:auth/core/view/widgets/commonwidgets.dart';
import 'package:auth/dashboard/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    LoginController LoginControllerRead = context.read<LoginController>();
    LoginController LoginControllerWatch = context.watch<LoginController>();
    return Scaffold(
      body: CustomBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(Logo),
                    CustomTextField(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      hintText: "Email",
                      controller: LoginControllerRead.emailController,
                      // onchange: LoginControllerRead.EmailValidate(
                      //         LoginControllerRead.emailController.text)
                      //     .then((value) {
                      //   value
                      //     ..fold((l) => () => {},
                      //         (r) => null);
                      // }),
                      validator: (p0) =>
                          context.read<LoginController>().EmailValidate(p0),
                    ),
                    LoginControllerWatch.Textfieldchange
                        ? Text(
                            "Email field is not valid",
                            style: TextStyle(color: Colors.red),
                          )
                        : Text(""),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      hintText: "Password",
                      controller: LoginControllerRead.passwordController,
                      obscureText: true,
                      validator: (p0) =>
                          context.read<LoginController>().PasswordValidate(p0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<LoginController>(
                        builder: (context, LoginController, child) {
                      return CustomButton(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        text: LoginController.Loginactivated
                            ? "Loading"
                            : "Login",
                        onPressed: () async {
                          if (loginFormKey.currentState?.validate() ?? false) {
                            final result = await LoginControllerRead.Login();

                            result.fold(
                              (l) =>
                                  ScaffoldService.showErrorSnackbarWithMessage(
                                context: context,
                                message: l.message,
                              ),
                              (r) => context.go("/dashboard"),
                            );
                          }
                        },
                        textColor: Colors.black87,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
