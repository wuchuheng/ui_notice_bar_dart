import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimationSection extends StatefulWidget {
  final double width;
  final double listViewWidth;
  final String text;
  const AnimationSection({Key? key, required this.width, required this.listViewWidth, required this.text})
      : super(key: key);

  @override
  State<AnimationSection> createState() => _AnimationSectionState();
}

class _AnimationSectionState extends State<AnimationSection> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  late double width;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    width = widget.width * 2 + widget.listViewWidth;
    print(widget.listViewWidth);
    final duration = Duration(microseconds: (width * 10000).toInt());
    animationController = AnimationController(duration: duration, vsync: this);
    animation = Tween<double>(
      begin: -widget.width,
      end: widget.listViewWidth + widget.width,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );
    startAnimation();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= widget.listViewWidth) {
        animationController.stop();
        scrollController.jumpTo(-widget.width);
        animationController.forward(from: -widget.width);
      }
    });
    super.initState();
  }

  void startAnimation() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients && mounted) {
        animationController.forward(from: -widget.width);
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, child) {
        if (scrollController.hasClients) {
          print(animation.value);
          scrollController.jumpTo(animation.value);
        }

        return ListView(
          controller: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: [
            ...widget.text.split('').map((e) => Text(e)).toList(),
          ],
        );
      },
    );
  }
}
