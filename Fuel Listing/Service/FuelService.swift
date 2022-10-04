//
//  FuelService.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import Alamofire
import Foundation

class FuelService {
    
    // Singleton
    static let shared = FuelService()
    
    // Token
    let apikey = "apikey 5aqVPV0mHXssiwYX2jgzhN:4adzrTDsO5ny4Id4UGm4W3"
    
    // EndPoint
    enum endPoint: String {
        case BASE_URL = "https://api.collectapi.com/gasPrice"
    }
    // URL
    private let dieselUrl = "\(endPoint.BASE_URL.rawValue)/turkeyDiesel"
    private let gasolineUrl = "\(endPoint.BASE_URL.rawValue)/turkeyGasoline"
    
    
    func fetchPricesDiesel(city: String, district: String, completion: @escaping (Diesel?) -> Void) {
        
        let urlWithCity = URL(string: "\(dieselUrl)?district=\(district)&city=\(city)")

        
        let headers: HTTPHeaders = [
            "Connection": "keep-alive",
            "content-Type": "application/json",
            "authorization": apikey
        ]
        AF.request(urlWithCity!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Diesel.self) { response in
            switch response.result {
                
            case .success(let value):
                completion(value)
                
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
    func fetchPricesGasoline(city: String, district: String, completion: @escaping (Gasoline?) -> Void) {
        
        var urlWithCity: URL!
        
        urlWithCity = URL(string: "\(gasolineUrl)?district=\(district)&city=\(city)") 
        
        let headers: HTTPHeaders = [
            "Connection": "keep-alive",
            "authorization": apikey
        ]
        
        AF.request(urlWithCity!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseDecodable(of: Gasoline.self) { response in
            switch response.result {
                
            case .success(let value):
                completion(value)
                
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
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

