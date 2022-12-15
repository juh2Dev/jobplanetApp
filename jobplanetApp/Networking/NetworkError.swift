//
//  NetworkError.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation

enum NetworkError: Error {
    case networkError
    case decodingError
    
    var message: String {
        switch self {
        
        case .decodingError:
            //return "데이터 Decoding 중 에러가 발생했습니다."
            return "요청을 처리할 수 없습니다."
            
        case .networkError:
            return "네트워크 상태를 확인해주세요."
        
        }
    }
}



