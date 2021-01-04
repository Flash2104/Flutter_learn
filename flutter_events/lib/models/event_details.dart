class EventDetailsModel {
  String id;
  String _description;
  String _date;
  String _startTime;
  String _endTime;
  String _speaker;
  bool _isFavorite;

  String get description => _description;

  String get date => _date;

  bool get isFavorite => _isFavorite;

  String get speaker => _speaker;

  String get endTime => _endTime;

  String get startTime => _startTime;

  EventDetailsModel._(this.id, this._description, this._date, this._startTime, this._endTime, this._speaker, this._isFavorite);

  EventDetailsModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    _description = map['description'];
    _date = map['date'];
    _isFavorite = map['is_favorite'];
    _speaker = map['speaker'];
    _endTime = map['end_time'];
    _startTime = map['start_time'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(id != null) {
      map['id'] = id;
    }
    map['description'] = _description;
    map['date'] = _date;
    map['is_favorite'] = _isFavorite;
    map['speaker'] = _speaker;
    map['end_time'] = _endTime;
    map['start_time'] = _startTime;
  }
}
