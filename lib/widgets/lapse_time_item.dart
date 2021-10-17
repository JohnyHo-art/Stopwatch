import 'package:flutter/material.dart';
import 'package:stopwacth_app/widgets/style.dart';

class LapseTimeItem extends StatelessWidget {
  const LapseTimeItem({
    Key? key,
    required this.order,
    required this.hour,
    required this.minute,
    required this.second,
  }) : super(key: key);
  final int order;
  final int hour;
  final int minute;
  final int second;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;
    double sizeH = SizeConfig.blockSizeH!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Lapse $order',
              style: TextStyle(
                fontSize: sizeV * 4,
                color: accentColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: sizeH*10),
            Text(
              '$hour : $minute : $second',
              style: TextStyle(
                fontSize: sizeV*3.5,
                color: whiteColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Divider(
          indent: sizeH*6,
          endIndent: sizeH*6,
          height: sizeV*3,
          thickness: 1.5,
          color: whiteColor,
        ),
      ],
    );
  }
}
