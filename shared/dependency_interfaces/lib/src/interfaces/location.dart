/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

abstract interface class Location {
  Future<bool> enableLocation();

  Future<bool> get isLocationEnabled;

  Future<bool> requestLocationPermission();

  Future<Object> getGpsPosition();
}
