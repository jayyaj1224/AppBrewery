//
//  WeatherManager.swift
//  Clima
//
//  Created by JAY LEE on 2021/03/12.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4b43d83f32775ed4aecf1dba81dca345&units=metric"
    func fetchWeather(cityNmae: String) {
        let urlString = "\(weatherURL)&q=\(cityNmae)"
        print(urlString)
    }
}
