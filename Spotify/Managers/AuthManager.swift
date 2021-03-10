//
//  AuthManager.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import Foundation

final class AuthManager{
    
    static let shared = AuthManager()
    
    private var refreshingToken = false
    
    struct Constants {
        static let base = "https://accounts.spotify.com/authorize?"
        static let clientID = "9e566d9ca6e544ad85730ecd7d6a5fba"
        static let clientSecret = "4fd704f7f36743589839311928d67b73"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirect_uri = "https://imranthemadgamer.wixsite.com/sinbad"
        static  let scope = "user-read-private%20user-read-private%20user-library-modify%20user-library-read%20playlist-modify-public%20playlist-modify-private%20playlist-read-private%20playlist-read-collaborative"
    }
    
    public var signInURL: URL? {
        
        let string = "\(Constants.base)response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scope)&redirect_uri=\(Constants.redirect_uri)&show_dialog=true"
        
        return URL(string: string)
    }
    
    private init(){}
    
    var isSignedIn:Bool{
        return accessToken != nil
    }
    
    private var accessToken : String?{
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private var refreshToken: String?{
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    private var tokenExpirationDate: Date?{
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
  
    
    
    private var shouldRefreshToken:Bool{
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes : TimeInterval = 300
        let setTime = currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
        print("setTime:\(setTime)")
        return setTime
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
            URLQueryItem(name: "redirect_uri", value: Constants.redirect_uri),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
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
                // let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(result: result)
                print("Success: \(result)")
                completion(true)
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
        
        
    }
    
    
    private var onRefreshBlock = [((String)->Void)]()
    
    public func withValidToken(completion:@escaping(String)->Void){
       
        guard !refreshingToken else {
            // Append the completion
            onRefreshBlock.append(completion)
            return
        }
        
        if shouldRefreshToken{
            //Refresh
            refreshIfNeeded { [weak self]success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
            
        }else if let token = accessToken {
            completion(token)
        }
    }
    
    
    public func refreshIfNeeded(completion: @escaping (Bool) -> Void ){
        
        guard !refreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            return
        }
        
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        // Refresh the token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
            self?.refreshingToken = false
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do{
                // let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.onRefreshBlock.forEach{$0(result.access_token)}
                self?.onRefreshBlock.removeAll()
                print("Successfully refresh")
                self?.cacheToken(result: result)
                print("Success: \(result)")
                completion(true)
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
        
        
        
        
    }
    private func cacheToken(result : AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
            
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)),
                                       forKey: "expirationDate")
    }
}
