//
//  APIService.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation
import RxSwift
import RxCocoa

struct APIService {
    
    private let session: URLSession
        
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    
    func fetchRecruitList() -> Single<Result<RecruitResponse, NetworkError>> {
        let request: URLRequest = SearchRouter.fetchRecruitList.asURLRequest()
        
        return session.rx.data(request: request)
            .asSingle()
            .map { data in
                do {
                    let response = try JSONDecoder().decode(RecruitResponse.self, from: data)
                    return .success(response)
                } catch {
                    return .failure(.decodingError)
                }
            }
            .catch { error in
                return .just(.failure(.networkError))
            }
    }
    
    func fetchCompanyList() -> Single<Result<CompanyResponse, NetworkError>> {
        let request: URLRequest = SearchRouter.fetchCompanyList.asURLRequest()
        
        return session.rx.data(request: request)
            .asSingle()
            .map { data in
                do {
                    
                    let response = try JSONDecoder().decode(CompanyResponse.self, from: data)
                    return .success(response)
                    
                } catch {
                    return .failure(.decodingError)
                }
            }.catch { error in
                return .just(.failure(.networkError))
            }
    }
    
    
}
