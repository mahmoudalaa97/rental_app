import 'package:either_dart/either.dart';
import 'package:rental_app/data/model/property.dart';
import 'package:rental_app/domain/repository.dart';

class DummyRepositoryImpl extends Repository {
  DummyRepositoryImpl({this.failure = false});

  final bool failure;

  @override
  Future<Either<String, List<Property>>> fetchProperties(
      {String? query}) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (failure) return const Left("An error occurred");

    return Right(query == null || query.isEmpty
        ? _dummyProperties
        : _dummyProperties
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  List<Property> get _dummyProperties {
    return [
      Property(
        name: "Deluxe Office Rent",
        location: "Uyo, Nigeria",
        type: "office",
        pricing: 1200,
        per: "Weekly",
        id: 0,
        image:
            "https://www.teslarati.com/wp-content/uploads/2016/03/Inside-Tesla-Gigafactory-Office.jpg",
      ),
      Property(
          name: "Rose Premium Estate",
          location: "Abuja, Nigeria",
          type: "duplex",
          pricing: 120200,
          per: "Yearly",
          id: 1,
          image:
              "https://i.pinimg.com/736x/17/83/96/17839628856abe09d225fdf1b9682240.jpg")
    ];
  }
}

