//
//  CurrentWeather.swift
//  WEATHER-V1.1
//
//  Created by Nazim Uddin on 2/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import Foundation
class CurrentWeatherTemp{
    let temp:Int?
    init(json:[String:Any]) {
        let tempDouble:Double = (json["temp"] as? Double)!
        self.temp = Int(tempDouble - 273.15)
    }
}
class CurrentWeatherName{
    let name:String?
    init(name:String) {
        self.name = name
    }
}
