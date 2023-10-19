import '../../../core/models/result.dart';
import '../entities/location.dart';
import '../repositories/network_repository.dart';

class GetLocationByName {
  final NetworkRepository repository;

  GetLocationByName(this.repository);

  Future<Result<List<Location>>> call(String name) => repository.getLocationByName(name);
}
