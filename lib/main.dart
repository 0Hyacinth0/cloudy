// 导入 Flutter 相关的包
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '云裳心经手法计算器',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '云裳心经手法计算器'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _speedLevelController = TextEditingController();

  void _calculate() {
    // 获取输入的加速等级
    int speedLevel = int.tryParse(_speedLevelController.text);

    if (speedLevel == null) {
      // 处理无效输入
      print('输入无效');
      return;
    }

    // 在此处执行计算操作
    print('加速等级: $speedLevel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _speedLevelController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '加速等级',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            RaisedButton(
              onPressed: _calculate,
              child: Text('查看结果'),
            ),
          ],
        ),
      ),
    );
  }
}

