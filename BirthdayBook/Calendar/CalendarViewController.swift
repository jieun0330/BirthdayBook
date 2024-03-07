//
//  CalendarViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/7/24.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarViewController: BaseViewController {
    
    let calendar = FSCalendar()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [calendar].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        calendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }
    }
    
    override func configureView() {
        view.setBackgroundColor()
    }
}
