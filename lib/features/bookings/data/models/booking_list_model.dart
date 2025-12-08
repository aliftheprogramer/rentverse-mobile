import 'package:logger/logger.dart';
import 'package:rentverse/features/bookings/domain/entity/res/booking_list_entity.dart';

class BookingListModel {
  final List<BookingListItemModel> items;
  final BookingListMetaModel meta;

  const BookingListModel({required this.items, required this.meta});

  factory BookingListModel.fromJson(Map<String, dynamic> json) {
    Logger().i('Parsing booking list response -> $json');
    final dataList = json['data'] as List? ?? [];
    final items = dataList
        .map((e) => BookingListItemModel.fromJson(_asMap(e)))
        .toList();
    final meta = BookingListMetaModel.fromJson(_asMap(json['meta']));
    return BookingListModel(items: items, meta: meta);
  }

  BookingListEntity toEntity() {
    return BookingListEntity(
      items: items.map((e) => e.toEntity()).toList(),
      meta: meta.toEntity(),
    );
  }
}

class BookingListItemModel {
  final String id;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final BookingListPropertyModel property;
  final BookingListPaymentModel payment;
  final DateTime? createdAt;

  const BookingListItemModel({
    required this.id,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.property,
    required this.payment,
    required this.createdAt,
  });

  factory BookingListItemModel.fromJson(Map<String, dynamic> json) {
    return BookingListItemModel(
      id: json['id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      startDate: _parseDate(json['startDate'] as String?),
      endDate: _parseDate(json['endDate'] as String?),
      property: BookingListPropertyModel.fromJson(_asMap(json['property'])),
      payment: BookingListPaymentModel.fromJson(_asMap(json['payment'])),
      createdAt: _parseDate(json['createdAt'] as String?),
    );
  }

  BookingListItemEntity toEntity() {
    return BookingListItemEntity(
      id: id,
      status: status,
      startDate: startDate,
      endDate: endDate,
      property: property.toEntity(),
      payment: payment.toEntity(),
      createdAt: createdAt,
    );
  }
}

class BookingListPropertyModel {
  final String id;
  final String title;
  final String city;
  final String image;

  const BookingListPropertyModel({
    required this.id,
    required this.title,
    required this.city,
    required this.image,
  });

  factory BookingListPropertyModel.fromJson(Map<String, dynamic> json) {
    return BookingListPropertyModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      city: json['city'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

  BookingListPropertyEntity toEntity() {
    return BookingListPropertyEntity(
      id: id,
      title: title,
      city: city,
      image: image,
    );
  }
}

class BookingListPaymentModel {
  final String invoiceId;
  final String status;
  final int amount;
  final String currency;

  const BookingListPaymentModel({
    required this.invoiceId,
    required this.status,
    required this.amount,
    required this.currency,
  });

  factory BookingListPaymentModel.fromJson(Map<String, dynamic> json) {
    return BookingListPaymentModel(
      invoiceId: json['invoiceId'] as String? ?? '',
      status: json['status'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? '',
    );
  }

  BookingListPaymentEntity toEntity() {
    return BookingListPaymentEntity(
      invoiceId: invoiceId,
      status: status,
      amount: amount,
      currency: currency,
    );
  }
}

class BookingListMetaModel {
  final int total;
  final int limit;
  final String? nextCursor;
  final bool hasMore;

  const BookingListMetaModel({
    required this.total,
    required this.limit,
    required this.nextCursor,
    required this.hasMore,
  });

  factory BookingListMetaModel.fromJson(Map<String, dynamic> json) {
    return BookingListMetaModel(
      total: (json['total'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  BookingListMetaEntity toEntity() {
    return BookingListMetaEntity(
      total: total,
      limit: limit,
      nextCursor: nextCursor,
      hasMore: hasMore,
    );
  }
}

DateTime? _parseDate(String? value) {
  if (value == null || value.isEmpty) return null;
  return DateTime.tryParse(value);
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return {};
}
