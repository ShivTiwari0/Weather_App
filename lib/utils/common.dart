import 'package:flutter/material.dart';

height(BuildContext context, double size) {
  return MediaQuery.of(context).size.height * size;
}

width(BuildContext context, double size) {
  return MediaQuery.of(context).size.width * size;
}

Widget custombutton(
    BuildContext context, String title, void Function()? onTap, String? image) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: width(context, 0.89),
      height: height(context, 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(image: AssetImage(image!), fit: BoxFit.fitWidth),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
