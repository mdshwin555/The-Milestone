class ContactInfo {
  final int id;
  final String type;
  final String value;
  final String createdAt;
  final String updatedAt;

  ContactInfo({
    required this.id,
    required this.type,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
