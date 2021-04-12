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
        static let baseURL = "https://api.spotify.com/v1/"
        //        static let UrlME = baseURL+ "/me"
    }
    
    static let shared = ApiCaller()
    
    private init() {}
    
    // SEARCH API
    public func searchPlayList(with query: String,completion:@escaping(Result<[SearchResult],Error>) -> Void) {
        createRequest(url: URL(string: Constants.baseURL + "search?type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    
//                    let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    
                    var searchResult : [SearchResult] = []
                     
                    searchResult.append(contentsOf: result.albums.items.compactMap({ .albums(mode: $0)}))
                    searchResult.append(contentsOf: result.artists.items.compactMap({ .artists(mode: $0)}))
                    searchResult.append(contentsOf: result.tracks.items.compactMap({ .tracks(mode: $0)}))
                    searchResult.append(contentsOf: result.playlists.items.compactMap({ .playlists(mode: $0)}))
                    
                    completion(.success(searchResult))
                    print(result)
                    debugPrint(result)
                    debugPrint(searchResult)
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
//                    completion(false)
                    debugPrint(APIError.failedToGetData)
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: GET CETEGPRYS
    public func getCategories(completion: @escaping(Result<Categories, Error>)-> Void){
        createRequest(url: URL(string: Constants.baseURL + "browse/categories"), type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    
                    //                     let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories!))
//                    print(result)
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
                    //                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    //MARK: GET CATEGORY PLAYLIST
    public func getCategoriesPlayList(category:Category,completion: @escaping(Result<[PlayList], Error>)-> Void){
        createRequest(url: URL(string: Constants.baseURL + "browse/categories/\(category.id ?? "")/playlists"), type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    
                    // let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(FeaturePlaylistResponse.self, from: data)
                    completion(.success(result.playlists.items))
                    print(result)
 
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
                    debugPrint(error)
                    // completion(false)
                }
            }
            task.resume()
        }
    }
    
    
    
    //MARK: GEt ALBUM ITEM
    public func getAlbumDetails(from album : Album,completion:@escaping(Result<AlbumDetilsResponse,Error>)->Void){
        createRequest(url: URL(string: Constants.baseURL + "albums/\(album.id ?? "")"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    
                    //  let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(AlbumDetilsResponse.self, from: data)
                    completion(.success(result))
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
                    //                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: GEt PLAYLIST ITEM
    public func getPlayListDetails(from playList : PlayList,completion:@escaping(Result<PlayListDetailsResponse,Error>)->Void){
        createRequest(url: URL(string: Constants.baseURL + "playlists/\(playList.id )"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    
                    // let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(PlayListDetailsResponse.self, from: data)
                    completion(.success(result))
                    //                    print(result)
                    
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
                    debugPrint(error)
                    //                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    
    
    //MARK: USER PROFILE CALL
    public func getCurrentUserProfile( completion:@escaping (Result<UserProfile, Error>)-> Void){
        createRequest(url: URL(string: Constants.baseURL + "me"), type: .GET) { baseRequest in
            
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
    
    
    // MARK:: Get All New Releases
    public func getAllNewReleases(completion:@escaping(Result<NewReleasesResponse, Error>)->Void){
        createRequest(url: URL(string: Constants.baseURL + "browse/new-releases?offset=0&limit=50"), type: .GET) { result in
            
            let task = URLSession.shared.dataTask(with: result) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    
                    // let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    // print("result:::\(result)")
                    completion(.success(result))
                    
                    
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
                    //                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    //MARK:: Get All Featured Playlists
    public func GetAllFeaturedPlaylists(completion:@escaping(Result<FeaturePlaylistResponse,Error>)->Void){
        createRequest(url: URL(string: Constants.baseURL + "browse/featured-playlists"), type: .GET) { result in
            
            let task = URLSession.shared.dataTask(with: result) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    
                    //let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(FeaturePlaylistResponse.self, from: data)
                    //print("result:::====\(result)")
                    completion(.success(result))
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
                    //                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    
    //MARK:: Get All Categories
    
    
    //MARK:: Get A Category
    
    
    //MARK:: Get a Category's Playlists
    
    
    //MARK:: Get Recommendations
    public func GetRecommendations(geners:Set<String>,completion:@escaping(Result<RecommandationResonse,Error>)->Void){
        let seeds = geners.joined(separator: ",")
        createRequest(url: URL(string: Constants.baseURL + "recommendations?seed_genres=\(seeds)"), type: .GET) { result in
            
            let task = URLSession.shared.dataTask(with: result) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    
                    //let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(RecommandationResonse.self, from: data)
                    //print("result:::\(result)")
                    completion(.success(result))
                    
                    
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
                    //                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    //MARK://
    
    public func GetRecommandationGenres(completion:@escaping(Result<AvailableGenreSeeds,Error>)->Void){
        createRequest(url: URL(string: Constants.baseURL + "recommendations/available-genre-seeds"), type: .GET) { result in
            
            let task = URLSession.shared.dataTask(with: result) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    
                    //let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let result = try JSONDecoder().decode(AvailableGenreSeeds.self, from: data)
                    // print("result:::\(result)")
                    completion(.success(result))
                    
                    
                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                    print(error.localizedDescription)
                    //                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    // MARK:: CREATE AUTH REQUEST WITH HEADER
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
