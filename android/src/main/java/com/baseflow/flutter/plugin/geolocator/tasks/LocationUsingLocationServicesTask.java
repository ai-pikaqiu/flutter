package com.baseflow.flutter.plugin.geolocator.tasks;

import com.baseflow.flutter.plugin.geolocator.Codec;
import com.baseflow.flutter.plugin.geolocator.data.LocationOptions;

abstract class LocationUsingLocationServicesTask extends Task {
    final LocationOptions mLocationOptions;

    LocationUsingLocationServicesTask(TaskContext taskContext) {
        super(taskContext);

        mLocationOptions = Codec.decodeLocationOptions(taskContext.getArguments());
    }
}
