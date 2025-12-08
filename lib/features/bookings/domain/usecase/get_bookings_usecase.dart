import 'package:rentverse/core/usecase/usecase.dart';
import 'package:rentverse/features/bookings/domain/entity/res/booking_list_entity.dart';
import 'package:rentverse/features/bookings/domain/repository/bookings_repository.dart';

class GetBookingsUseCase
    implements UseCase<BookingListEntity, GetBookingsParams> {
  GetBookingsUseCase(this._repository);

  final BookingsRepository _repository;

  @override
  Future<BookingListEntity> call({GetBookingsParams? param}) {
    final p = param ?? const GetBookingsParams();
    return _repository.getBookings(limit: p.limit, cursor: p.cursor);
  }
}

class GetBookingsParams {
  final int limit;
  final String? cursor;

  const GetBookingsParams({this.limit = 10, this.cursor});
}
