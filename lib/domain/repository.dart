import 'package:either_dart/either.dart';
import 'package:rental_app/data/model/property.dart';

abstract class Repository {
  Future<Either<String, List<Property>>> fetchProperties({String? query});
}
