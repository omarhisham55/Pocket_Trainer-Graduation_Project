// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:final_packet_trainer/data/nutrition_dialog_data.dart';
import 'package:final_packet_trainer/data/userData.dart';
import 'package:final_packet_trainer/main.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:final_packet_trainer/pages/gym/gymRecommendedPlan.dart';
import 'package:final_packet_trainer/shared/network/local/shared.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/gym_dialog_data.dart';
import '../../login_signup/login_signup.dart';
import 'package:final_packet_trainer/pages/profile/premiumPlans.dart';
import 'package:final_packet_trainer/shared/components/constants.dart';
import 'package:final_packet_trainer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login_signup/otp.dart';
import '../../navigation/cubit/cubit.dart';
import '../../shared/components/components.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CubitManager(),
        child: BlocConsumer<CubitManager, MainStateManager>(
            listener: (_, s) {},
            builder: (_, s) {
              List? baseImage = jsonDecode(User.currentUser!.urlPhotoData!);
              Uint8List? bytes = (baseImage != null)
                  ? Uint8List.fromList(baseImage.cast<int>())
                  : null;
              Random random = Random();
              bool isValid = false;
              CubitManager userData = CubitManager.get(_);
              GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
              return Scaffold(
                  key: scaffoldKey,
                  resizeToAvoidBottomInset: true,
                  backgroundColor: BackgroundColors.background,
                  appBar: notificationAppBar(context, "Profile"),
                  body: FutureBuilder(
                      future: userData.getProfile(context),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          var user = snapshot.data!;
                          return FutureBuilder(
                              future: getList(),
                              builder: (_, snapReqs) {
                                if (snapReqs.hasData) {
                                  return SafeArea(
                                    child: Column(children: [
                                      //heading section
                                      Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: BackgroundColors.dialogBG,
                                            borderRadius: BorderRadius.vertical(
                                                bottom: Radius.circular(30))),
                                        child: SizedBox(
                                            width: width(context, 1),
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      40.0),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor: Color
                                                              .fromRGBO(
                                                                  random
                                                                      .nextInt(
                                                                          256),
                                                                  random
                                                                      .nextInt(
                                                                          256),
                                                                  random
                                                                      .nextInt(
                                                                          256),
                                                                  1.0),
                                                          child: (bytes == null)
                                                              ? titleText(
                                                                  text: User
                                                                      .currentUser!
                                                                      .name![0]
                                                                      .toUpperCase(),
                                                                  size: 70.0)
                                                              : ClipOval(
                                                                  child: Image.memory(
                                                                      bytes,
                                                                      fit: BoxFit
                                                                          .cover)),
                                                          // child: Image.memory(bytes),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        titleText(
                                                            text:
                                                                "${user['name'].toString()[0].toUpperCase()}${user['name'].toString().substring(1)}"),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            paragraphText(
                                                                text:
                                                                    "Height: ${snapReqs.data![4][0]}"),
                                                            paragraphText(
                                                                text:
                                                                    "Width: ${snapReqs.data![4][1]}"),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    right: 10.0,
                                                    top: 5.0,
                                                    child: Column(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              scaffoldKey
                                                                  .currentState!
                                                                  .showBottomSheet(
                                                                      (context) {
                                                                return Container(
                                                                  color: BackgroundColors
                                                                      .background,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        20.0),
                                                                    child: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          //username
                                                                          defaultTextFormField(
                                                                              controller: userData.userController,
                                                                              hint: "Username",
                                                                              validator: (value) {
                                                                                if (value!.isEmpty) {
                                                                                  return "Enter Valid Username";
                                                                                }
                                                                                return null;
                                                                              },
                                                                              border: const OutlineInputBorder(borderSide: BorderSide(color: BackgroundColors.whiteBG))),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          //email
                                                                          defaultTextFormField(
                                                                              controller: userData.emailController,
                                                                              hint: "Email",
                                                                              validator: (value) {
                                                                                isValid = EmailValidator.validate(userData.emailController.text);
                                                                                if (value!.isEmpty || !isValid) {
                                                                                  return "Enter Valid email";
                                                                                } else if (!value.contains("@")) {
                                                                                  return "Email invalid missing @";
                                                                                }
                                                                                return null;
                                                                              },
                                                                              border: const OutlineInputBorder(borderSide: BorderSide(color: BackgroundColors.whiteBG))),
                                                                          //password
                                                                          defaultTextFormField(
                                                                              controller: userData.passController,
                                                                              hint: "Password",
                                                                              suffix: true,
                                                                              isPassword: userData.isPassword,
                                                                              validator: (value) {
                                                                                if (value!.isEmpty || value.length < 6) {
                                                                                  return 'Password must be at least 6 characters';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              border: const OutlineInputBorder(borderSide: BorderSide(color: BackgroundColors.whiteBG)),
                                                                              suffixPressed: () {
                                                                                userData.isPasswordCheck();
                                                                              }),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          //confirm password
                                                                          defaultTextFormField(
                                                                              controller: userData.confirmPassController,
                                                                              hint: "Confirm Password",
                                                                              isPassword: userData.isConfirmPassword,
                                                                              border: const OutlineInputBorder(borderSide: BorderSide(color: BackgroundColors.whiteBG)),
                                                                              suffix: true,
                                                                              validator: (value) {
                                                                                if (userData.passController.text != userData.confirmPassController.text) {
                                                                                  print('pass cont = ${userData.passController.text}');
                                                                                  print('confirm pass cont = ${userData.confirmPassController.text}');
                                                                                  return "Passwords doesn't match";
                                                                                }
                                                                                return null;
                                                                              },
                                                                              suffixPressed: () {
                                                                                userData.isConfirmPasswordCheck();
                                                                              }),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(20.0),
                                                                            child:
                                                                                DefaultButton(
                                                                              function: () async {
                                                                                print(User.currentUser!.email);
                                                                                userData.myAuth.setConfig(appEmail: 'omarHishamho@gmail.com', appName: 'Email Verification Poket Trainer', userEmail: User.currentUser!.email, otpLength: 6, otpType: OTPType.digitsOnly);
                                                                                if (await userData.myAuth.sendOTP() == true) {
                                                                                  pageNavigator(context, OtpVerification(myauth: userData.myAuth, email: userData.emailController.text, name: userData.userController.text, password: userData.passController.text, fromEdit: true));
                                                                                  toastInfo(context: context, text: "Email verification pending");
                                                                                } else {
                                                                                  toastError(context: context, text: "Verification error!");
                                                                                }
                                                                              },
                                                                              text: "Save changes",
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                );
                                                              });
                                                            },
                                                            icon: const Icon(
                                                              FontAwesomeIcons
                                                                  .edit,
                                                              color:
                                                                  BackgroundColors
                                                                      .whiteBG,
                                                            )),
                                                        IconButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    backgroundColor:
                                                                        BackgroundColors
                                                                            .dialogBG,
                                                                    title: subTitleText(
                                                                        text:
                                                                            "Are you sure you want to delete your account?"),
                                                                    actions: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10.0),
                                                                            child:
                                                                                DefaultButton(
                                                                              function: () {
                                                                                User.deleteProfile(context).then((value) {
                                                                                  Navigator.pop(context);
                                                                                  pageNavigator(context, const Login());
                                                                                });
                                                                              },
                                                                              text: "Yes",
                                                                              backgroundColor: Colors.red,
                                                                              width: width(context, .3),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10.0),
                                                                            child:
                                                                                DefaultButton(
                                                                              function: () {},
                                                                              text: "No",
                                                                              backgroundColor: BackgroundColors.button,
                                                                              width: width(context, .3),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              FontAwesomeIcons
                                                                  .trash,
                                                              color:
                                                                  BackgroundColors
                                                                      .whiteBG,
                                                            )),
                                                      ],
                                                    )),
                                              ],
                                            )),
                                      ),
                                      const SizedBox(height: 10),
                                      //current program button
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient:
                                                BackgroundColors.blueGradient),
                                        child: DefaultButton(
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          backgroundColor: Colors.transparent,
                                          function: () {
                                            pageNavigator(
                                                context,
                                                const GymRecommendedPlan(
                                                  fromProfile: true,
                                                ));
                                          },
                                          borderRadius: 30,
                                          text: "Current Program",
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      //premium plans button
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: BackgroundColors
                                                .purpleGradient),
                                        child: DefaultButton(
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          backgroundColor: Colors.transparent,
                                          function: () {
                                            noNavNavigator(
                                                context, PremiumPlans());
                                          },
                                          borderRadius: 30,
                                          text: "Premium Plans",
                                        ),
                                      ),
                                      const Spacer(),
                                      DefaultButton(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        backgroundColor:
                                            BackgroundColors.dialogBG,
                                        function: () {},
                                        text: "Contact us",
                                      ),
                                      DefaultButton(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        backgroundColor:
                                            BackgroundColors.dialogBG,
                                        function: () {},
                                        text: "Terms & Conditions",
                                      ),
                                      DefaultButton(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          backgroundColor:
                                              BackgroundColors.dialogBG,
                                          function: () {},
                                          text: "Privacy Policy"),
                                      DefaultButton(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        backgroundColor:
                                            BackgroundColors.dialogBG,
                                        function: () {
                                          User.token = null.toString();
                                          isDietTaken = false;
                                          isExerciseTaken = false;
                                          noNavNavigator(
                                              context, const Login());
                                        },
                                        text: "Logout",
                                      )
                                    ]),
                                  );
                                } else if (snapReqs.hasError) {
                                  return Center(
                                      child: titleText(
                                          text:
                                              "Error fetching data ${snapshot.error}",
                                          color: TextColors.blackText));
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                              child: titleText(
                                  text: "Error fetching data ${snapshot.error}",
                                  color: TextColors.blackText));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }));
            }));
  }
}
