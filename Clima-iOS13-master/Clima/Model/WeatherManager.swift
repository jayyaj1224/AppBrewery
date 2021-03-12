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
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
//        1. Create URL: url이 잘못 입력될 수 있기 때문에, optional
        guard let url = URL(string: urlString) else {return}
        
//        2. Create URL Session
        let session = URLSession(configuration: .default)
        
//        3. Give the session a task
        let task = session.dataTask(with: url,completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        
//        4. Start the task
        task.resume()
        
    }
}
