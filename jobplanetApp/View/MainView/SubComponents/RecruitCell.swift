//
//  RecruitCell.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/12.
//

import UIKit
import Kingfisher

class RecruitCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnailImageView.layer.cornerRadius = 10;
        thumbnailImageView.clipsToBounds = true;
        
    }
    
    func setData(_ recruit: Recruit){

        if let imageUrl: URL = URL(string: recruit.imageURL) {
            thumbnailImageView.kf.setImage(with: imageUrl,
                                           placeholder: UIImage(systemName: "photo"),
                                           options: [.loadDiskFileSynchronously])
        } else {
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
        
        let highestRating: Double = recruit.company.highestRating ?? (recruit.company.ratings.first!.rating)
        
        titleLabel.text = recruit.title
        companyNameLabel.text = recruit.company.name
        
        ratingLabel.text = "\(highestRating)"
        rewardLabel.text = "축하금: \(recruit.reward)원"
        
        let tag: String = recruit.appeal.components(separatedBy: [","]).joined()
        tagLabel.text = tag
        
        let attrStr = changeAllOccurrence(entireString: tag, searchString: " ")
        tagLabel.attributedText = attrStr
        
        if tag.isEmpty {
            tagLabel.backgroundColor = .white
        }
        
    }
    
    func changeAllOccurrence(entireString: String,searchString: String) -> NSMutableAttributedString {
        
        let attrStr = NSMutableAttributedString(string: entireString)
        
        let entireLength = entireString.count
        
        var range = NSRange(location: 0, length: entireLength)
        
        var rangeArr = [NSRange]()
        
        while (range.location != NSNotFound) {
            range = (attrStr.string as NSString).range(of: searchString, options: .caseInsensitive, range: range)
            rangeArr.append(range)
            if (range.location != NSNotFound) {
                range = NSRange(location: range.location + range.length, length: entireString.count - (range.location + range.length))
            }
        }
        
        rangeArr.forEach { (range) in
            attrStr.addAttribute(.backgroundColor, value: UIColor.white, range: range)
        }
        
        return attrStr
    }
    
    
}

