//
//  WeatherStation.swift
//  MeteoConditions
//
//  Created by slava bily on 29/7/20.
//

import Foundation

struct WeatherStation: Identifiable {
  var id: String
  var name: String
  var latitude: Double
  var longitude: Double
  var altitude: Int
  var measurements: [DayInfo]
    
  func measurementsInMonth(_ month: Int) -> [DayInfo] {
    return measurements.filter {
      return Calendar.current.component(.month, from: $0.date) == month
    }
  }
  
  var lowTemperatureForYear: Double {
    measurements.min(by: { $0.low < $1.low })!.low
  }
  
  var highTemperatureForYear: Double {
    measurements.max(by: { $0.high < $1.high })!.high
  }
}
