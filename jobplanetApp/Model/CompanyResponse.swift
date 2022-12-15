//
//  CompanyResponse.swift
//  jobplanetApp
//
//  Created by 임주희 on 2022/12/13.
//

import Foundation


// MARK: CellType
enum CellType: String, Codable {
    case cellTypeCompany = "CELL_TYPE_COMPANY"
    case cellTypeHorizontalTheme = "CELL_TYPE_HORIZONTAL_THEME"
    case cellTypeReview = "CELL_TYPE_REVIEW"
}

// MARK: CompanyResponse
struct CompanyResponse: Codable {
    let cellItems: [CellItem]

    enum CodingKeys: String, CodingKey {
        case cellItems = "cell_items"
    }
}

// MARK: - CellItem
struct CellItem: Codable {
    let cellType: CellType
    let logoPath: String?
    let name, industryName: String?
    let rateTotalAvg: Double?
    let reviewSummary, interviewQuestion: String?
    let salaryAvg: Int?
    let updateDate: String?
    let count: Int?
    let sectionTitle: String?
    let recommendRecruit: [Recruit]?
    let cons, pros: String?

    enum CodingKeys: String, CodingKey {
        case cellType = "cell_type"
        case logoPath = "logo_path"
        case name
        case industryName = "industry_name"
        case rateTotalAvg = "rate_total_avg"
        case reviewSummary = "review_summary"
        case interviewQuestion = "interview_question"
        case salaryAvg = "salary_avg"
        case updateDate = "update_date"
        case count
        case sectionTitle = "section_title"
        case recommendRecruit = "recommend_recruit"
        case cons, pros
    }
}


// MARK: - CellItemProtocol
protocol CellItemProtocol {
    var cellType: CellType { get }
    
    var logoPath: String { get }
    var name: String { get }
    var industryName: String { get }
    var rateTotalAvg: Double { get }
    var reviewSummary: String { get }
    var updateDate: String { get }
}

// MARK: CELL_TYPE_COMPANY
struct CompanyCellData: CellItemProtocol {
    let cellType: CellType
    let logoPath: String
    let name, industryName: String
    let rateTotalAvg: Double
    let reviewSummary: String
    let updateDate: String
    
    let interviewQuestion: String
    let salaryAvg: Int

}

extension CompanyCellData {
    
    init?(item: CellItem){
        guard let logoPath: String = item.logoPath,
               let name: String = item.name,
               let industryName: String = item.industryName,
               let rateTotalAvg: Double = item.rateTotalAvg,
               let reviewSummary: String = item.reviewSummary,
               let updateDate: String = item.updateDate,
               let interviewQuestion: String = item.interviewQuestion,
               let salaryAvg: Int = item.salaryAvg
        else { return nil }
        
        self.init(cellType: item.cellType,
                  logoPath: logoPath,
                  name: name,
                  industryName: industryName,
                  rateTotalAvg: rateTotalAvg,
                  reviewSummary: reviewSummary,
                  updateDate: updateDate,
                  interviewQuestion: interviewQuestion,
                  salaryAvg: salaryAvg)
    }

}


// MARK: -  CELL_TYPE_REVIEW
struct ReviewCellData: CellItemProtocol {
    let cellType: CellType
    let logoPath: String
    let name, industryName: String
    let rateTotalAvg: Double
    let reviewSummary: String
    let updateDate: String
    
    let cons, pros: String
}
extension ReviewCellData {
    
    init?(item: CellItem){
        
        guard let logoPath: String = item.logoPath,
              let name: String = item.name,
              let industryName: String = item.industryName,
              let rateTotalAvg: Double = item.rateTotalAvg,
              let reviewSummary: String = item.reviewSummary,
              let updateDate: String = item.updateDate,
              let cons: String = item.cons,
              let pros: String = item.pros
        else { return nil }
              
        
        self.init(cellType: item.cellType,
                  logoPath: logoPath,
                  name: name,
                  industryName: industryName,
                  rateTotalAvg: rateTotalAvg,
                  reviewSummary: reviewSummary,
                  updateDate: updateDate,
                  cons: cons,
                  pros: pros)
    }

}



// MARK: - CELL_TYPE_HORIZONTAL_THEME
struct RecommendRecruitCellData {
    let cellType: CellType
    let count: Int
    let sectionTitle: String
    let recommendRecruit: [Recruit]
}
extension RecommendRecruitCellData {
    
    init?(item: CellItem){
        guard let count: Int = item.count,
              let sectionTitle: String = item.sectionTitle,
              let recommendRecruits: [Recruit] = item.recommendRecruit
        else { return nil }
        
        self.init(cellType: item.cellType, count: count, sectionTitle: sectionTitle, recommendRecruit: recommendRecruits)
    }
}


