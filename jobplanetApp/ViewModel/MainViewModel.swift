//
//  MainViewModel.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
    
    let recruitCollectionViewModel: RecruitCollectionViewModel = RecruitCollectionViewModel()
    let companyTableViewModel: CompanyTableViewModel = CompanyTableViewModel()
    
    // 검색창 입력 값 (검색어)
    let searchWord: PublishRelay<String?> = PublishRelay<String?>()
    
    // 검색버튼 클릭(엔터)
    let searchTextFieldEditingDidEnd: PublishRelay<Void> = PublishRelay<Void>()
    
    
    // 채용 탭 버튼 클릭
    let recruitTabButtonTapped: PublishRelay<Void> = PublishRelay<Void>()
    
    // 회사 탭 버튼 클릭
    let companyTabButtonTapped: PublishRelay<Void> = PublishRelay<Void>()
    
    
    
    // 검색 결과 없습니다.
    let noData: Observable<Bool>
    
    let errorMessage: Observable<String>
    
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    
    init(_ recruitStore: RecruitStore = RecruitStore(),
         _ companyStore: CompanyStore = CompanyStore()) {
        let noSearchedList = BehaviorSubject<Bool>(value: false)
        
        
        // 선택된 탭 버튼 (채용/ 회사)
        let selectedTab: Observable<TabType> = Observable.merge (
            recruitTabButtonTapped.map { _ in TabType.recruit },
            companyTabButtonTapped.map { _ in TabType.company }
        )
        
        
        
        // -------  검색  ------- //
        
        // 검색 버튼 클릭 시, 검색어 보내기
        // withLatestFrom: tap 이벤트가 발생 했을 때 검색어를 방출
        let shouldSearch: Observable<String> = searchTextFieldEditingDidEnd
            .withLatestFrom(searchWord) { $1 ?? "" }
        //.filter{ !$0.isEmpty } //빈값은 보내지마
            .distinctUntilChanged() //동일한 값 계속해서 보내지 않도록
        
        let shouldSearchInSelectedTab:Observable<(TabType, String)> = shouldSearch
            .withLatestFrom(selectedTab){ searchWord, tab  in
                (tab, searchWord)
            }
            .share()
        
        // 채용을 검색
        let shouldSearchRecruit: Observable<String> = shouldSearchInSelectedTab
            .filter { tab, _ in
                tab == .recruit
            }.map { $1 }
        
        // 회사를 검색
        let shouldSearchCompany: Observable<String> = shouldSearchInSelectedTab
            .filter { tab, _ in
                tab == .company
            }.map { $1 }
        
        
        // ---------  채용 목록 가져오기  --------- //
        
        // 채용탭을 누르거나, 검색했음 -> 채용목록 가져오기
        let fetchRecruitList: Observable<String> = Observable.merge (
            recruitTabButtonTapped.map { _ in "" },
            shouldSearchRecruit
        )
        
        let fetchRecruitListResponse = fetchRecruitList
            .do(onNext: { searchWord in
                print(">>> Recruit searchWord: \(searchWord)")
            })
            .flatMapLatest { _ in
                recruitStore.fetchRecruitList()
            }
            .share()
        
        
        // 요청 성공
        let recruitList = fetchRecruitListResponse
            .compactMap(recruitStore.getRecruitList)
        
        
        // 요청 실패
        let recruitErrorMessage = fetchRecruitListResponse
            .compactMap(recruitStore.getRecruitErrorMessage)
        
        
        // 채용 리스트를 검색어로 필터링하고( == 검색), 채용 콜렉션뷰에게 넣어주기
        Observable
            .combineLatest(recruitList, fetchRecruitList, resultSelector: recruitStore.search)
            .do(onNext: { list in
                noSearchedList.onNext(list.isEmpty)
            })
            .bind(to: recruitCollectionViewModel.RecruitCellData)
            .disposed(by: disposeBag)
                
                
        // -------  기업 목록 가져오기  ------- //
        
        // 기업탭을 누르거나, 검색했음 -> 기업목록 가져오기
        let fetchCompanyList: Observable<String> = Observable.merge(
            companyTabButtonTapped.map{ _ in "" },
            shouldSearchCompany
        )
        
        let fetchCompanyListResponse = fetchCompanyList
        .do(onNext: { searchWord in
            print(">>> Company searchWord: \(searchWord)")
        })
        .flatMapLatest { _ in
            companyStore.fetchCompanyList()
        }
        .share()
        
        // 요청 성공
        let companyCellItemList = fetchCompanyListResponse
            .compactMap(companyStore.getCompanyCellItems)
        
        // 검색 결과 없음 띄워주기
        Observable
            .combineLatest(companyCellItemList, fetchCompanyList, resultSelector: companyStore.search)
            .do(onNext: { list in
                noSearchedList.onNext(list.isEmpty)
            })
                .bind(to: companyTableViewModel.companyCellData)
                .disposed(by: disposeBag)
                
        // 검색 결과 없음 띄워주기
        noData = noSearchedList.distinctUntilChanged()
                
                
        // 요청 실패
        let companyErrorMessage = fetchCompanyListResponse
        .compactMap(companyStore.getCompanyErrorMessage)
        
       
        
        // 에러 메세지 띄워주기
        errorMessage = Observable.merge (
            recruitErrorMessage,
            companyErrorMessage
        )
    }
}
