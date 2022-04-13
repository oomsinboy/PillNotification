class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? numberHN;
  String? password;

  UserModel({this.uid, this.email, this.firstName, this.numberHN, this.password});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['Name'],
      numberHN: map['numberHN'],
      password: map['password'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'Name': firstName,
      'numberHN': numberHN,
      'password': password,
    };
  }
}
