//
//  ViewController.swift
//  WEATHER-V1.1
//
//  Created by Nazim Uddin on 2/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
// WEATHER-V1.1

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    
    let locationManager = CLLocationManager()
    var latitude:Double!
    var longitude:Double!
    
    let forecastAPIKey = "e940750330c2e23b915410d54ffbcc6c"
    override func viewDidLoad() {
        super.viewDidLoad()
        // ASK FOR PERMISSIONS
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
    }
    func getWeatherData(){
        //print("MY Location = \(latitude!) : \(longitude!)")
        let forecastService = ForecastService(APIKey: forecastAPIKey)

        forecastService.getForecast(latitude: self.latitude!, longitutd: self.longitude) { (city,currentWeather) in
            DispatchQueue.main.async {
                self.cityNameLbl.text = city.name
                self.tempLbl.text = "\(currentWeather.temp!)°"
            }
        }
    }

}
extension ViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue:CLLocationCoordinate2D = manager.location?.coordinate else {return}
        latitude = Double(locationValue.latitude)
        longitude = Double(locationValue.longitude)
        // GET WEATHER DATA FROM URL
        getWeatherData()
    }
}

