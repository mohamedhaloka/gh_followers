import Foundation
import UIKit


class NetworkManager{
    static let shared           = NetworkManager()
    private let baseUrl         = "https://api.github.com/"
    let cache : NSCache         = NSCache<NSString,UIImage>()
    
    
    private init(){}
    
    public func getFollowers(for username : String , pageNum : Int, completed: @escaping (Result<[Follower],GFError>)->Void){
        let endpoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(pageNum)"
        
        print(endpoint)
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.urlError))
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                completed(.failure(.makeRequestEror))
                return
            }
            
            guard let response = response as? HTTPURLResponse? , response?.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }
            
            guard let data = data  else {
                completed(.failure(.errorData))
                return
            }

            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }
            catch{
                completed(.failure(.errorData))

            }
        }
        
        urlSession.resume()
    }


    public func getUserData(for username : String , completed: @escaping (Result<User,GFError>)->Void){
        let endpoint = baseUrl + "users/\(username)"
        
        print(endpoint)
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.urlError))
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                completed(.failure(.makeRequestEror))
                return
            }
            
            guard let response = response as? HTTPURLResponse? , response?.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }
            
            guard let data = data  else {
                completed(.failure(.errorData))
                return
            }

            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userInfo = try decoder.decode(User.self, from: data)
                completed(.success(userInfo))
            }
            catch{
                completed(.failure(.errorData))

            }
        }
        
        urlSession.resume()
    }
}
