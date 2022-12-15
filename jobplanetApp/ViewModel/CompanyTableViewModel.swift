//
//  CompanyTableViewModel.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/15.
//

import Foundation

import RxSwift
import RxCocoa

struct CompanyTableViewModel {
    
    let companyCellData: PublishSubject<[CellItem]> = PublishSubject<[CellItem]>()
    let cellData: Driver<[CellItem]>
    
  
    init(){
        
        //cellData = blogCellData를 드라이버로 바꾼거
        self.cellData = companyCellData
            .asDriver(onErrorJustReturn: [])
        
    }
    
    
}
