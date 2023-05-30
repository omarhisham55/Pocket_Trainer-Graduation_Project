import 'package:final_packet_trainer/data/userData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../navigation/cubit/cubit.dart';
import '../../navigation/cubit/states.dart';
import '../../navigation/navigation.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

//Done
class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, state) {},
        builder: (_, state) {
          CubitManager signUpLoginChangeable = CubitManager.get(_);
          List<Widget> loginSignUpScreens = [
            //SignUp
            Form(
              key: signUpLoginChangeable.signupKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SignUp title
                  Text(signUpLoginChangeable.title[1],
                      style: const TextStyle(
                          color: TextColors.whiteText,
                          fontSize: 70,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 60),
                  //username
                  defaultTextFormField(
                      controller: signUpLoginChangeable.userController,
                      hint: "Username",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Valid Username";
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  //email
                  defaultTextFormField(
                      controller: signUpLoginChangeable.emailController,
                      hint: "Email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Valid email";
                        } else if (!value.contains("@")) {
                          return "Email invalid missing @";
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  //password
                  defaultTextFormField(
                      controller: signUpLoginChangeable.passController,
                      hint: "Password",
                      suffix: true,
                      isPassword: signUpLoginChangeable.isPassword,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      suffixPressed: () {
                        signUpLoginChangeable.isPasswordCheck();
                      }),
                  const SizedBox(height: 20),
                  //confirm password
                  defaultTextFormField(
                      controller: signUpLoginChangeable.confirmPassController,
                      hint: "Confirm Password",
                      isPassword: signUpLoginChangeable.isConfirmPassword,
                      suffix: true,
                      validator: (value) {
                        if (signUpLoginChangeable.passController.text != signUpLoginChangeable.confirmPassController.text) {
                          print('pass cont = ${signUpLoginChangeable.passController.text}');
                          print('confirm pass cont = ${signUpLoginChangeable.confirmPassController.text}');
                          return "Passwords doesn't match";
                        }
                        return null;
                      },
                      suffixPressed: () {
                        signUpLoginChangeable.isConfirmPasswordCheck();
                      }),
                  const SizedBox(height: 20),
                  // //select gender
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      paragraphText(text: "Male"),
                      Radio(
                        value: 1,
                        groupValue: signUpLoginChangeable.signUpGroupRadio,
                        activeColor: BackgroundColors.button,
                        onChanged: (value) =>
                            signUpLoginChangeable.selectGender(value),
                        // onChanged: (value) {
                        //   setState(() {
                        //     radioSelected = value;
                        //     radioVal = 'male';
                        //   });
                        // },
                      ),
                      const SizedBox(width: 30),
                      paragraphText(text: "Female"),
                      Radio(
                        value: 2,
                        groupValue: signUpLoginChangeable.signUpGroupRadio,
                        activeColor: BackgroundColors.button,
                        onChanged: (value) =>
                            signUpLoginChangeable.selectGender(value),
                        // onChanged: (value) {
                        //   setState(() {
                        //     radioSelected = value;
                        //     radioVal = 'female';
                        //   });
                        // },
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  //add photo
                  Row(
                    children: [
                      paragraphText(
                          text: "add profile picture"),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.upload_file, color: BackgroundColors.whiteBG,)
                      ),
                      const Spacer(),
                      paragraphText(text: "optional", color: Colors.grey)
                    ],
                  ),
                  // const Spacer(),
                  const SizedBox(height: 60),
                  //confirm button
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DefaultButton(
                        function: () {
                          if (signUpLoginChangeable.signupKey.currentState!.validate()) {
                            User.signUp(username: signUpLoginChangeable.userController.text, email: signUpLoginChangeable.emailController.text, password: signUpLoginChangeable.passController.text, context: context).then((value) {
                              signUpLoginChangeable.pushToLogin();
                            }).catchError((e){
                              throw e;
                            });
                             signUpLoginChangeable.signupKey.currentState!.save();
                            // Perform action (e.g. send data to a server)
                          }
                        },
                        text: "Confirm",
                      ),
                      //switch signup to login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          paragraphText(text: 'Already have an account ?'),
                          TextButton(
                              onPressed: () {
                                signUpLoginChangeable.pushToLogin();
                                // Navigator.of(context).push(SlideToNav(page: const Login()));
                              },
                              child: paragraphText(
                                  text: "Login", color: TextColors.dataText))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            //Login
            Form(
                key: signUpLoginChangeable.loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Login title
                    Text(signUpLoginChangeable.title[0],
                        style: const TextStyle(
                            color: TextColors.whiteText,
                            fontSize: 70,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    const SizedBox(height: 60),
                    defaultTextFormField(
                        controller: signUpLoginChangeable.emailController,
                        isPassword: false,
                        hint: "Email",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Valid Email";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 20),
                    //password
                    defaultTextFormField(
                      controller: signUpLoginChangeable.passController,
                      hint: "Password",
                      isPassword: signUpLoginChangeable.isPassword,
                      suffix: true,
                      suffixPressed: () {
                        signUpLoginChangeable.isPasswordCheck();
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    // const Spacer(),
                    const SizedBox(height: 240),
                    //confirm button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DefaultButton(
                          function: () {
                            if (signUpLoginChangeable.loginKey.currentState!.validate()) {
                              User.login(username: signUpLoginChangeable.emailController.text, password: signUpLoginChangeable.passController.text, context: context).then((value){
                                User.getProfile().then((value) {
                                  homeNavigator(context, const Navigation());
                                  toastSuccess(context: context, text: "Login successful welcome ${User.currentUser!.name}");
                                }).catchError((e){
                                  toastError(context: context, text: "couldn't get profile $e");
                                });
                              }).catchError((e) {
                                throw e;
                              });
                              // Navigator.of(context).push(HomeAnimation(page: Navigation()));
                              signUpLoginChangeable.loginKey.currentState!.save();
                              // Perform action (e.g. send data to a server)
                            }
                          },
                          text: "Confirm",
                        ),
                        //switch login to signup
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            paragraphText(text: "Don't have an account ?"),
                            TextButton(
                                onPressed: () {
                                  signUpLoginChangeable.pushToLogin();
                                },
                                child: paragraphText(
                                    text: "Sign up",
                                    color: TextColors.dataText
                                )
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ];
          return SafeArea(
            child: WillPopScope(
              onWillPop: () async{
                return false;
              },
              child: Scaffold(
                backgroundColor: BackgroundColors.background,
                resizeToAvoidBottomInset: false,
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 60.0),
                  child: Center(
                    child: AnimatedCrossFade(
                        firstChild: loginSignUpScreens[1],
                        secondChild: loginSignUpScreens[0],
                        crossFadeState: signUpLoginChangeable.signup
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 1000)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
