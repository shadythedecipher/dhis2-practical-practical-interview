import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color? backgroundColor;
  final Color textColor;
  final double? width;
  final double? height;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? borderRadius;
  final Color? borderColor;
  final IconData? iconData;
  final bool showShadow;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.width,
    this.height,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
    this.borderColor,
    this.iconData,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      // Wrap the CupertinoButton with a Container to set width and height
      return SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: 1.0,
            ),
          ),
          child: CupertinoButton(
            onPressed: () => onPressed(),
            padding: const EdgeInsets.all(0),
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            pressedOpacity: showShadow ? 0.7 : 1.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconData != null)
                  Icon(
                    iconData,
                    color: textColor,
                  ),
                SizedBox(width: iconData != null ? 8.0 : 0),
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Return a MaterialButton for Android and other platforms
      return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              side: BorderSide(color: borderColor ?? Colors.transparent),
            ),
            elevation: showShadow ? 5.0 : 0.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  color: textColor,
                ),
              SizedBox(width: iconData != null ? 8.0 : 0),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
