import 'package:flutter/material.dart';

class CustomTextFormField extends TextFormField {
  CustomTextFormField(
      {super.key,
      required TextEditingController controllerField,
      required String hintText,
      required FormFieldValidator<String> validator,
      required TextInputType keyboardType,
      Function(String)? onChange,
      bool obscureText = false,
      String? labelText,
      TextStyle? hintStyle,
      Icon? prefixIcon,
      Widget? suffixIcon,
      String? errorText,
      TextStyle? errorStyle,
      EdgeInsetsGeometry? contentPadding})
      : super(
          controller: controllerField,
          decoration: InputDecoration(
              contentPadding: contentPadding,
              border: InputBorder.none,
              hintText: hintText,
              labelText: labelText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              errorText: errorText,
              errorStyle: errorStyle),
          onChanged: onChange,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
        );
}
