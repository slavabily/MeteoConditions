//
//  PrecipitationTab.swift
//  MeteoConditions
//
//  Created by slava bily on 30/7/20.
//

import SwiftUI

struct PrecipitationTab: View {
  var station: WeatherStation
  
  func monthFromName(_ name: String) -> Int {
    let df = DateFormatter()
    df.dateFormat = "LLLL"
    if let date = df.date(from: name) {
      return Calendar.current.component(.month, from: date)
    }
    return 0
  }
  
  var body: some View {
    VStack {
        Text("Precipitation for 2018")
        ScrollView(.horizontal) {
            PrecipitationChart(measurements: station.measurements)
        }
    }.padding()
  }
}

struct PrecipitationTab_Previews: PreviewProvider {
  static var previews: some View {
    PrecipitationTab(station: WeatherInformation()!.stations[1])
  }
}

