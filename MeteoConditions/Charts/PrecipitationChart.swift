//
//  PrecipitationChart.swift
//  MeteoConditions
//
//  Created by slava bily on 30/7/20.
//

import SwiftUI

struct PrecipitationChart: View {
    
    var measurements: [DayInfo]
    
    func sumPrecipitation(_ month: Int) -> Double {
        self.measurements.filter {
            Calendar.current.component(.month, from: $0.date) == month + 1
        }.reduce(0) {
            $0 + $1.precipitation
        }
    }
    
    func monthAbbreviationFromInt(_ month: Int) -> String {
        let ma = Calendar.current.shortMonthSymbols
        
        return ma[month]
    }
    
    var body: some View {
        HStack {
            ForEach(0 ..< 12) { month in
                VStack {
                    Spacer()
                    Text("\(self.sumPrecipitation(month).stringToOneDecimal)")
                        .font(.footnote)
                        .rotationEffect(.degrees(-90))
                        .offset(y: self.sumPrecipitation(month) < 2.4 ? 0 : 35)
                        .zIndex(1)
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 30, height: CGFloat(self.sumPrecipitation(month)) * 15.0)
                    Text("\(self.monthAbbreviationFromInt(month))")
                        .font(.footnote)
                        .frame(height: 20)
                }
            }
        }
    }
}

struct PrecipitationChart_Previews: PreviewProvider {
    static var previews: some View {
        PrecipitationChart(measurements: WeatherInformation()!.stations[2].measurements)
    }
}

