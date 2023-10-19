import '../../../core/models/result.dart';
import '../entities/location.dart';
import '../repositories/network_repository.dart';

class GetLocationByZip {
  final NetworkRepository repository;

  GetLocationByZip(this.repository);

  Future<Result<Location>> call(String zip) => repository.getLocationByZip(zip);
}
