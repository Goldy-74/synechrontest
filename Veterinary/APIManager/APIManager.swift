//
//  APIManager.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation

class APIManager {
    
    //MARK: - Var(s)
    public static let shared = APIManager()
    
    //MARK: - Calling Get API
    func callService<T: Codable>(endPoint : APIRequestEndPoint, success: @escaping ((T) -> Void), fail: @escaping ((String) -> Void)){
        if Reachability.shared.isConnected == false {
            fail("No internet available!")
            return
        }
        let urlString = APIConstant.baseURL + endPoint.endPoint
        
        let url = URL(string: urlString)
        guard let urlObj = url else { return }
        let session = URLSession.shared
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET"
        request.addValue ( "application/json ", forHTTPHeaderField : "Accept" )
        let task: URLSessionDataTask = session.dataTask(with : request, completionHandler: {
            data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let json = try decoder.decode(T.self, from: data)
                success(json)
            } catch{
                fail("Something went wrong, Please try again later.")
            }
        })
        task.resume ()
    }
}
    
