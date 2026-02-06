import 'package:blabla/model/ride/locations.dart';

import '../data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;

  static List<Ride> _filterByDeparture(List<Ride> rides, Location departure) {
    return rides = allRides
        .where((ride) => ride.departureLocation == departure)
        .toList();
  }

  static List<Ride> _filterBySeatRequested(
    List<Ride> rides,
    int seatRequested,
  ) {
    return rides = allRides
        .where((ride) => ride.availableSeats >= seatRequested)
        .toList();
  }

  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    List<Ride> result = allRides;

    if (departure != null) {
      result = _filterByDeparture(result, departure);
    }
    if (seatRequested != null) {
      result = _filterBySeatRequested(result, seatRequested);
    }

    return result;
  }
}
