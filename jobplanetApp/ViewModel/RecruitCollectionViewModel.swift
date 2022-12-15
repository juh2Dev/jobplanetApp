//
//  RecruitCollectionViewModel.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation
import RxSwift
import RxCocoa

struct RecruitCollectionViewModel {
    
    let RecruitCellData: PublishSubject<[Recruit]> = PublishSubject<[Recruit]>()
    let cellData: Driver<[Recruit]>
    
    init(){
        
        //cellData = blogCellData를 드라이버로 바꾼거
        self.cellData = RecruitCellData
            .asDriver(onErrorJustReturn: [])
    }
    
    
}
