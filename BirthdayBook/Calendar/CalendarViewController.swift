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
    
    private lazy var calendar = FSCalendar().then {
        $0.delegate = self
        $0.dataSource = self
    }
    
    private lazy var calendarButton = UIButton().then {
        $0.setImage(UIImage(systemName: "calendar"), for: .normal)
        $0.addTarget(self, action: #selector(calendarButtonClicked), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [calendar, calendarButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        calendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }
        
        calendarButton.snp.makeConstraints {
            $0.centerY.equalTo(calendar.calendarHeaderView)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override func configureView() {
        view.setBackgroundColor()
        setCalendarUI()
    }
    
    @objc func calendarButtonClicked() {
        print(#function)
    }
    
    private func setCalendarUI() {
        NumberFormatManager.shared.calenderFormat()
        // Header DateFormat - March
        calendar.appearance.headerDateFormat = "MMMM"
        // 양옆 년도, 월 지우기
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        // 헤더 색상
        calendar.appearance.headerTitleColor = .black
        // 헤더 정렬 설정
        calendar.appearance.headerTitleAlignment = .left
        // 헤더 정렬 left로 줬는데 많이 안가서 offset 설정
        calendar.appearance.headerTitleOffset = CGPoint(x: -85, y: 0)
        
        // 주간 달력
        calendar.scope = .week
        // 달에 유효하지 않은 날짜 지우기
        calendar.placeholderType = .none
        // Today에 표시되는 선택 전 동그라미 색
        calendar.appearance.todayColor = DesignSystemColor.pink.color
        // 선택된 날의 동그라미 색
        calendar.appearance.selectionColor = .brown
        // M, T, W처럼 나오게 하기
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        // 요일 UI (평일 검정색)
        calendar.appearance.weekdayTextColor = .black
        // 요일 UI (일요일 빨간색)
        calendar.calendarWeekdayView.weekdayLabels.first?.textColor = .red
        print(calendar.calendarWeekdayView.weekdayLabels.first?.text)
        // 요일 UI (토요일 파란색)
        calendar.calendarWeekdayView.weekdayLabels.last?.textColor = .blue
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        if Calendar.current.shortWeekdaySymbols[day] == "Sun" {
            return .red
        } else if Calendar.current.shortWeekdaySymbols[day] == "Sat" {
            return .blue
        } else {
            return .label
        }
    }
}
