class ProfileResponseModel {
  final bool status;
  final MerchantInfo merchantInfo;
  final int totalShipments;
  final int merchantRank;
  final int completedShipmentsCount;

  ProfileResponseModel({
    required this.status,
    required this.merchantInfo,
    required this.totalShipments,
    required this.merchantRank,
    required this.completedShipmentsCount,
  });

  factory ProfileResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return ProfileResponseModel(
      status: json['status'] ?? false,
      merchantInfo: MerchantInfo.fromJson(json['merchant_info'] ?? {}),
      totalShipments: json['total_shipments'] ?? 0,
      merchantRank: json['merchant_rank'] ?? 0,
      completedShipmentsCount: (json['completed_shipments'] as List).length,
    );
  }
}

class MerchantInfo {
  final int id;
  final String phone;
  final String verificationCode;
  final String name;
  final String nationalId;
  final String businessName;
  final String gender;
  final String? idFrontImage;
  final String? idBackImage;
  final String role;
  final int online;
  final String createdAt;
  final String updatedAt;
  final String? cityName;
  final String? AddressDetails;
  final double? averageRating;
  final double addressLat; // Add this line
  final double addressLong; // Add this line

  MerchantInfo({
    required this.id,
    required this.phone,
    required this.verificationCode,
    required this.name,
    required this.nationalId,
    required this.businessName,
    required this.gender,
    this.idFrontImage,
    this.idBackImage,
    required this.role,
    required this.online,
    required this.createdAt,
    required this.updatedAt,
    this.cityName,
    this.AddressDetails,
    this.averageRating,
    required this.addressLat, // Add this line
    required this.addressLong, // Add this line
  });

  factory MerchantInfo.fromJson(Map<dynamic, dynamic> json) {
    return MerchantInfo(
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      verificationCode: json['verification_code'] ?? '',
      name: json['name'] ?? '',
      nationalId: json['national_id'] ?? '',
      businessName: json['business_name'] ?? '',
      gender: json['gender'] ?? '',
      idFrontImage: json['id_front_image'],
      idBackImage: json['id_back_image'],
      role: json['role'] ?? '',
      online: json['online'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      cityName: json['city_name'],
      AddressDetails: json['address_details'],
      averageRating: json['average_rating'] != null ? double.parse(json['average_rating']) : null,
      addressLat: json['address_lat'] != null ? double.parse(json['address_lat']) : 0.0, // Add this line
      addressLong: json['address_long'] != null ? double.parse(json['address_long']) : 0.0, // Add this line
    );
  }

  factory MerchantInfo.empty() {
    return MerchantInfo(
      id: 0,
      phone: '',
      verificationCode: '',
      name: '',
      nationalId: '',
      businessName: '',
      gender: '',
      idFrontImage: null,
      idBackImage: null,
      role: '',
      online: 0,
      createdAt: '',
      updatedAt: '',
      cityName: '',
      AddressDetails: '',
      averageRating: null,
      addressLat: 0.0, // Add this line
      addressLong: 0.0, // Add this line
    );
  }
}
