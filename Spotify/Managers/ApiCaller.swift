//
//  ApiCaller.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import Foundation

final class ApiCaller{
    enum HTTPMethod : String{
        case GET
        case POST
    }
    
    enum APIError : Error {
        case failedToGetData
    }
    struct Constants {
        static let baseURL = "https://api.spotify.com/v1"
    }
    
    static let shared = ApiCaller()
    
    private init() {}
    
    
    public func getCurrentUserProfile( completion:@escaping (Result<UserProfile, Error>)-> Void){
        createRequest(url: URL(string: Constants.baseURL + "/me"), type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    
//                    let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                   
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                    print(result)
                    
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
//                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    private func createRequest(
        url:URL?,
        type: HTTPMethod,
        completion:@escaping(URLRequest)->Void){
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
