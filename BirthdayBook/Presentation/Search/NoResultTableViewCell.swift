////
////  NoResultTableViewCell.swift
////  BirthdayBook
////
////  Created by 박지은 on 3/17/24.
////
//
//import UIKit
//import Then
//import SnapKit
//
//final class NoResultTableViewCell: BaseTableViewCell, ReusableProtocol {
//    
//    let test = UILabel().then {
//        $0.text = "?"
//        $0.font = DesignSystemFont.font15.font
//        $0.textColor = .black
//    }
//    
////    private let iconBackground = UIView().then {
////        $0.backgroundColor = DesignSystemColor.pink.color
////        $0.layer.cornerRadius = 10
////    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super .init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//    
//    override func configureHierarchy() {
//        [test].forEach {
//            contentView.addSubview($0)
//        }
//    }
//    
//    override func configureConstraints() {
//        test.snp.makeConstraints {
//            $0.center.equalTo(contentView)
//            $0.size.equalTo(100)
//        }
//    }
//    
////    override func configureView() {
////        
////    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
