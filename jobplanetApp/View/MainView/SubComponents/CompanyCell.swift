//
//  CompanyCell.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/15.
//

import UIKit

class CompanyCell: UITableViewCell {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        thumbnailImageView.layer.cornerRadius = 5
        thumbnailImageView.layer.borderWidth = 1
        thumbnailImageView.layer.borderColor = UIColor.systemGray.cgColor
    }

    
    func setData(_ data: CompanyCellData){
        
        
        if let imageUrl: URL = URL(string: data.logoPath) {
            thumbnailImageView.kf.setImage(with: imageUrl,
                                           placeholder: UIImage(systemName: "photo"),
                                           options: [.loadDiskFileSynchronously])
        } else {
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
        
        var updateDateStr: String {
            guard let date: Date = data.updateDate.toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ") else {
                return ""
            }
            return date.toString(format: "yyyy.MM.dd")
        }

        companyNameLabel.text = data.name
        ratingLabel.text = "\(data.rateTotalAvg)"
        industryLabel.text = data.industryName
        updateDateLabel.text = updateDateStr
        reviewLabel.text = data.reviewSummary
        salaryLabel.text = "\(data.salaryAvg)"
        interviewLabel.text = data.interviewQuestion
        
    }
    
    func setData(_ data: ReviewCellData){
        
        
        if let imageUrl: URL = URL(string: data.logoPath) {
            thumbnailImageView.kf.setImage(with: imageUrl,
                                           placeholder: UIImage(systemName: "photo"),
                                           options: [.loadDiskFileSynchronously])
        } else {
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
        
        var updateDateStr: String {
            guard let date: Date = data.updateDate.toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ") else {
                return ""
            }
            return date.toString(format: "yyyy.MM.dd")
        }

        companyNameLabel.text = data.name
        ratingLabel.text = "\(data.rateTotalAvg)"
        industryLabel.text = data.industryName
        updateDateLabel.text = updateDateStr
        reviewLabel.text = data.reviewSummary
        
        interviewView.isHidden = true
        salaryView.isHidden = true
    
        
        
    }

}
