// acceleration_table.dart
class AccelerationTable {
  // 表格数据
  final Map<String, List<Map<String, dynamic>>> data = {
  "gcd": [
  {"time": 1.50, "level": 0, "rate": 0.0},
  {"time": 1.44, "level": 95, "rate": 0.1},
  {"time": 1.38, "level": 4241, "rate": 4.4},
  {"time": 1.31, "level": 8857, "rate": 9.18},
  {"time": 1.25, "level": 13851, "rate": 14.36},
  {"time": 1.19, "level": 19316, "rate": 20.02}
  ],
  "huiXuePiaoYaoGuiZi": [
  {"time": 2.44, "level": 0, "rate": 0.0},
  {"time": 2.25, "level": 95, "rate": 0.1},
  {"time": 2.06, "level": 8104, "rate": 8.4},
  {"time": 1.88, "level": 17620, "rate": 18.26}
  ],
  "huiXuePiaoYaoYuHanYingRi": [
  {"time": 1.88, "level": 0, "rate": 0.0},
  {"time": 1.69, "level": 9705, "rate": 10.06},
  {"time": 1.50, "level": 23650, "rate": 24.51}
  ],
  "zuoXuanYouZhuan": [
  {"time": 5.00, "level": 0, "rate": 0.0},
  {"time": 4.69, "level": 95, "rate": 0.1},
  {"time": 4.38, "level": 6502, "rate": 6.74},
  {"time": 4.06, "level": 13851, "rate": 14.36},
  {"time": 3.75, "level": 22331, "rate": 23.14}
  ]
  };

  // 根据加速等级计算加速段数和技能引导时间
  Map<String, dynamic> calculate(int speedLevel, String skill) {
  List<Map<String, dynamic>> skillData = data[skill];
  if (skillData == null) {
    return {"error": "Invalid skill name"};
  }

  Map<String, dynamic> result = {"time": 0.0, "level": 0, "rate": 0.0};
  for (int i = 0; i < skillData.length; i++) {
    if (speedLevel >= skillData[i]["level"]) {
      result = skillData[i];
    } else {
      break;
    }
  }

  return result;
}
void main() {
  AccelerationTable table = new AccelerationTable();
// 示例：用户填写的加速等级为 10000，查询左旋右转技能
  int userSpeedLevel = 10000;
  String skillName = "zuoXuanYouZhuan";
  Map<String, dynamic> result = table.calculate(userSpeedLevel, skillName);
  if (result.containsKey("error")) {
    print(result["error"]);
  } else {
    print("技能引导时间: ${result['time']}s");
    print("加速段数: ${result['level']}");
    print("加速率: ${result['rate']}%");
  }
}

}
