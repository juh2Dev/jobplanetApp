//
//  Company.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation

// MARK: - Company
struct Company: Codable {
    let name: String
    let logoPath: String
    let ratings: [Rating]

    enum CodingKeys: String, CodingKey {
        case name
        case logoPath = "logo_path"
        case ratings
    }
    
    var highestRating: Double? {
        return ratings.map {
            $0.rating
        }.max()
    }
}
extension Company {
    init?(dic: [String: Any]){
        guard let logoPath: String = dic["logo_path"] as? String,
              let name: String = dic["name"] as? String,
              let ratingsDic: [[String : Any]] = dic["ratings"] as? [[String : Any]] else { return nil }
        
        let ratings: [Rating] = ratingsDic.map { ratingDic in
            Rating(dic: ratingDic)
        }.compactMap{$0}
        
        self.init(name: name, logoPath: logoPath, ratings: ratings)
        
    }
}


// MARK: - Rating
struct Rating: Codable {
    let type: String
    let rating: Double
}
extension Rating {
    init?(dic: [String: Any]){
        guard let type: String = dic["type"] as? String,
              let rating: Double = dic["rating"] as? Double
        else { return nil }
        
        self.init(type: type, rating: rating)
        
    }
}
