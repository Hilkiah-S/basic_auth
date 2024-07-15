import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final double width;
  final double height;
  final Future<Map<dynamic, dynamic>>? onchange;
  final String? Function(String?) validator;

  CustomTextField({
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.onchange,
    required this.width,
    required this.height,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          if (value != null) {
            onchange;
          }
        },
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final EdgeInsets padding;

  CustomButton({
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF98FB98), // Default light green
    this.textColor = Colors.white,
    this.borderRadius = 20.0,
    this.fontSize = 20.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class CustomAlertBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String contentText;
  final bool isDismissible;
  final VoidCallback onConfirm;

  CustomAlertBox({
    required this.icon,
    required this.iconColor,
    required this.contentText,
    this.isDismissible = true,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => isDismissible,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              contentText,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          // TextButton(
          //   onPressed: onConfirm,
          //   child: Text('Confirm'),
          // ),
          if (isDismissible)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
        ],
      ),
    );
  }
}
