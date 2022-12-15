//
//  RecommendRecruitCell.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/15.
//

import UIKit
import RxSwift
import RxCocoa

class RecommendRecruitCell: UITableViewCell {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var recommendRecruitCollectionView: UICollectionView!
    
    
    private var data: RecommendRecruitCellData?
    override func awakeFromNib() {
        recommendRecruitCollectionView.delegate = self
        recommendRecruitCollectionView.dataSource = self
    }
    
    func setData(_ data: RecommendRecruitCellData){
        sectionTitleLabel.text = data.sectionTitle
        
        self.data = data
        recommendRecruitCollectionView.reloadData()
          
    }
}

extension RecommendRecruitCell: UICollectionViewDelegateFlowLayout,  UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    //셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.recommendRecruit.count ?? 0
    }
    
    //셀 등록
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: RecruitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecruitCell", for: indexPath) as? RecruitCell ?? RecruitCell()
        if let data: Recruit = data?.recommendRecruit[indexPath.row]{
            
            cell.setData(data)
        }
        return cell
        
    }
}
 
 
