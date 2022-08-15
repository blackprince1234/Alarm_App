//Keeping track of instance variables.
class User {
  final int hour;
  final int minute;

  User(this.hour, this.minute);

  User.fromJson(Map<String, dynamic> json)
      : hour = json['hour'],
        minute = json['minute'];

  Map<String, dynamic> toJson() =>
      {
        'hour': hour,
        'minute': minute,
      };
}