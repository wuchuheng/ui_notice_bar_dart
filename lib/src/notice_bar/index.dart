import 'package:flutter/material.dart';

import 'after_list_view.dart';
import 'animation_section.dart';

class NoticeBar extends StatelessWidget {
  final String text;
  final double height;
  final int speed;
  final Icon? icon;
  final Color textColor;
  final Color iconColor;
  NoticeBar(
    this.text, {
    super.key,
    this.height = 20,
    this.speed = 1,
    this.icon,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return NoticeBarDetail(
        text,
        width: constraints.maxWidth,
        boxConstraints: constraints,
        height: height,
        icon: icon,
        speed: speed,
        textColor: textColor,
        iconColor: iconColor,
      );
    });
    throw UnimplementedError();
  }
}

class NoticeBarDetail extends StatefulWidget {
  final double width;
  final String text;
  final Icon? icon;
  final Color textColor;
  final Color iconColor;
  final double height;
  final int speed;
  final BoxConstraints boxConstraints;
  const NoticeBarDetail(this.text,
      {Key? key,
      required this.width,
      required this.boxConstraints,
      required this.height,
      required this.speed,
      required this.icon,
      required this.textColor,
      required this.iconColor})
      : super(key: key);

  @override
  State<NoticeBarDetail> createState() => _NoticeBarDetailState();
}

class _NoticeBarDetailState extends State<NoticeBarDetail> {
  double listViewWidth = 0;

  @override
  Widget build(BuildContext context) {
    late Widget result;
    if (listViewWidth != 0) {
      result = AnimationSection(
        textColor: widget.textColor,
        iconColor: widget.iconColor,
        width: widget.width,
        icon: widget.icon,
        listViewWidth: listViewWidth,
        text: widget.text,
      );
    } else {
      result = AfterListView(
        width: widget.width,
        text: widget.text,
        callback: (width) {
          if (listViewWidth == 0) setState(() => listViewWidth = width);
        },
      );
    }

    return Container(
      color: Colors.white,
      height: 30,
      child: result,
    );
  }
}
