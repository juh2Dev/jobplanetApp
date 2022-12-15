//
//  RecruitDatailViewController.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/15.
//

import UIKit
import Kingfisher

class RecruitDatailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var tagStackView: UIStackView!
    
    var recruit: Recruit? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let recruit = recruit else {
            return
        }

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
        
        
        let tags: [UILabel] = recruit.appeal.components(separatedBy: ",").map { tag in
            let tagLabel: UILabel = UILabel()
            tagLabel.text = tag
            return tagLabel
        }
        tags.forEach({
            tagStackView.addArrangedSubview($0)
        }) 
        tagStackView.addArrangedSubview(UIView())

    }
    


}
