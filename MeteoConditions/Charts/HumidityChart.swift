//
//  HumidityChart.swift
//  MeteoConditions
//
//  Created by slava bily on 31/7/20.
//

import SwiftUI

struct HumidityChart: View {
    
    var measurements: [DayInfo]
    
    var body: some View {
        List(measurements) { measurement in
            HStack {
                Text("\(measurement.dateString)")
                    .frame(width: 80, alignment: .trailing)
                ZStack(alignment: .leading, content: {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: CGFloat(measurement.humidity * 1.5), height: 10)
                    ForEach(0..<16) { mark in
                        Rectangle()
                            .fill(mark % 5 == 0 ? Color.black : Color.gray)
                            .offset(x: CGFloat(mark) * 10.0)
                            .frame(width: 1.0)
                            .zIndex(1.0)
                    }
                })
                Spacer()
                Text("\(measurement.humidity.stringToOneDecimal)%")
            }
        }
    }
}

struct HumidityChart_Previews: PreviewProvider {
    static var previews: some View {
        HumidityChart(measurements: WeatherInformation()!.stations[0].measurements)
    }
}
