//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 24/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import Foundation

enum PersistanceActionType{
    case add,remove
}

enum PersistanceManager{
    
    static private let userDefault = UserDefaults.standard;
    
    
    static func update(favorite : Follower , persistanceAction : PersistanceActionType , complition :@escaping (GFError?) -> Void){
        retriveFavourites { result in
            
            switch(result){
            case .success(let favorites):
                var retriveFavList = favorites
                
                switch(persistanceAction){
                case .add:
                    guard !retriveFavList.contains(favorite) else {
                        complition(.alreadyInFav)
                        return ;
                    }
                    
                    retriveFavList.append(favorite)
                    
                    break;
                case .remove:
                    retriveFavList.removeAll(where: {$0.login == favorite.login})
                    break;
                }
                
                complition(save(favourites: retriveFavList))
                
                break
            case .failure(let error):
                complition(error)
                break
            }
        }
    }
    
    
    static func retriveFavourites(completion : @escaping (Result<[Follower],GFError>) -> Void){
        guard let followers = userDefault.object(forKey: "favourits") as? Data else {
            completion(.success([]))
            return
        }
        
        do{
            let json = JSONDecoder()
            let followersList = try json.decode([Follower].self, from: followers)
            completion(.success(followersList))
        }
        catch{
            completion(.failure(.errorData))
        }
    }
    
    static func save(favourites:[Follower]) -> GFError? {
        do {
            let encode = JSONEncoder()
            let data = try encode.encode(favourites)
            userDefault.set(data, forKey: "favourits")
            return nil
        }
        catch {
            return .errorData
        }
    }
}
