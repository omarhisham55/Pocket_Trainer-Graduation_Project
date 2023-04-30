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
  Login({super.key});

  List<String> title = ["Login", "Sign Up"];
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
                  Text(title[1],
                      style: const TextStyle(
                          color: TextColors.whiteText,
                          fontSize: 70,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 60),
                  //username
                  defaultTextFormField(
                      controller: userController,
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
                      controller: emailController,
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
                      controller: passController,
                      hint: "Password",
                      suffix: true,
                      isPassword: signUpLoginChangeable.isPassword,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      suffixPressed: () {
                        signUpLoginChangeable.isPasswordCheck();
                      }),
                  const SizedBox(height: 20),
                  //confirm password
                  defaultTextFormField(
                      controller: confirmPassController,
                      hint: "Confirm Password",
                      isPassword: signUpLoginChangeable.isConfirmPassword,
                      suffix: true,
                      validator: (value) {
                        if (passController != confirmPassController) {
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
                          if (signUpLoginChangeable.signupKey.currentState!
                              .validate()) {
                            // Navigator.of(context).push(HomeAnimation(page: Navigation()));
                            homeNavigator(context, const Navigation());
                            signUpLoginChangeable.signupKey.currentState!
                                .save();
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
                    Text(title[0],
                        style: const TextStyle(
                            color: TextColors.whiteText,
                            fontSize: 70,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    const SizedBox(height: 60),
                    defaultTextFormField(
                        controller: userController,
                        isPassword: false,
                        hint: "Username",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Valid Username";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 20),
                    //password
                    defaultTextFormField(
                      controller: passController,
                      hint: "Password",
                      isPassword: signUpLoginChangeable.isPassword,
                      suffix: true,
                      suffixPressed: () {
                        signUpLoginChangeable.isPasswordCheck();
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Password must be at least 8 characters';
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
                              login(username: userController.text, password: passController.text).then((value){
                                print("success");
                                print(value);
                              }).catchError((e){
                                print("post data fail $e");
                              });
                              // Navigator.of(context).push(HomeAnimation(page: Navigation()));
                              // homeNavigator(context, const Navigation());
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
          );
        },
      ),
    );
  }
}
