//
//  APIRouter.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation

protocol APIRouter {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
}
extension APIRouter {
    
    func asURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        return request
    }
}




