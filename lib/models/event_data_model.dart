class EventDataModel {
  static const String collectionName='Events';
  String? eventId;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  String eventCategoryId;
  String eventCategoryLightImage;
  String eventCategoryDarkImage;
  bool isFavorite;

  EventDataModel({
    this.eventId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventCategoryId,
    required this.eventCategoryLightImage,
    required this.eventCategoryDarkImage,
    this.isFavorite = false,
  });

  factory EventDataModel.fromFireStore(Map<String,dynamic>json){
return EventDataModel(
eventId: json['eventId'],
    eventTitle: json['eventTitle'],
    eventDescription: json['eventDescription'],
    eventDate:DateTime.fromMillisecondsSinceEpoch( json['eventDate']),
    eventCategoryId: json['eventCategoryId'],
    eventCategoryLightImage: json['eventCategoryLightImage'],
    eventCategoryDarkImage: json['eventCategoryDarkImage'],
    isFavorite: json['isFavorite'],
);

  }

  Map<String, dynamic> toFireStore() {
    return {
      'eventId': eventId,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventDate':eventDate.millisecondsSinceEpoch,
      'eventCategoryId':eventCategoryId,
      'eventCategoryLightImage':eventCategoryLightImage,
      'eventCategoryDarkImage':eventCategoryDarkImage,
      'isFavorite':isFavorite
    };
  }
  
}
