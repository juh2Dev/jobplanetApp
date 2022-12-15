//
//  SearchRouter.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation


enum SearchRouter {
    case fetchRecruitList
    case fetchCompanyList
}
extension SearchRouter: APIRouter {
    var baseURL: URL {
        return URL(string: "https://jpassets.jobplanet.co.kr")!
    }
    
    var path: String {
        switch self {
        case .fetchRecruitList:
            return "/mobile-config/test_data_recruit_items.json"
        case .fetchCompanyList:
            return "/mobile-config/test_data_cell_items.json"
        }
    }
    
    var method: String {
        switch self {
        case .fetchRecruitList: return "GET"
        case .fetchCompanyList: return "GET"
        }
    }
    
    
}

