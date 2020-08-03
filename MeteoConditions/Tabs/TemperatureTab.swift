//
//  TemperatureTab.swift
//  MeteoConditions
//
//  Created by slava bily on 30/7/20.
//

import SwiftUI

struct TemperatureTab: View {
  var station: WeatherStation
  
  var body: some View {
    VStack {
      Text("Temperatures for 2020")
        TemperatureChart(measurements: station.measurements)
    }.padding()
  }
}

struct TemperatureTab_Previews: PreviewProvider {
  static var previews: some View {
    TemperatureTab(station: WeatherInformation()!.stations[0])
  }
}
