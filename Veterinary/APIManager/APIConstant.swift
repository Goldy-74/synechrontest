//
//  APIConstant.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation

struct APIConstant {
    public static let baseURL = "https://jsonkeeper.com/"
}

enum APIRequestEndPoint {
    
    case getConfiguration
    case getPets
    
    var endPoint: String{
        switch self {
        case .getConfiguration:
            return "b/19VA"
        case .getPets:
            return "b/QR29"
        }
    }
}
