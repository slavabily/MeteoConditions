//
//  TemperatureChart.swift
//  MeteoConditions
//
//  Created by slava bily on 30/7/20.
//

import SwiftUI

struct TemperatureChart: View {
    
    var measurements: [DayInfo]
    
    let tempGradient = Gradient(colors: [
        .purple,
        Color(red: 0, green: 0, blue: 139/255),
        .blue,
        Color(red: 30/255, green: 144/255, blue: 1),
        Color(red: 0, green: 191/255, blue: 250/255),
        Color(red: 135/255, green: 206/255, blue: 250/255),
        .green,
        .yellow,
        .orange,
        Color(red: 1, green: 140/255, blue: 0),
        .red,
        Color(red: 139/255, green: 0, blue: 0)
    ])
    
    func degreeHeight(_ height: CGFloat, range: Int) -> CGFloat {
        height / CGFloat(range)
    }
    
    func dayWidth(_ width: CGFloat, count: Int) -> CGFloat {
        width / CGFloat(count)
    }
    
    func dayOffset(_ date: Date, dWidth: CGFloat) -> CGFloat {
        CGFloat(Calendar.current.ordinality(of: .day, in: .year, for: date)!) * dWidth
    }
    
    func tempOffset(_ temperature: Double, degreeHeight: CGFloat) -> CGFloat {
        CGFloat(temperature + 10) * degreeHeight
    }
    
    func tempLabelOffset(_ line: Int, height: CGFloat) -> CGFloat {
        height - self.tempOffset(Double(line * 10), degreeHeight: self.degreeHeight(height, range: 110))
    }
    
    func offsetFirstOfMonth(_ month: Int, width: CGFloat) -> CGFloat {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        let foM = dateFormatter.date(from: "\(month)/1/2018")!
        let dayWidth = self.dayWidth(width, count: 365)
        return self.dayOffset(foM, dWidth: dayWidth)
    }
    
    func monthAbbreviationFromInt(_ month: Int) -> String {
        let ma = Calendar.current.shortMonthSymbols
        return ma[month - 1]
    }
    
    var body: some View {
        GeometryReader { reader in
            ForEach(self.measurements) { measurement in
                Path { p in
                    let dWidth = self.dayWidth(reader.size.width, count: 365)
                    let dHeight = self.degreeHeight(reader.size.height, range: 110)
                    
                    let dOffset = self.dayOffset(measurement.date, dWidth: dWidth)
                    let lowOffset = self.tempOffset(measurement.low, degreeHeight: dHeight)
                    let highOffset = self.tempOffset(measurement.high, degreeHeight: dHeight)
                    
                    p.move(to: CGPoint(x: dOffset, y: reader.size.height - lowOffset))
                    p.addLine(to: CGPoint(x: dOffset, y: reader.size.height - highOffset))
                }
            .stroke(LinearGradient(
                gradient: self.tempGradient,
                startPoint: UnitPoint(x: 0, y: 1),
                endPoint: UnitPoint(x: 0, y: 0)))
            }
            ForEach(-1..<11) { line in
                Group {
                    Path { path in
                        let y = self.tempLabelOffset(line, height: reader.size.height)
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: reader.size.width, y: y))
                    }.stroke(line == 0 ? Color.black : Color.gray)
                    if line >= 0 {
                        Text("\(line * 10)°")
                            .offset(x: 10, y: self.tempLabelOffset(line, height: reader.size.height))
                    }
                }
            }
            ForEach(1..<13) { month in
                Group {
                    Path { path in
                        let dOffset = self.offsetFirstOfMonth(month, width: reader.size.width)
                        
                        path.move(to: CGPoint(x: dOffset, y: reader.size.height))
                        path.addLine(to: CGPoint(x: dOffset, y: 0))
                    }.stroke(Color.gray)
                    Text("\(self.monthAbbreviationFromInt(month))")
                        .font(.subheadline)
                    .offset(
                        x: self.offsetFirstOfMonth(month, width: reader.size.width) + 5 * self.dayWidth(reader.size.width, count: 365),
                        y: reader.size.height - 25
                    )
                }
            }
        }
    }
}

struct TemperatureChart_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureChart(measurements: WeatherInformation()!.stations[1].measurements)
    }
}
