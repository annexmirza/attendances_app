class AttendanceModel {
  AttendanceModel({
    this.id,
    this.name,
    this.date,
    this.month,
    this.day,
    this.checkIn,
    this.checkOut,
    this.todayMinutes = 0,
  });

  String? id;
  String? name;
  int? day;
  int? date;
  String? month;
  int? checkIn;
  int? checkOut;
  int? todayMinutes;

  factory AttendanceModel.fromMap(Map doc) => AttendanceModel(
        id: doc["id"],
        name: doc["name"],
        date: doc["date"],
        month: doc["month"],
        day: doc["day"],
        checkIn: doc["checkIn"],
        checkOut: doc["checkOut"],
        todayMinutes: doc["todayMinutes"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "date": date,
        "month": month,
        "checkIn": checkIn,
        "day": day,
        "checkOut": checkOut,
        "todayMinutes": todayMinutes,
      };
}
