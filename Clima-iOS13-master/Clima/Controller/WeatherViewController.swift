//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var SearchTextField: UITextField!
    
    var weatherManager  = WeatherManager()
    let ourlocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        SearchTextField.delegate = self
        
        ourlocationManager.delegate = self
        ourlocationManager.requestWhenInUseAuthorization()
        ourlocationManager.requestLocation()
    }
    
    @IBAction func renewLocation(_ sender: Any) {
        ourlocationManager.requestLocation()
    }
}

// Extension 을 이용해서
//UITextFieldDelegate, WeatherManagerDelegate 두개의 프로토콜을 나누어 정리
//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        SearchTextField.endEditing(true) // return 후 키보드 감추기
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SearchTextField.endEditing(true)
        return true //입력된 필드에서 바로 true를 리턴하여, 해당 함수 실행
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // hey VC, the user stoped editing
        guard let city = SearchTextField.text else {return}
        weatherManager.fetchWeather(cityNmae: city)
        SearchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // hey the user start editing. should I allow?
        // User가 잘못된 값을 입력하거나, 아예 하지 않은 경우
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Type something here"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            print(weather.cityName, weather.description ,weather.temperatureString)
        }
    }
    func didFailwithError(error: Error) {
        print("didFailwithErorr ")
    }
}


//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let gotLocation = locations.last {
            ourlocationManager.stopUpdatingLocation()
            let lat = gotLocation.coordinate.latitude
            let lon = gotLocation.coordinate.longitude
            print(lat,lon)
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
     
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("sorry")
    }
}
