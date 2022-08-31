import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wuchuheng_ui_notice_bar/src/notice_bar/index.dart';

Widget createWidgetForTesting({required Widget child}) => MaterialApp(home: child);

void main() {
  testWidgets('NoticeBar test', (WidgetTester tester) async {
    final text = 'hello';
    await tester.pumpWidget(createWidgetForTesting(child: NoticeBar(text)));
    final noticeBar = find.byType(NoticeBar);
    expect(noticeBar, findsOneWidget);
    expect(find.text(text), findsOneWidget);
  });
}
