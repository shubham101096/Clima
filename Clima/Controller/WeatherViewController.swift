//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        searchTextField.placeholder = "Type city..."
        weatherManager.delegate = self
        
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
}

//MARK: - UITextFieldDelegate Methods

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text != "" {
                return true
            }
        }
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.fetchWeatherData(ofCity: textField.text!)
        textField.text = ""
    }
}

//MARK: - WeatherManagerDelegate Methods

extension WeatherViewController: WeatherManagerDelegate {
    
    func updateWeather(_ weatherManager: WeatherManager, _ weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
            self.temperatureLabel.text = weatherModel.tempString
            self.cityLabel.text = weatherModel.city
        }
    }
    func didFailWithError(_ weatherManager: WeatherManager, _ error: String) {
        print(error)
    }
}

