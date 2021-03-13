//
//  WeatherManager.swift
//  Clima
//
//  Created by JAY LEE on 2021/03/12.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailwithError(error: Error)
}

class WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4b43d83f32775ed4aecf1dba81dca345&units=metric"
    func fetchWeather(cityNmae: String) {
        let urlString = "\(weatherURL)&q=\(cityNmae)"
        performRequest(with: urlString)
    }
    func fetchWeather(latitude: Double, longitude: Double){
        let urlString = "\(weatherURL)&\(latitude)&\(longitude)"
        performRequest(with: urlString)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailwithError(error: error!)
                    return
                }
                if let safeData = data {
                    let weather = self.parseJSON(weatherData: safeData)
                    if let safeWeather = weather {
                        self.delegate?.didUpdateWeather(self, safeWeather)
                    } else { print("safeWeather ") }
                }else { print("safeData ") }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                                                //  여기에는 Type            여기에는 Data
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let weatherParsed = WeatherModel(conditionId: id, cityName: name, temperatureDouble: temp, description: description)
            return weatherParsed
        } catch {
            self.delegate?.didFailwithError(error: error)
            return nil
        }
    }
}



