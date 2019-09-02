//
//  NetworkProcessor.swift
//  WEATHER-V1.1
//
//  Created by Nazim Uddin on 2/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
// APIURL: https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=e940750330c2e23b915410d54ffbcc6c

import Foundation
class NetworkProcessor
{
    lazy var session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    let url:URL
    init(url:URL) {
        self.url = url
    }
    
    func downloadJSONFromURL(_ completion:@escaping ([String:Any])->Void){
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                        case 200:
                            if let data = data{
                                do{
                                    let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                    completion((jsonDictionary as? [String:Any])!)
                                }catch{
                                    print("Error Json Data")
                                }
                               
                            }
                        break
                        default:
                            print("HTTP Response Code : \(httpResponse.statusCode)")
                    }
                }
            }else {
                print("Error : \(error?.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
