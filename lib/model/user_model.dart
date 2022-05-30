class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? numberHN;
  String? password;
  String? address;
  String? congenitalDisease;
  String? drugAllergy;
  String? date;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.numberHN,
      this.password,
      this.address,
      this.congenitalDisease,
      this.drugAllergy,
      this.date});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['Name'],
        numberHN: map['numberHN'],
        password: map['password'],
        address: map['address'],
        congenitalDisease: map['congenital_disease'],
        drugAllergy: map['drug_allergy'],
        date: map['user_date']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'Name': firstName,
      'numberHN': numberHN,
      'password': password,
      'address': address,
      'congenital_disease': congenitalDisease,
      'drug_allergy': drugAllergy,
      'user_date': date,
    };
  }
}
