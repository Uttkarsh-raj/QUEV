class ChargingLocation {
  double lat;
  double lng;
  String name;
  String id;
  bool open;
  String vicinity;
  ChargingLocation(
      {required this.lat,
      required this.lng,
      required this.id,
      required this.name,
      required this.open,
      required this.vicinity});
}
