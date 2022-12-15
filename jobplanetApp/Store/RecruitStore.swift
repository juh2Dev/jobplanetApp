//
//  RecruitStore.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/15.
//

import Foundation
import RxSwift

struct RecruitStore {
    
    func fetchRecruitList() -> Single<Result<RecruitResponse, NetworkError>>{
        APIService().fetchRecruitList()
    }
    
    func getRecruitList(_ result: Result<RecruitResponse, NetworkError>) -> [Recruit] {
        guard case .success(let reponse) = result else {
            return []
        }
        return reponse.recruitItems
    }
    
    func getRecruitErrorMessage(_ result: Result<RecruitResponse, NetworkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error.message
    }
    
    //채용 리스트를 검색어로 필터링
    func search(_ list: [Recruit], by searchWord: String) -> [Recruit] {
        if searchWord.isEmpty {
            return list
        }
        return list.filter {
            $0.title.contains(searchWord)
        }
    }
}
