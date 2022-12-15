//
//  CompanyDetailViewController.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/15.
//

import UIKit
import Kingfisher

class CompanyDetailViewController: UIViewController {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var salaryView: UIView!
    @IBOutlet weak var interviewLabel: UILabel!
    @IBOutlet weak var interviewView: UIView!
    
    //var company: CompanyCellData? = nil
    //var review: ReviewCellData? = nil
    var data: CellItem?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setData()
    }
    

    func setData(){
        
        guard let item: CellItem = self.data else { return }
        
        var thumbnailUrl: URL? {
            guard let logoPath: String = item.logoPath else { return nil}
            return URL(string: logoPath)
        }
        
        if let thumbnailUrl: URL = thumbnailUrl {
            thumbnailImageView.kf.setImage(with: thumbnailUrl,
                                           placeholder:  UIImage(systemName: "photo"),
                                           options: [.loadDiskFileSynchronously])
        }else{
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
        
        companyNameLabel.text = item.name
        
        if let rateTotalAvg: Double = item.rateTotalAvg {
            ratingLabel.text = "\(rateTotalAvg)"
        }
        
        industryLabel.text = item.industryName
        
        reviewLabel.text = item.reviewSummary
        
        
        var updateDateStr: String {
            guard let updateDate: String = item.updateDate,
             let date: Date = updateDate.toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ") else {
                return ""
            }
            return date.toString(format: "yyyy.MM.dd")
        }
        updateDateLabel.text = updateDateStr
        
        
        if let salaryAvg: Int = item.salaryAvg {
            salaryLabel.text = "\(salaryAvg)"
        }else{
            salaryView.isHidden = true
        }
        
        if let interviewQuestion: String = item.interviewQuestion {
            interviewLabel.text = interviewQuestion
        }else{
            interviewView.isHidden = true
        }
        
        
        
        
        
        
    }
}
