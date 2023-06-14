// ignore_for_file: use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/components.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/userData.dart';

// ignore: must_be_immutable
class OtpVerification extends StatelessWidget {
  final EmailOTP myauth;
  final String? name;
  final String? email;
  final String? password;
  final bool? fromEdit;
  final bool? fromForget;
  OtpVerification({
    Key? key,
    required this.myauth,
    this.name,
    this.email,
    this.password,
    this.fromEdit,
    this.fromForget,
  }) : super(key: key);
  TextEditingController otp1Controller = TextEditingController();

  TextEditingController otp2Controller = TextEditingController();

  TextEditingController otp3Controller = TextEditingController();

  TextEditingController otp4Controller = TextEditingController();

  TextEditingController otp5Controller = TextEditingController();

  TextEditingController otp6Controller = TextEditingController();

  String otpController = "123456";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
          listener: (_, s) {},
          builder: (_, s) {
            CubitManager signUpLoginChangeable = CubitManager.get(_);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Icon(Icons.dialpad_rounded, size: 50),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Enter Code",
                      style: TextStyle(fontSize: 40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Otp(
                          otpController: otp1Controller,
                        ),
                        Otp(
                          otpController: otp2Controller,
                        ),
                        Otp(
                          otpController: otp3Controller,
                        ),
                        Otp(
                          otpController: otp4Controller,
                        ),
                        Otp(
                          otpController: otp5Controller,
                        ),
                        Otp(
                          otpController: otp6Controller,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      onPressed: () async {
                        signUpLoginChangeable.myAuth.setConfig(
                            appEmail: 'omarHishamho@gmail.com',
                            appName: 'Email Verification',
                            userEmail: User.currentUser!.email,
                            otpLength: 6,
                            otpType: OTPType.digitsOnly);

                        print(signUpLoginChangeable.myAuth.toString());
                        if (await signUpLoginChangeable.myAuth.sendOTP() ==
                            true) {
                          toastSuccess(context: context, text: "code resent");
                        } else {
                          toastError(
                              context: context, text: "Verification error!");
                        }
                      },
                      child: subTitleText(
                          text: "resend pin", color: TextColors.blackText),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (await myauth.verifyOTP(
                                otp: otp1Controller.text +
                                    otp2Controller.text +
                                    otp3Controller.text +
                                    otp4Controller.text +
                                    otp5Controller.text +
                                    otp6Controller.text) ==
                            true) {
                          if (fromEdit ?? false) {
                            signUpLoginChangeable
                                .editProfile(
                                    context: context,
                                    username: signUpLoginChangeable
                                        .userController.text,
                                    email: signUpLoginChangeable
                                        .emailController.text,
                                    password: signUpLoginChangeable
                                        .passController.text)
                                .then((value) => Navigator.pop(context));
                          } else if (fromForget ?? false) {
                            User.forgetPassword(context: context, email: email!)
                                .then((value) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          BackgroundColors.dialogBG,
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            titleText(text: 'Change password'),
                                            //password
                                            defaultTextFormField(
                                                controller:
                                                    signUpLoginChangeable
                                                        .passController,
                                                hint: "Password",
                                                suffix: true,
                                                isPassword:
                                                    signUpLoginChangeable
                                                        .isPassword,
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      value.length < 6) {
                                                    return 'Password must be at least 6 characters';
                                                  }
                                                  return null;
                                                },
                                                suffixPressed: () {
                                                  signUpLoginChangeable
                                                      .isPasswordCheck();
                                                }),
                                            const SizedBox(height: 20),
                                            //confirm password
                                            defaultTextFormField(
                                                controller:
                                                    signUpLoginChangeable
                                                        .confirmPassController,
                                                hint: "Confirm Password",
                                                isPassword:
                                                    signUpLoginChangeable
                                                        .isConfirmPassword,
                                                suffix: true,
                                                validator: (value) {
                                                  if (signUpLoginChangeable
                                                          .passController
                                                          .text !=
                                                      signUpLoginChangeable
                                                          .confirmPassController
                                                          .text) {
                                                    print(
                                                        'pass cont = ${signUpLoginChangeable.passController.text}');
                                                    print(
                                                        'confirm pass cont = ${signUpLoginChangeable.confirmPassController.text}');
                                                    return "Passwords doesn't match";
                                                  }
                                                  return null;
                                                },
                                                suffixPressed: () {
                                                  signUpLoginChangeable
                                                      .isConfirmPasswordCheck();
                                                }),
                                          ]),
                                      actions: [
                                        DefaultButton(
                                            function: () {
                                              User.resetPassword(
                                                      context: context,
                                                      tempToken: User.tempToken,
                                                      password:
                                                          signUpLoginChangeable
                                                              .passController
                                                              .text)
                                                  .then((value) {
                                                toastSuccess(
                                                    context: context,
                                                    text: 'password changed');
                                                Navigator.pop(context);
                                              }).catchError((e) {
                                                print(e);
                                                toastError(
                                                    context: context, text: e);
                                              });
                                            },
                                            text: 'change password')
                                      ],
                                    );
                                  });
                            }).catchError((e) {
                              toastError(context: context, text: e);
                            });
                          } else {
                            User.signUp(
                                    username: name.toString(),
                                    email: email.toString(),
                                    password: password.toString(),
                                    context: context)
                                .then((value) {
                              Navigator.pop(context);
                              signUpLoginChangeable.pushToLogin();
                              toastSuccess(
                                  context: context,
                                  text: "Verification Complete");
                            }).catchError((e) {
                              throw e;
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Invalid OTP"),
                          ));
                        }
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}
