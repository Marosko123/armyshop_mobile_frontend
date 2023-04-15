class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final int age;
  final String address;
  final String licensePicture;
  final bool isLicenseValid;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.address,
    required this.licensePicture,
    required this.isLicenseValid,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'address': address,
      'licensePicture': licensePicture,
      'isLicenseValid': isLicenseValid,
    };
  }

  isEmpty() {
    return email == '';
  }
}
