//
//  StationHeader.swift
//  MeteoConditions
//
//  Created by slava bily on 30/7/20.
//

import SwiftUI

struct StationHeader: View {
  var station: WeatherStation
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("Latitude: \(station.latitude.asLatitude)")
        Text("Longitude: \(station.longitude.asLongitude)")
        Text("Elevation: \(station.altitude) ft.")
      }
      Spacer()
      MapView(latitude: station.latitude, longitude: station.longitude)
        .frame(width: 200, height: 200)
    }
  }
}

struct StationHeader_Previews: PreviewProvider {
  static var previews: some View {
    StationHeader(station: WeatherInformation()!.stations[1])
  }
}
