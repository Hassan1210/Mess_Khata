class ModleHistory {
  static String table = "History";

  static final String columnDAY = "day";
  static final String columnLUNCH = "lunch";
  static final String columnDINNER = "dinner";
  static final String columnLUNCHRs = "lunch_Rs";
  static final String columnDINNERRs = "dinner_RS";

  int? dinner;
  int? lunch;
  String? day;
  int? dinnerRs;
  int? lunchRs;

  ModleHistory({
    this.dinner,
    this.lunch,
    this.day,
    this.lunchRs,
    this.dinnerRs
  });

  Map<String,dynamic> toMap()=>{
    columnDAY: day,
    columnLUNCH: lunch,
    columnDINNER: dinner,
    columnLUNCHRs: lunchRs,
    columnDINNERRs :dinnerRs,
  };

  ModleHistory.fromMap(Map<dynamic,dynamic> map){
    day = map[columnDAY];
    lunch = map[columnLUNCH];
    lunchRs = map[columnLUNCHRs];
    dinner = map[columnDINNERRs];
    dinnerRs = map[columnDINNERRs];
  }
}
