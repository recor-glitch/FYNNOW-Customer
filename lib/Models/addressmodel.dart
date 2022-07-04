class addressmodel {
  final String name,
      email,
      address,
      locality,
      city,
      address_type,
      pincode,
      state,
      mobile;
  addressmodel(
      {required this.name,
      required this.address,
      required this.city,
      required this.address_type,
      required this.email,
      required this.locality,
      required this.pincode,
      required this.mobile,
      required this.state});
}
