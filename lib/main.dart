import 'package:flutter/material.dart';
import 'acceleration_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AccelerationTable table = AccelerationTable();
  final TextEditingController speedInputController = TextEditingController();
  late String selectedSkill;
  late Map<String, dynamic> result;

  void calculate() {
    var userSpeedLevel = int.tryParse(speedInputController.text);
    if (userSpeedLevel == null || userSpeedLevel < 0) {
      setState(() {
        result = {"error": "Please enter a valid speed level"};
      });
    } else {
      result = table.calculate(userSpeedLevel, selectedSkill);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: speedInputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Speed Level',
                  hintText: 'Enter your speed level',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedSkill,
                onChanged: (newValue) => setState(() {
                    selectedSkill = newValue!;
                  }),
                items: <String>[
                  'zuoXuanYouZhuan',
                  'quXianKaiKong',
                  'ruanZhuanJiShi'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Select Skill',
                  hintText: 'Choose a skill',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  calculate();
                },
                child: Text('Calculate'),
              ),

              // 根据计算结果显示信息
              if (result != null) ...[
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


