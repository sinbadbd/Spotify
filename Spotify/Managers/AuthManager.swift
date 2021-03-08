//
//  AuthManager.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import Foundation

final class AuthManager{
    
    static let shared = AuthManager()
    
    
    struct Constants {
        static let base = "https://accounts.spotify.com/authorize?"
        static let clientID = "9e566d9ca6e544ad85730ecd7d6a5fba"
        static let clientSecret = "4fd704f7f36743589839311928d67b73"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirect_uri = "https://imranthemadgamer.wixsite.com/sinbad"
        static  let scope = "user-read-private"
    }
    
    public var signInURL: URL? {
 
        let string = "\(Constants.base)response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scope)&redirect_uri=\(Constants.redirect_uri)&show_dialog=true"
        
        return URL(string: string)
    }
    
    private init(){}
    
    var isSignedIn:Bool{
        return false
    }
    
    private var accessToken : String?{
        return nil
    }
    private var refreshToken: String?{
        return nil
    }
    private var tokenExpirationDate: Data?{
        return nil
    }
    private var shouldRefreshToken:Bool?{
        return false
    }
    
    
    public func exchangeCodeForToken(code: String, completion:@escaping( (Bool)) -> Void){
        // GET TOKEN
        
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirect_uri)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
       
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedData() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do{
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print(json)
            }catch{
                completion(false)
            }
        }
        task.resume()
        
        
    }

    public func refreshAccessToken(){
        
    }
    private func cacheToken(){
        
    }
}
