/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/src/interfaces/bluetooth.dart';
import 'package:dependency_interfaces/src/interfaces/location.dart';

abstract interface class NearbyDevices implements Bluetooth, Location {}
