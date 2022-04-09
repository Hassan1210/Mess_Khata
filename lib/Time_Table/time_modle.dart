class ModleTimeTable {
  static String table = "TimeTable";

  static final String columnID = "id";
  static final String columnDAY = "day";
  static final String columnLUNCH = "lunch";
  static final String columnDINNER = "dinner";
  static final String columnLUNCHRs = "lunch_Rs";
  static final String columnDINNERRs = "dinner_RS";

  int? id;
  String? dinner;
  String? lunch;
  String? day;
  int? dinnerRs;
  int? lunchRs;

  ModleTimeTable({
    this.id,
    this.dinner,
    this.lunch,
    this.day,
    this.lunchRs,
    this.dinnerRs
});

  Map<String,dynamic> toMap()=>{
      columnID: id,
      columnDAY: day,
      columnLUNCH: lunch,
      columnDINNER: dinner,
      columnLUNCHRs: lunchRs,
      columnDINNERRs :dinnerRs,
    };

  ModleTimeTable.fromMap(Map<dynamic,dynamic> map){
    id = map[columnID];
    day = map[columnDAY];
    lunch = map[columnLUNCH];
    lunchRs = map[columnLUNCHRs];
    dinner = map[columnDINNERRs];
    dinnerRs = map[columnDINNERRs];
  }

}
