//
//  WeatherManager.swift
//  Clima
//
//  Created by Shubham Mishra on 25/04/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "af3bf256766580cc46a6079dbbad91da"
    
    func fetchWeatherData(ofCity city: String) {
        let params = ["q":city, "appid":apiKey, "units":"metric"]
        
        AF.request(url, method: .get, parameters: params).responseDecodable(of: WeatherData.self) { (response) in
            if response.error != nil {
                print("Error in fetching weather data: \(response.error)")
                return
            }
            
            print(response.value)
            
            guard let decodedData = response.value else {
                fatalError("Error decoding data")
            }
            
            print(decodedData.name)
            print(decodedData.main.temp)
            print(decodedData.weather[0].id)
            let conditionName = getConditionName(weatherId: decodedData.weather[0].id)
            print(conditionName)
            
        }
    }
    
    func getConditionName(weatherId: Int) -> String {
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
}
