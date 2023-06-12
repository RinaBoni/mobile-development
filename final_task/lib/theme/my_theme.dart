import 'package:flutter/material.dart';

class MyTheme {
  // Color palette: https://colorhunt.co/palette/1b243051557e816797d6d5a8
  static const Color colorDark = Color.fromARGB(255, 36, 36, 36);
  static const Color colorPurple = Color.fromARGB(255, 151, 115, 255);
  static const Color colorMediumPurple = Color.fromARGB(255, 208, 108, 255);
  static const Color colorDarkPurple = Color.fromARGB(255, 52, 40, 79);
  static const Color colorGreen = Color.fromARGB(255, 115, 255, 151);
  static const Color colorBrightPurple = Color.fromARGB(255, 240, 231, 255);
  static const Color colorDarkerBrightPurple = Color.fromARGB(255, 224, 206, 255);

  static ButtonStyle buttonStyleUsual1 = ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(MyTheme.colorPurple),
      overlayColor: const MaterialStatePropertyAll(MyTheme.colorGreen),
      minimumSize: const MaterialStatePropertyAll(Size(120, 50)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      textStyle: const MaterialStatePropertyAll(TextStyle(
        color: MyTheme.colorBrightPurple,
      ),

      ));

  static const TextStyle textStyleMainField1 =
      TextStyle(color: colorBrightPurple, fontWeight: FontWeight.bold);

  static InputDecoration getTextFormFieldDecoration1(String inputFieldText) {
    return InputDecoration(
        labelText: 'Enter your $inputFieldText',
        labelStyle: const TextStyle(color: colorPurple),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: colorPurple)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: colorGreen),
      ),
    );
  }

  static Row packageWidgetsAsRow(List<Widget> widgets) {
    return Row(children: widgets);
  }

  static Column packageWidgetsAsColumn(List<Widget> widgets) {
    return Column(children: widgets);
  }

  static TextFormField getTextFormFieldWithValidator(String inputFieldText,
      RegExp validationExpression, InputDecoration decoration) {
    return TextFormField(
      autofillHints: Characters("Input $inputFieldText here..."),
      validator: (value) {
        if (value!.isEmpty) {
          return "Input $inputFieldText";
        }
        if (!MyTheme.validation(value, validationExpression)) {
          return "Invalid $inputFieldText value";
        }
        return null;
      },
      decoration: decoration,
      style: const TextStyle(color: colorGreen),
      textAlignVertical: TextAlignVertical.center,
    );
  }

  static bool validation(String input, RegExp regularExpression) {
    return regularExpression.firstMatch(input) != null;
  }
}
