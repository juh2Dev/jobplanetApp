//
//  CompantStore.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/15.
//

import Foundation
import RxSwift

struct CompanyStore {
    
    func fetchCompanyList() -> Single<Result<CompanyResponse, NetworkError>> {
        APIService().fetchCompanyList()
    }
    
    func getCompanyCellItems(_ result: Result<CompanyResponse, NetworkError>) ->  [CellItem] {
        guard case .success(let response) = result else {
            return []
        }
        return response.cellItems
    }
    
    func getCompanyResponse(_ result: Result<CompanyResponse, NetworkError>) -> CompanyResponse? {
        
        guard case .success(let response) = result else {
            return nil
        }
        return response
    }
    
    
    func getCompanyErrorMessage(_ result: Result<CompanyResponse, NetworkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error.message
    }
    
    //기업 리스트를 검색어로 필터링
    func search(_ list: [CellItem], by searchWord: String) -> [CellItem] {
        if searchWord.isEmpty {
            return list
        }
        
        return list.filter { item in
            //(RecommendRecruitCellData(item: item) != nil) ||
            checkName(item, contains: searchWord)
        }
    }
    
    func checkName(_ item: CellItem, contains searchWord: String) -> Bool {
        guard let name :String = item.name else { return false }
        return name.contains(searchWord)
    }
}
