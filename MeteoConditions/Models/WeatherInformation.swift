//
//  WeatherInformation.swift
//  MeteoConditions
//
//  Created by slava bily on 29/7/20.
//

import Foundation

class WeatherInformation {
  var stations: [WeatherStation]
  
  init?() {
    // Init empty array
    stations = []

    // Converter for date string
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/d/yyyy"

    // Get CSV data
    guard let csvData = getCsvAsString() else { return nil }
    
    var currentStationId = ""
    var currentStation: WeatherStation?
    // Parse each line
    csvData.enumerateLines { (line, _) in
      let cols = line.components(separatedBy: ",")
      if currentStationId != cols[0] {
        if let newStation = currentStation {
          if(newStation.name != "NAME") {
            self.stations.append(newStation)
          }
        }
        
        currentStationId = cols[0]
        let name = cols[1].replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ";", with: ",")
        let lat = Double(cols[2]) ?? 0
        let lng = Double(cols[3]) ?? 0
        let alt = Int((Double(cols[4]) ?? 0) * 3.28084) // m to ft.
        currentStation = WeatherStation(id: currentStationId, name: name, latitude: lat, longitude: lng, altitude: alt, measurements: [])
      }
      
      let date = dateFormatter.date(from: cols[5]) ?? dateFormatter.date(from: "1/1/2018")!
      let precip = Double(cols[6]) ?? 0
      let snow = Double(cols[7]) ?? 0
      let high = Double(cols[8]) ?? 0
      let low = Double(cols[9]) ?? 0
      let newData = DayInfo(date: date, precipitation: precip, snowfall: snow, high: high, low: low)
      
      currentStation?.measurements.append(newData)
    }
    // Add the last station read
    if let newStation = currentStation {
      self.stations.append(newStation)
    }
  }
  
  func getCsvAsString() -> String? {
    guard let fileURL = Bundle.main.url(forResource: "weather-data", withExtension: "csv") else { return nil }
    do {
      let csvData = try String(contentsOf: fileURL)
      return csvData
    } catch {
      return nil
    }
  }
}

