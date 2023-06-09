// acceleration_table.dart
class AccelerationTable {
  // 表格数据
  final Map<String, List<Map<String, dynamic>>> data = {
    "左旋右转": [
      {"time": 5.00, "level": 0, "rate": 0.0},
      {"time": 4.69, "level": 95, "rate": 0.1},
      {"time": 4.38, "level": 6502, "rate": 6.74},
      {"time": 4.06, "level": 13851, "rate": 14.36},
      {"time": 3.75, "level": 22331, "rate": 23.14}
    ],
    "回雪飘摇": [
      {"time": 2.44, "level": 0, "rate": 0.0},
      {"time": 2.25, "level": 95, "rate": 0.1},
      {"time": 2.06, "level": 8104, "rate": 8.4},
      {"time": 1.88, "level": 17620, "rate": 18.26}
    ],
    "余寒映日": [
      {"time": 1.88, "level": 0, "rate": 0.0},
      {"time": 1.69, "level": 9705, "rate": 10.06},
      {"time": 1.50, "level": 23650, "rate": 24.51}
    ],
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

  // 获取所有技能名称
  List<String> getSkillNames() {
    return data.keys.toList();
  }
}
