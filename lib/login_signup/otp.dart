// ignore_for_file: use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/shared/components/components.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/userData.dart';

// ignore: must_be_immutable
class OtpVerification extends StatelessWidget {
  final EmailOTP myauth;
  final String name;
  final String email;
  final String password;
  final bool? fromEdit;
  OtpVerification(
      {Key? key,
      required this.myauth,
      required this.name,
      required this.email,
      required this.password,
      this.fromEdit})
      : super(key: key);
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
                          (fromEdit ?? false)
                              ? Navigator.pop(context)
                              : User.signUp(
                                      username: name,
                                      email: email,
                                      password: password,
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
