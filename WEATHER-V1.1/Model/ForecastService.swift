//
//  ForecastService.swift
//  WEATHER-V1.1
//
//  Created by Nazim Uddin on 2/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
// APIURL: https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=e940750330c2e23b915410d54ffbcc6c


import Foundation
class ForecastService
{
    let forecastAPIKey:String
    let forecastBaseURL:URL!
    init(APIKey:String) {
        self.forecastAPIKey = APIKey
        self.forecastBaseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?")
    }
    func getForecast(latitude:Double, longitutd:Double, completion: @escaping (CurrentWeatherName,CurrentWeatherTemp)->Void){
        if let forecastURL = URL(string: "\(forecastBaseURL!)lat=\(latitude)&lon=\(longitutd)&appid=\(forecastAPIKey)") {
            let networkProcessor = NetworkProcessor(url: forecastURL)
            networkProcessor.downloadJSONFromURL { (jsonDictionary) in
                let name = CurrentWeatherName(name: (jsonDictionary["name"] as? String)!)
                if let currentWeatherDictionary = jsonDictionary["main"] as? [String:Any] {
                    let currentWeather = CurrentWeatherTemp(json: currentWeatherDictionary)
                    completion(name,currentWeather)
                }
                
            }
        }
    }
}
