import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants/colors.dart';

class TTextField extends StatelessWidget {
  final String hintText;
  final Icon? suffixIcon;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool showPrefix;
  final bool isPhone;
  final bool isNationalID;
  final bool isPassword;
  final ValueNotifier<bool>? obscureTextNotifier;

  const TTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    required this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
    this.showPrefix = true,
    this.isPhone = false,
    this.isNationalID = false,
    this.isPassword = false,
    this.obscureTextNotifier, // اجعلها اختيارية بدون قيمة افتراضية
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveObscureTextNotifier = obscureTextNotifier ?? ValueNotifier<bool>(true);

    return Container(
      width: 88.w,
      child: ValueListenableBuilder<bool>(
        valueListenable: effectiveObscureTextNotifier,
        builder: (context, obscureText, child) {
          return TextField(
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11.sp,
              fontWeight: isPhone || isNationalID ? FontWeight.bold : FontWeight.normal,
              textBaseline: TextBaseline.alphabetic,
            ),
            controller: controller,
            obscureText: isPassword ? obscureText : false,
            decoration: InputDecoration(
              hintText: hintText,
              hintTextDirection: TextDirection.ltr,
              filled: true,
              fillColor: TColors.white,
              hintStyle: TextStyle(
                fontSize: 9.sp,
                color: TColors.darkGrey,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: TColors.primary, width: 2.0),
                borderRadius: BorderRadius.circular(18.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(18.0),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  effectiveObscureTextNotifier.value = !effectiveObscureTextNotifier.value;
                },
              )
                  : suffixIcon,
              suffixIconColor: TColors.primary,
              prefixIcon: prefixIcon,
              prefixIconColor: TColors.primary,
              errorStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10.sp,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              helperStyle: TextStyle(
                fontFamily: 'Cairo',
              ),
              prefixStyle: TextStyle(
                fontSize: 11.sp,
                color: Colors.black,
                fontFamily: 'Cairo',
              ),
            ),
            keyboardType: keyboardType,
            textDirection: isPhone ? TextDirection.ltr : TextDirection.ltr,
            maxLength: isPhone ? 8 : isNationalID ? 10 : null,
            buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
          );
        },
      ),
    );
  }
}
