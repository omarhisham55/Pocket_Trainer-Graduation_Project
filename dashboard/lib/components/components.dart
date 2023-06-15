// ignore_for_file: must_be_immutable

import 'package:circle_button/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'colors.dart';
import 'constants.dart';

PreferredSizeWidget defaultAppBar(
        {required BuildContext context,
        required String title,
        List<Widget>? actions}) =>
    AppBar(
      backgroundColor: BackgroundColors.dialogBG,
      title: titleText(text: title),
      actions: actions,
    );

PreferredSizeWidget changeableAppBar(
        {context,
        required String title,
        required bool isRequirementsTaken,
        Widget? replace,
        PreferredSizeWidget? bottom}) =>
    AppBar(
      backgroundColor: BackgroundColors.dialogBG,
      title: titleText(text: title),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: replace,
        )
      ],
      bottom: bottom,
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required String hint,
  bool? isPassword = false,
  bool? suffix = false,
  String? Function(String?)? validator,
  Function(String)? onSubmit,
  Function(String)? onChanged,
  Function()? suffixPressed,
  InputBorder? border,
  InputBorder? focusedBorder,
  TextInputType? textInputType,
  Color? hintTexColor,
  Color? textStyle,
  TextAlign? textAlign,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: (hint == "Username")
                ? TextInputType.text
                : (hint == "Password" || hint == "ConfirmPassword")
                    ? TextInputType.visiblePassword
                    : (hint == "Email")
                        ? TextInputType.emailAddress
                        : textInputType,
            style: TextStyle(color: textStyle ?? TextColors.whiteText),
            textAlign: textAlign ?? TextAlign.center,
            obscureText: isPassword!,
            onChanged: onChanged,
            onFieldSubmitted: onSubmit,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: hintTexColor ?? TextColors.whiteText,
              ),
              focusedBorder: focusedBorder ??
                  const UnderlineInputBorder(
                      borderSide: BorderSide(color: BackgroundColors.whiteBG)),
              enabledBorder: border ??
                  const UnderlineInputBorder(
                      borderSide: BorderSide(color: BackgroundColors.whiteBG)),
            ),
          ),
          Visibility(
              visible: suffix! ? true : false,
              child: IconButton(
                  onPressed: suffixPressed,
                  icon: isPassword
                      ? const Icon(Icons.remove_red_eye_outlined,
                          color: BackgroundColors.whiteBG)
                      : const Icon(Icons.visibility_off_outlined,
                          color: BackgroundColors.whiteBG)))
        ],
      ),
    );

Widget titleText(
        {required String text,
        double? size = 25,
        FontWeight? fontWeight = FontWeight.bold,
        Color? color = TextColors.whiteText,
        TextAlign? textAlign = TextAlign.center,
        int? maxLines = 1,
        TextOverflow? textOverflow}) =>
    Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
      overflow: textOverflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );

Widget subTitleText(
        {required String text,
        double? size = 20,
        double? width,
        FontWeight? fontWeight = FontWeight.w500,
        Color? color = TextColors.whiteText,
        TextAlign? textAlign = TextAlign.center,
        int? maxLines = 2,
        TextOverflow? textOverflow}) =>
    SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
        ),
        maxLines: maxLines,
        overflow: textOverflow,
      ),
    );

Widget paragraphText(
        {required String text,
        double? size = 15.0,
        FontWeight? fontWeight = FontWeight.w400,
        Color? color = TextColors.whiteText,
        TextAlign? textAlign = TextAlign.center,
        int? maxLines = 2,
        TextOverflow? textOverflow}) =>
    Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
      maxLines: maxLines,
      overflow: textOverflow,
    );

Widget defaultDropDownMenu({
  required List<String> content,
  required String hintValue,
  Function(String?)? function,
  Color? textColor,
  Color? backgroundColor,
  Color? hintColor,
}) =>
    DropdownButton<String>(
        dropdownColor: backgroundColor ?? BackgroundColors.whiteBG,
        underline: Container(),
        isExpanded: true,
        hint: subTitleText(
            text: hintValue,
            color: hintColor ?? TextColors.whiteText,
            fontWeight: FontWeight.w500),
        items: content.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: subTitleText(
                  text: value, color: textColor ?? TextColors.blackText),
            ),
          );
        }).toList(),
        onChanged: function);

Widget defaultInkWell({
  required final BuildContext context,
  required final String image,
  required final String title,
  required final List<Widget> subtitle,
  required final Widget child,
  required final Function() function,
  Function()? removeFunction,
  Color? iconColor,
  bool? recommended = false,
  bool? remove = false,
}) =>
    Stack(
      alignment: Alignment.topRight,
      children: [
        InkWell(
          onTap: function,
          child: Container(
            decoration: BoxDecoration(
                color: BackgroundColors.inkWellBG,
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 120,
                      child: Image.network(image, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 220,
                            child: subTitleText(
                                text: title,
                                textAlign: TextAlign.left,
                                textOverflow: TextOverflow.ellipsis,
                                maxLines: 1),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: width(context, .63),
                            child: Wrap(
                              children: subtitle,
                            ),
                          ),
                          const SizedBox(height: 8),
                          child
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Visibility(
                      visible: (recommended!) ? true : false,
                      child: paragraphText(
                          text: "Recommended",
                          color: TextColors.recommendedText)),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Visibility(
              visible: (remove ?? false) ? true : false,
              child: CircleButton(
                onTap: removeFunction ?? () {},
                backgroundColor: Colors.red,
                width: 30,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Icon(Icons.minimize_sharp),
                ),
              )),
        ),
      ],
    );

Widget defaultDialog({
  required BuildContext context,
  required Widget title,
  required Widget body,
  required bool quickExit,
  required bool setBackIcon,
  required bool setNextIcon,
  required bool cancelButton,
  Function()? prevDialog,
  Function()? nextDialog,
}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Dialog(
          backgroundColor: BackgroundColors.dialogBG,
          child: Column(
            children: [
              //title
              Row(
                children: [
                  //back button
                  Visibility(
                    visible: (setBackIcon) ? true : false,
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: BackgroundColors.whiteBG,
                        ),
                        onPressed: prevDialog),
                  ),
                  //title
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SizedBox(
                        width: (setBackIcon)
                            ? width(context, .66)
                            : width(context, .78),
                        child: title,
                      )),
                ],
              ),
              //content required
              body,
              //next button or confirm
              Visibility(
                visible: (setNextIcon) ? true : false,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                      onTap: nextDialog,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                                color: TextColors.whiteText,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: TextColors.whiteText,
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: (cancelButton) ? true : false,
            child: DefaultButton(
              function: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.red,
              text: "Cancel",
            ))
      ],
    );

