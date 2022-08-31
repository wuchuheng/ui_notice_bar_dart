import 'package:flutter/material.dart';

import 'after_list_view.dart';
import 'animation_section.dart';

class NoticeBar extends StatelessWidget {
  final String text;
  final double height;
  final int speed;
  const NoticeBar(this.text, {super.key, this.height = 20, this.speed = 1});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return NoticeBarDetail(
        text,
        width: constraints.maxWidth,
        boxConstraints: constraints,
        height: height,
        speed: speed,
      );
    });
    throw UnimplementedError();
  }
}

class NoticeBarDetail extends StatefulWidget {
  final double width;
  final String text;
  final double height;
  final int speed;
  final BoxConstraints boxConstraints;
  const NoticeBarDetail(this.text,
      {Key? key,
      required this.width,
      required this.boxConstraints,
      required this.height,
      required this.speed})
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
        width: widget.width,
        listViewWidth: listViewWidth,
        text: widget.text,
      );
    } else {
      result = AfterListView(
          text: widget.text,
          callback: (width) {
            if (listViewWidth == 0) setState(() => listViewWidth = width);
          });
    }
    return Container(
      color: Colors.red[100],
      height: 100,
      child: result,
    );
  }
}
