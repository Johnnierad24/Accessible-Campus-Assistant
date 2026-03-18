class SOSContact {
  final String name;
  final String phone;
  final bool shareLocation;

  const SOSContact({
    required this.name,
    required this.phone,
    this.shareLocation = false,
  });

  SOSContact copyWith({String? name, String? phone, bool? shareLocation}) {
    return SOSContact(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shareLocation: shareLocation ?? this.shareLocation,
    );
  }
}
