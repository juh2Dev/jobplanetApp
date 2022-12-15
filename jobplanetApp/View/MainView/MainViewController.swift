//
//  ViewController.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/10.
//

import UIKit
import RxSwift
import RxCocoa
import CoreMedia



class MainViewController: UIViewController {
    private var viewModel: MainViewModel
    
    private let disposeBag: DisposeBag = DisposeBag()

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var recruitTabButton: UIButton!
    @IBOutlet weak var companyTabButton: UIButton!
    
    @IBOutlet weak var recruitCollectionView: UICollectionView!
    @IBOutlet weak var companyTableView: UITableView!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = MainViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        recruitCollectionView.delegate = self
        binding()
        
    }
  
    
    private func binding(){
        
        // 처음 로딩할 때, 채용 목록 불러오기
        rx.viewWillAppear
            .take(1)
            .map { _ in () }
            .bind(to: viewModel.recruitTabButtonTapped)
            .disposed(by: disposeBag)
        
        // 채용 탭 클릭
        recruitTabButton.rx.tap
            .bind(to: viewModel.recruitTabButtonTapped)
            .disposed(by: disposeBag)
        
        //  채용 탭 클릭 ->  채용 콜렉션 뷰 보이기
        viewModel.recruitTabButtonTapped
            .asSignal()
            .emit(to: recruitCollectionView.rx.show)
            .disposed(by: disposeBag)
        
        //  채용 탭 클릭 -> 기업 테이블 뷰 숨기기
        viewModel.recruitTabButtonTapped
            .asSignal()
            .emit(to: companyTableView.rx.hide)
            .disposed(by: disposeBag)
        
        
        // 기업 탭 버튼 클릭
        companyTabButton.rx.tap
            .bind(to: viewModel.companyTabButtonTapped)
            .disposed(by: disposeBag)
        
        // 기업 탭 버튼 클릭 -> 기업 테이블 뷰 보이기
        viewModel.companyTabButtonTapped
            .asSignal()
            .emit(to: companyTableView.rx.show)
            .disposed(by: disposeBag)
        
        // 기업 탭 버튼 클릭 ->  채용 콜렉션 뷰 숨기기
        viewModel.companyTabButtonTapped
            .asSignal()
            .emit(to: recruitCollectionView.rx.hide)
            .disposed(by: disposeBag)
        
        
        // 채용탭, 기업탭 버튼 클릭하면 -> 검색어 지우기
        Observable
            .merge(
                viewModel.companyTabButtonTapped.asObservable(),
                viewModel.recruitTabButtonTapped.asObservable())
            .asSignal(onErrorSignalWith: .empty())
            .emit(to: searchTextField.rx.removeText)
            .disposed(by: disposeBag)

        
        // 검색창에 입력된 검색어 연결
        searchTextField.rx.text
          .bind(to: viewModel.searchWord)
          .disposed(by: disposeBag)
        
        
        // 키보드의 검색 버튼 클릭 (엔터)
        searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind(to: viewModel.searchTextFieldEditingDidEnd)
            .disposed(by: disposeBag)
        
        
       
        // cellData 들어오면 recruitCollectionView cell 만들기
        viewModel.recruitCollectionViewModel.cellData
            .drive(recruitCollectionView.rx.items(cellIdentifier: "RecruitCell",
                                                  cellType: RecruitCell.self)){ index, data, cell in
                cell.setData(data)
            }.disposed(by: disposeBag)
        
        
        
        
        // companyResponse 들어오면 companyTableView cell 만들기
        viewModel.companyTableViewModel.cellData
            .drive(companyTableView.rx.items){ tv, row, data in
                let index = IndexPath(row: row, section: 0)
                if let recruitCellData: RecommendRecruitCellData = RecommendRecruitCellData(item: data){
                    
                    let cell: RecommendRecruitCell = tv.dequeueReusableCell(withIdentifier: "RecommendRecruitCell", for: index) as? RecommendRecruitCell ?? RecommendRecruitCell()
                    cell.setData(recruitCellData)
                    return cell
                    
                } else if let companyCellData: CompanyCellData = CompanyCellData(item: data) {
                    let cell: CompanyCell = tv.dequeueReusableCell(withIdentifier: "CompanyCell", for: index) as? CompanyCell ?? CompanyCell()
                    cell.setData(companyCellData)
                    return cell
                    
                } else if let reviewCellData: ReviewCellData = ReviewCellData(item: data){
                    let cell: CompanyCell = tv.dequeueReusableCell(withIdentifier: "CompanyCell", for: index) as? CompanyCell ?? CompanyCell()
                    cell.setData(reviewCellData)
                    return cell
                }
                
                return UITableViewCell()
                
            }
            .disposed(by: disposeBag)
        
        // 채용 상세화면으로
        recruitCollectionView.rx.modelSelected(Recruit.self)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] recruit in
                self?.presentRecruitDatailView(recruit)
            }.disposed(by: disposeBag)
        
        
        // 기업 상세 화면으로
        companyTableView.rx.modelSelected(CellItem.self)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe{ [weak self] data in
                self?.presentCompanyDatailView(data)
            }
            .disposed(by: disposeBag)
        
        
        // 검색 결과가 없습니다.
        viewModel.noData
            .map{!$0}
            .bind(to: noDataLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        // 에러메시지 출력
        viewModel.errorMessage
            .subscribe(onNext: { [weak self] message in
                self?.showAlert("목록을 불러오는데 실패했습니다.", message)
            })
            .disposed(by: disposeBag)
    }
    
    // 채용 상세 화면으로
    func presentRecruitDatailView(_ recruit: Recruit){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let recruitDetailVC: RecruitDatailViewController = mainStoryboard.instantiateViewController(withIdentifier: "RecruitDatailViewController") as? RecruitDatailViewController {
            recruitDetailVC.recruit = recruit
             self.present(recruitDetailVC, animated: true, completion: nil)
        }
    }
    
    // 기업 상세 화면으로
    func presentCompanyDatailView(_ data: CellItem){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard (CompanyCellData(item: data) != nil )
                || (ReviewCellData(item: data) != nil) else { return }
        
        if let companyDetailVC: CompanyDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "CompanyDetailViewController") as? CompanyDetailViewController {
            companyDetailVC.data = data
            
            self.present(companyDetailVC, animated: true, completion: nil)
             
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }

        // 옆 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
}
