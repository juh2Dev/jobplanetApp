//
//  RecruitResponse.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation

struct RecruitResponse: Codable {
    let recruitItems: [Recruit]

    enum CodingKeys: String, CodingKey {
        case recruitItems = "recruit_items"
    }
}


