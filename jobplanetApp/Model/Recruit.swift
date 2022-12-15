//
//  Recruit.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation


// MARK: - Recruit
struct Recruit: Codable {
    let id: Int
    let title: String
    let reward: Int
    let appeal: String //tags
    let imageURL: String
    let company: Company

    enum CodingKeys: String, CodingKey {
        case id, title, reward, appeal
        case imageURL = "image_url"
        case company
    }
}
extension Recruit {
    init?(dic: [String: Any]){
        guard let id: Int = dic["id"] as? Int,
              let title: String = dic["title"] as? String,
              let reward: Int = dic["reward"] as? Int,
              let appeal: String = dic["appeal"] as? String,
              let image_url: String = dic["image_url"] as? String,
              let companyDic: [String : Any] = dic["company"] as? [String : Any],
              let company: Company = Company(dic: companyDic)
                
        else { return nil }
        
        self.init(id: id,
                  title: title,
                  reward: reward,
                  appeal: appeal,
                  imageURL: image_url,
                  company: company)
    }
}


