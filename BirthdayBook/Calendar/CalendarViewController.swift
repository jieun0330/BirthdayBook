//
//  CalendarViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/7/24.
//

import UIKit
import FSCalendar
import SnapKit
import Then

final class CalendarViewController: BaseViewController {
    
    private lazy var calendar = FSCalendar().then {_ in
//        $0.delegate = self
//        $0.dataSource = self
    }

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
        setCalendarUI()
    }
    
    private func setCalendarUI() {
        NumberFormatManager.shared.calenderFormat()
        self.calendar.appearance.headerDateFormat = "MMMM"
    }
}

//extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
//    
//}
