import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String age;
  final String dob;
  final String contact;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.dob,
    required this.contact,
  });

  factory User.fromdoc(DocumentSnapshot docsnapshot) {
    final userdata = docsnapshot.data() as Map<String, dynamic>;
    return User(
        id: docsnapshot.id,
        name: userdata['name'],
        email: userdata['email'],
        age: userdata['age'],
        contact: userdata["contact"],
        dob: userdata['dob']);
  }
  factory User.initial() {
    return User(id: "", name: "", email: "", age: "", dob: "", contact: "");
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, age: $age, dob: $dob, contact: $contact)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, age, contact, dob];
}
