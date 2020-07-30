//
//  StationInfo.swift
//  MeteoConditions
//
//  Created by slava bily on 30/7/20.
//

import SwiftUI

struct StationInfo: View {
  var station: WeatherStation
  
    var body: some View {
      VStack {
        StationHeader(station: self.station)
        TabView {
          TemperatureTab(station: self.station)
            .tabItem({
              Image(systemName: "thermometer")
              Text("Temperatures")
            })
          SnowfallTab(station: self.station)
            .tabItem({
              Image(systemName: "snow")
              Text("Snowfall")
            })
            PrecipitationTab(station: self.station)
            .tabItem({
              Image(systemName: "cloud.rain")
              Text("Precipitation")
            })
        }
        }.navigationBarTitle(Text("\(station.name)"), displayMode: .inline).padding()
    }
}

struct StationInfo_Previews: PreviewProvider {
    static var previews: some View {
      StationInfo(station: WeatherInformation()!.stations[0])
    }
}
