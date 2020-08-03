//
//  SnowfallTab.swift
//  MeteoConditions
//
//  Created by slava bily on 30/7/20.
//

import SwiftUI

struct SnowfallTab: View {
  var station: WeatherStation
  
  var body: some View {
    VStack {
      Text("Snowfall for 2020")
        SnowfallChart(measurements: station.measurements)
    }.padding()
  }
}

struct SnowfallTab_Previews: PreviewProvider {
  static var previews: some View {
    SnowfallTab(station: WeatherInformation()!.stations[1])
  }
}
