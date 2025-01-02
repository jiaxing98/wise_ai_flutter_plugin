class EkycRequest {
  final String countryCode;
  final String idType;
  final bool backCamera;

  const EkycRequest({
    required this.countryCode,
    required this.idType,
    this.backCamera = false,
  });
}
