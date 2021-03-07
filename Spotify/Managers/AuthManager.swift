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
        static let clientID = "9e566d9ca6e544ad85730ecd7d6a5fba"
        static let clientSecret = "4fd704f7f36743589839311928d67b73"
    }
    
    public var signInURL: URL? {
        let scope = "user-read-private"
        let redirect_uri = "https://imranthemadgamer.wixsite.com/sinbad"
        let base = "https://accounts.spotify.com/authorize?"
        let string = "\(base)response_type=code&client_id=\(Constants.clientID)&scope=\(scope)&redirect_uri=\(redirect_uri)&show_dialog=true"
        
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
    
    
    public func shouldRefreshToken(code: String, completion:@escaping( (Bool)) -> Void){
        // GET TOKEN
    }

    public func refreshAccessToken(){
        
    }
    private func cacheToken(){
        
    }
}
