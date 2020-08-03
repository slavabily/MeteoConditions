//
//  HumidityTab.swift
//  MeteoConditions
//
//  Created by slava bily on 31/7/20.
//

import SwiftUI

struct HumidityTab: View {
    
    var station: WeatherStation
    
    var body: some View {
        VStack {
            Text("Humidity for 2020")
            HumidityChart(measurements: station.measurements).padding()
        }
    }
}

struct HumidityTab_Previews: PreviewProvider {
    static var previews: some View {
        HumidityTab(station: WeatherInformation()!.stations[0])
    }
}
