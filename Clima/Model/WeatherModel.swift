//
//  WeatherModel.swift
//  Clima
//
//  Created by Shubham Mishra on 25/04/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let city: String
    let temp: Double
    let weatherId: Int
    var conditionName: String {
        switch weatherId {
        case 200..<300:
            return "cloud.bolt.rain"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<600:
            return "cloud.heavyrain"
        case 600..<700:
            return "cloud.snow"
        case 700..<800:
            return "smoke"
        case 801..<900:
            return "cloud"
        default:
            return "sun.max"
        }
    }
    var tempString: String {
        String(format: "%.0f", temp.rounded())
    }
}
