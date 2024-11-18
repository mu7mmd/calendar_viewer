final class CalendarReservationUser {
  final String? id;
  final String name;
  final String? netImage;
  final String? assetImage;
  final Object? data;

  bool get hasAssetImage => assetImage != null;

  bool get hasNetImage => netImage != null;

  const CalendarReservationUser({
    this.id,
    required this.name,
    this.netImage,
    this.assetImage,
    this.data,
  });
}
