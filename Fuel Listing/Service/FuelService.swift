//
//  FuelService.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import Foundation

class FuelService {
    
    // Singleton
    static let shared = FuelService()
    
    // Token
    let apikey = "apikey 3qKxFu5bvXZy7i1cdC23kr:4Qsq1xAnYCmQclDqau3O5v"
    
    // EndPoint
    enum AuthServiceEndPoint: String {
        case BASE_URL = "https://api.collectapi.com/gasPrice"
    }
    // URL
    private let dieselUrl = "\(AuthServiceEndPoint.BASE_URL.rawValue)/turkeyDiesel"
    private let gasolineUrl = "\(AuthServiceEndPoint.BASE_URL.rawValue)/turkeyGasoline"
    
    func fetchPrices(fuelType: String, city: String, district: String, completion: @escaping ([String]?) -> Void) {
        
        var urlWithCity = String()
        
        if fuelType == "diesel" {
            urlWithCity = "\(dieselUrl)?district=\(district)&city=\(city)"
        }
        if fuelType == "gasoline" {
            urlWithCity = "\(gasolineUrl)?district=\(district)&city=\(city)"
        }
        
        let headers = [
          "content-type": "application/json",
          "authorization": apikey
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: urlWithCity)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
              print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
              print(httpResponse as Any)
          }
        })

        dataTask.resume()
    }
    func loadJson(filename fileName: String, completion: @escaping ([Result]?) -> (Void)) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json"){
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Cities.self, from: data)
                completion(jsonData.result)
            } catch {
                print("error: \(error)")
                completion(nil)
            }
        }
        
    }
}
