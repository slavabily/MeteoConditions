//
//  SnowfallChart.swift
//  MeteoConditions
//
//  Created by slava bily on 30/7/20.
//

import SwiftUI

struct SnowfallChart: View {
    
    var measurements: [DayInfo]
    
    var body: some View {
        List(measurements.filter { $0.snowfall > 0.0 }) { measurement in
            HStack {
                Text("\(measurement.dateString)")
                    .frame(width: 100, alignment: .trailing)
                ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.blue)
                .frame(width: CGFloat(measurement.snowfall * 10.0), height: 5)
                ForEach(0..<17) { mark in
                    Rectangle()
                        .fill(mark % 5 == 0 ? Color.black : Color.gray)
                        .offset(x: CGFloat(mark) * 10.0)
                        .frame(width: 1.0)
                        .zIndex(1.0)
                }
                }
                Spacer()
                Text("\(measurement.snowfall.stringToOneDecimal)\"")
            }
        }
    }
}

struct SnowfallChart_Previews: PreviewProvider {
    static var previews: some View {
        SnowfallChart(measurements: WeatherInformation()!.stations[2].measurements)
    }
}

