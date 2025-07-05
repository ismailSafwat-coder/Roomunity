import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String id;
  final String title;
  final String description;
  final String type;
  final double price;
  final String location;
  final List<String> imageUrls;
  final DateTime availableFrom;
  final DateTime availableTo;

  Room({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.price,
    required this.location,
    required this.imageUrls,
    required this.availableFrom,
    required this.availableTo,
  });

  factory Room.fromMap(Map<String, dynamic> data, String id) {
    return Room(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      type: data['type'] ?? 'home',
      price: (data['price'] ?? 0.0).toDouble(),
      location: data['location'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      availableFrom: (data['availableFrom'] as Timestamp).toDate(),
      availableTo: (data['availableTo'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'price': price,
      'location': location,
      'imageUrls': imageUrls,
      'availableFrom': Timestamp.fromDate(availableFrom),
      'availableTo': Timestamp.fromDate(availableTo),
    };
  }
}
