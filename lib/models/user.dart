import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final String? password;

  User({
    this.email,
    this.password,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return User(
      email: data['email'] as String,
      password: data['password'] as String,
    );
  }

  Map<String, dynamic> toDatabaseJson() => {
        'email': this.email,
        'password': this.email,
      };

  @override
  List<Object?> get props => [];
}
