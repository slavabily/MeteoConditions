//
//  DayInfo.swift
//  MeteoConditions
//
//  Created by slava bily on 29/7/20.
//

import Foundation

struct DayInfo : Identifiable {
    var date: Date
    var precipitation: Double
    var snowfall: Double
    var high: Double
    var low: Double
    var humidity: Double
    
    var id: Date {
        return date
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        return dateFormatter.string(from: date)
    }
}
