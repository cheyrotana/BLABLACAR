import 'package:blabla/model/ride/locations.dart';

import '../data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;


  static List<Ride> filterByDeparture(Location departure) {
    List<Ride> rideByDeparture = allRides
        .where((ride) => ride.departureLocation == departure)
        .toList();
    return rideByDeparture;
  }

  static List<Ride> filterBySeatRequested(int seatRequested) {
    List<Ride> rideBySeatRequested = allRides
        .where((ride) => ride.availableSeats == seatRequested)
        .toList();
    return rideBySeatRequested;
  }

  static List<Ride> filterBy({Location? departure, int? seatRequested}) {

    if(departure == null) {
      List<Ride> rideBySeatRequested = allRides
          .where((ride) => ride.availableSeats == seatRequested)
          .toList();
      return rideBySeatRequested;
    } 
    else if (seatRequested == null) {
          List<Ride> rideByDeparture = allRides
          .where((ride) => ride.departureLocation == departure)
          .toList();
      return rideByDeparture;
    }
    else {
      List<Ride> rideByDepartureSeatRequested = allRides
        .where(
          (r) =>
              r.departureLocation == departure &&
              r.availableSeats == seatRequested,
        )
        .toList();
      return rideByDepartureSeatRequested;
    }
  }
}
