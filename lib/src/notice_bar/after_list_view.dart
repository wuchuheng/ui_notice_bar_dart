import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AfterListView extends StatefulWidget {
  final String text;
  final Function(double width) callback;

  const AfterListView({Key? key, required this.text, required this.callback}) : super(key: key);

  @override
  State<AfterListView> createState() => _AfterListViewState();
}

class _AfterListViewState extends State<AfterListView> {
  final ScrollController _controller = ScrollController();

  void onAfterListView() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      if (!_controller.hasClients) return;
      final totalLength = _controller.position.maxScrollExtent;
      final minWidth = _controller.position.minScrollExtent;
      print(minWidth);
      widget.callback(totalLength);
    });
  }

  @override
  void initState() {
    super.initState();
    onAfterListView();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      final min = constrain.minWidth;
      return Container(
        width: min,
        child: ListView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: [
            ...widget.text.split('').map((e) => Text(e)).toList(),
          ],
        ),
      );
    });
  }
}
