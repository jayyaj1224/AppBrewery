//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var SearchTextField: UITextField!
    
    var weatherManager  = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        SearchTextField.delegate = self
    }
    
    
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
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
        
//        print("City Name: \(weather.cityName)")
//        print("Temperature: \(weather.temperatureString) Celsius")
//        print("Description: \(weather.description) ")
    }
    
    func didFailwithError(error: Error) {
        print("sorry ;; ")
    }
    
}
