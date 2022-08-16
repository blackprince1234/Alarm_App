//Class for list of Alarms. (Used later when creating an instance of the class)



class AlarmList {
  final int id;
  final int hour;
  final int minutes;


  AlarmList({
    required this.id,
    required this.hour,
    required this.minutes,
  });





  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hour': hour,
      'minute': minutes,
    };
  }

  // Implement toString to make it easier to see information about
  // each alarm when using the print statement.
  @override
  String toString() {
    return 'Alarm{id: $id, hour: $hour, minutes: $minutes}';
  }

}