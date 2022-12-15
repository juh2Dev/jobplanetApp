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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let recruit: Recruit = data?.recommendRecruit[indexPath.row] {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let recruitDetailVC: RecruitDatailViewController = mainStoryboard.instantiateViewController(withIdentifier: "RecruitDatailViewController") as? RecruitDatailViewController {
                recruitDetailVC.recruit = recruit
                if let rootViewController: UIViewController = self.window?.rootViewController{
                    rootViewController.present(recruitDetailVC, animated: true, completion: nil)
                }
            }
        }
        
    }
}
 
 