Widget dialogButton(
        {required String buttonTitle,
        required Function() function,
        double? borderRadius,
        double? borderWidth,
        Color? borderColor,
        double? elevation,
        String? buttonContent}) =>
    MaterialButton(
      color: Colors.transparent,
      onPressed: function,
      elevation: elevation ?? 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          side: BorderSide(
              width: borderWidth ?? 0,
              color: borderColor ?? BackgroundColors.dialogBG)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            subTitleText(text: buttonTitle),
            const SizedBox(height: 10),
            paragraphText(text: buttonContent ?? "", textAlign: TextAlign.start)
          ],
        ),
      ),
    );

class DefaultButton extends StatefulWidget {
  final Function() function;
  final String text;
  Color? textColor;
  double? borderRadius;
  double? width;
  double? height;
  Color? backgroundColor;
  double? borderWidth;
  Color? borderColor;
  bool? bigButton;

  DefaultButton(
      {super.key,
      required this.function,
      required this.text,
      this.textColor,
      this.borderRadius,
      this.height,
      this.width,
      this.backgroundColor,
      this.borderWidth,
      this.borderColor,
      this.bigButton});

  @override
  State<DefaultButton> createState() => _ButtonState();
}

class _ButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    //if values = null set default value
    widget.height ??= MediaQuery.of(context).size.height * .06;
    widget.width ??= MediaQuery.of(context).size.width * .4;
    widget.backgroundColor ??= BackgroundColors.button;
    widget.borderRadius ??= 0;
    widget.borderWidth ??= 0;
    widget.borderColor ??= Colors.transparent;
    widget.textColor ??= TextColors.whiteText;
    widget.bigButton ??= true;
    return SizedBox(
        width: widget.width,
        child: MaterialButton(
            height: widget.height,
            color: widget.backgroundColor,
            onPressed: widget.function,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                side: BorderSide(
                    width: widget.borderWidth!, color: widget.borderColor!)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: (widget.bigButton!)
                  ? subTitleText(text: widget.text, color: widget.textColor)
                  : paragraphText(text: widget.text, color: widget.textColor),
            )));
  }
}

Widget exerciseCard(
        {required Function() function,
        required String image,
        required String title,
        double? borderRadius,
        double? width,
        double? imageHeight,
        bool? addCardButton,
        Function()? addFunction,
        Color? titleColor}) =>
    Stack(
      alignment: Alignment.topRight,
      children: [
        InkWell(
          onTap: function,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 30),
              color: BackgroundColors.inkWellBG,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      image,
                      height: imageHeight ?? 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  paragraphText(
                      text: title, color: titleColor ?? TextColors.whiteText)
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: (addCardButton ?? false) ? true : false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleButton(
              onTap: addFunction ?? () {},
              backgroundColor: BackgroundColors.button,
              width: 30,
              child: const Icon(Icons.add),
            ),
          ),
        )
      ],
    );

void toastError({required BuildContext context, required String text}) =>
    MotionToast.error(
      title: paragraphText(text: "Error!", color: TextColors.blackText),
      description: paragraphText(text: text, color: TextColors.blackText),
      position: MotionToastPosition.top,
      barrierColor: Colors.black.withOpacity(0.3),
      width: 300,
      height: 80,
      dismissable: false,
    ).show(context);

void toastSuccess(
        {required BuildContext context, required String text, int? duration}) =>
    MotionToast.success(
      title: paragraphText(text: "Success!"),
      description: paragraphText(text: text),
      layoutOrientation: ToastOrientation.rtl,
      animationType: AnimationType.fromRight,
      position: MotionToastPosition.top,
      dismissable: true,
      toastDuration: Duration(seconds: duration ?? 2),
    ).show(context);

void toastWarning({required BuildContext context, required String text}) =>
    MotionToast.warning(
      title: paragraphText(text: "Warning!", color: TextColors.blackText),
      description: paragraphText(text: text, color: TextColors.blackText),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
    ).show(context);

void toastDelete({required BuildContext context, required String text}) =>
    MotionToast.delete(
      title: paragraphText(text: "Deleted successfully!"),
      description: paragraphText(text: text),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
    ).show(context);

void toastInfo({required BuildContext context, required String text}) =>
    MotionToast.info(
      title: paragraphText(text: "Success!"),
      description: paragraphText(text: text),
      position: MotionToastPosition.center,
      animationType: AnimationType.fromRight,
      dismissable: true,
    ).show(context);

void showSnackBar({required context, required text, color}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: subTitleText(text: text),
      duration: const Duration(seconds: 2),
      backgroundColor: color ?? Colors.grey[700],
    ));


    