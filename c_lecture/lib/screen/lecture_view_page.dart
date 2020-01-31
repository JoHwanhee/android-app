import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LectureViewPage extends StatefulWidget {
  @override
  _LectureViewPageState createState() => _LectureViewPageState();
}

class _LectureViewPageState extends State<LectureViewPage> {
  String _markdownData = """
## 프로그래밍 언어?
사람들은 말을 통해 서로 대화를 하고 서로의 생각을 주고 받습니다. 그렇다면 사람과 컴퓨터는 어떻게 대화를 할까요?
 
어떤 사람들들은 마우스와 키보드를 통해서 인터넷을 켜고, 게임을 하는 반면 또 어떤 사람들은, 이상한 명령어들을 이용해서 그러한 인터넷이나 게임을 만들기도 합니다. 
그 이상한 명령어를 ​프로그래밍 언어라고 부릅니다. 사람들간에는 한국어, 영어, 프랑스어 등이 있듯이, 프로그래밍 언어에도 여러 종류가 있습니다. C, C++, JAVA, PYTHON, 등으로 불리고 있습니다.

우리는 이제부터 앞서말한 C라고 하는 프로그래밍 언어로 컴퓨터와 대화를 시도해볼겁니다!
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final controller = ScrollController();


    return SafeArea(
      child: Markdown(
        controller: controller,
        selectable: true,
        data: _markdownData,
        imageDirectory: 'https://raw.githubusercontent.com',
      ),
    );
  }
}
