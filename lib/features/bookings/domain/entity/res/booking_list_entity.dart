class BookingListEntity {
  final List<BookingListItemEntity> items;
  final BookingListMetaEntity meta;

  const BookingListEntity({required this.items, required this.meta});
}

class BookingListItemEntity {
  final String id;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final BookingListPropertyEntity property;
  final BookingListPaymentEntity payment;
  final DateTime? createdAt;

  const BookingListItemEntity({
    required this.id,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.property,
    required this.payment,
    required this.createdAt,
  });
}

class BookingListPropertyEntity {
  final String id;
  final String title;
  final String city;
  final String image;

  const BookingListPropertyEntity({
    required this.id,
    required this.title,
    required this.city,
    required this.image,
  });
}

class BookingListPaymentEntity {
  final String invoiceId;
  final String status;
  final int amount;
  final String currency;

  const BookingListPaymentEntity({
    required this.invoiceId,
    required this.status,
    required this.amount,
    required this.currency,
  });
}

class BookingListMetaEntity {
  final int total;
  final int limit;
  final String? nextCursor;
  final bool hasMore;

  const BookingListMetaEntity({
    required this.total,
    required this.limit,
    required this.nextCursor,
    required this.hasMore,
  });
}
