class Profile {
  final String fullName;
  final String email;
  final String phone;
  final String? profileImage;
  final String userType;
  final FarmDetails farmDetails;
  final List<String> cropPreferences;

  Profile({
    required this.fullName,
    required this.email,
    required this.phone,
    this.profileImage,
    required this.userType,
    required this.farmDetails,
    required this.cropPreferences,
  });
}

class FarmDetails {
  final String farmName;
  final double farmSize; // in acres
  final String location;
  final String soilType;

  FarmDetails({
    required this.farmName,
    required this.farmSize,
    required this.location,
    required this.soilType,
  });
}