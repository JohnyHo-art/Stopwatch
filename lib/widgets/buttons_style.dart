import 'package:flutter/material.dart';
import 'package:stopwacth_app/widgets/style.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
    required this.iconData,
    required this.color,
    required this.onPressed,
  }) : super(key: key);
  final IconData iconData;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    return InkWell(
      splashColor: Colors.black26,
      borderRadius: BorderRadius.circular(sizeV*10),
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizeV,
          vertical: sizeV,
        ),
        child: Container(
          height: sizeV * 9,
          width: sizeV * 9,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: whiteColor,
            size: sizeV * 5,
          ),
        ),
      ),
    );
  }
}
