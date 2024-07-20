// import 'package:bike_gps/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import 'my_text_widget.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.marginBottom = 12,
    this.isObSecure = false,
    this.maxLength,
    this.maxLines = 1,
    this.isEnabled = true,
    this.labelText,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.haveSuffix = false,
    this.onChanged,
    this.suffixIconSize,
    this.onSuffixTap,
    this.focusBorderColor,
    this.radius,
    this.inputFormatters,
    this.fillColor,
    this.filled,
    this.contentPadding,
    this.underLineBorderColor,
    this.readonly = false,
  }) : super(key: key);
  String? hintText, labelText, suffixIcon;
  double? marginBottom, suffixIconSize, radius;
  bool? isObSecure, isEnabled, haveSuffix, readonly;
  int? maxLength, maxLines;
  VoidCallback? onSuffixTap;
  Color? focusBorderColor;
  Color? fillColor;
  Color? underLineBorderColor;
  bool? filled;

  TextInputType? keyboardType;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;
  EdgeInsetsGeometry? contentPadding;

  List<TextInputFormatter>? inputFormatters;

  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: marginBottom!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (labelText != null)
            MyText(
              text: labelText!,
              size: 14,
              weight: FontWeight.w500,
              color: kTextColor,
              paddingBottom: 3,
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 24),
              boxShadow: [
                BoxShadow(
                  color: kBlackColor.withOpacity(0.03),
                  blurRadius: 47,
                  // ignore: prefer_const_constructors
                  offset: Offset(-2, 6),
                ),
              ],
            ),
            child: TextFormField(
              
              readOnly: readonly ?? false,
              cursorColor: kDarkGreyColor,
              onTap: onTap,
              enabled: isEnabled,
              inputFormatters: inputFormatters,
              validator: validator,
              maxLines: maxLines,
              maxLength: maxLength,
              onChanged: onChanged,
              obscureText: isObSecure!,
              obscuringCharacter: '*',
              controller: controller,
              textInputAction: TextInputAction.next,
              textAlignVertical:
                  suffixIcon != null ? TextAlignVertical.center : null,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontSize: 14,
                color: kDarkGreyColor,
                fontWeight: FontWeight.w500,
                // fontFamily: AppFonts.POPPINS,
              ),
              decoration: InputDecoration(
                
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(
                      vertical: maxLines! > 1 ? 15 : 0,
                    ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: kHintColor,
                  // fontFamily: AppFonts.POPPINS,
                ),
                suffixIconConstraints: BoxConstraints(
                  minWidth: haveSuffix! ? 40 : 16,
                ),
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (haveSuffix!)
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: GestureDetector(
                          onTap: onSuffixTap,
                          child: Image.asset(
                            suffixIcon!,
                            height: suffixIconSize ?? 20,
                          ),
                        ),
                      ),
                  ],
                ),
                fillColor: fillColor ?? kPrimaryColor.withOpacity(0.05),
                filled: filled ?? false,
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: underLineBorderColor ?? kGreyColor3),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: underLineBorderColor ?? kGreyColor3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
