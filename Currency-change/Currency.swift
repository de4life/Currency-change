//
//  Currency.swift
//  Currency-change
//
//  Created by Артур Агеев on 02.06.2023.
//

import Foundation
import Alamofire

struct Currency: Codable {
    var success: Bool
    var base: String
    var date: String
    var rates = [String: Double]()
}

func apiRequest(url:String, completion: @escaping (Currency) -> ()) {
    
    Session.default.request(url).responseDecodable(of: Currency.self) { response in
        switch response.result {
        case.success(let curruncies):
            print(curruncies)
            completion(curruncies)
        case .failure(let error):
            print(error)
        }
    
    }
    
}
