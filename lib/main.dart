import 'package:flutter/material.dart';
import 'acceleration_table.dart'; // 导入加速表

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // 无状态主程序组件
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Acceleration Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Acceleration Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // 有状态的主页面组件
  MyHomePage({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AccelerationTable table = AccelerationTable(); // 创建加速表对象
  final TextEditingController speedInputController = TextEditingController(); // 创建文本编辑控制器
  late String selectedSkill; // 当前选择的技能
  late Map<String, dynamic> result = {}; // 计算结果

  void calculate() {
    // 计算方法
    var userSpeedLevel = int.tryParse(speedInputController.text); // 尝试将文本框中的值转换为整数
    if (userSpeedLevel == null || userSpeedLevel < 0) {
      // 如果转换失败或值小于0
      setState(() {
        result = {"error": "请输入正确的加速等级"}; // 设置结果为错误提示
      });
    } else {
      result = table.calculate(userSpeedLevel, selectedSkill); // 根据速度等级和技能进行计算
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // 构建界面
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: speedInputController, // 输入框控制器
                keyboardType: TextInputType.number, // 数字输入类型
                decoration: InputDecoration(
                  labelText: '加速等级',
                  hintText: '输入您角色当前的加速等级',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedSkill,
                onChanged: (newValue) => setState(() {
                  selectedSkill = newValue!; // 更新选定的技能
                }),
                items: table.getSkillNames().map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: '技能选择',
                  hintText: '选择一个技能',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  calculate(); // 计算按钮点击事件
                },
                child: Text('生成结果'),
              ),

              // 根据计算结果显示信息
              if (result.isNotEmpty) ...[
                SizedBox(height: 20),
                if (result.containsKey("error")) ...[
                  Text(
                    result["error"],
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  )
                ] else ...[
                  Text('技能引导时间: ${result['time']}s'),
                  Text('加速段数: ${result['level']}'),
                  Text('加速率: ${result['rate']}%'),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
