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
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.red.cgColor
    }
    
    private lazy var calendarButton = UIButton().then {
        $0.setImage(UIImage(systemName: "calendar"), for: .normal)
        $0.addTarget(self, action: #selector(calendarButtonClicked), for: .touchUpInside)
    }
    
    private let birthdayBookLabel = UILabel().then {
        $0.text = "3월 4일과 생일이 똑같은 책이에요"
    }
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: configureCollectionViewLayout()).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.brown.cgColor
        $0.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: <#T##String#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        [calendar, calendarButton, birthdayBookLabel, collectionView].forEach {
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
        
        birthdayBookLabel.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(birthdayBookLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.size.equalTo(500)
        }
    }
    
    override func configureView() {
        view.setBackgroundColor()
        setCalendarUI()
    }
    
    private static func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    @objc private func calendarButtonClicked() {
        if calendar.scope == .month {
            changeCalendar(month: false)
        } else {
            changeCalendar(month: true)
        }
    }
    
    private func changeCalendar(month: Bool) {
        calendar.setScope(month ? .month : .week, animated: true)
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
        calendar.appearance.todayColor = DesignSystemColor.red.color
        calendar.appearance.titleTodayColor = .white
        // 선택된 날의 동그라미 색
        calendar.appearance.selectionColor = DesignSystemColor.pink.color
        calendar.appearance.todaySelectionColor = DesignSystemColor.red.color
        // 요일 UI (평일 검정색)
        calendar.appearance.weekdayTextColor = .black
        // 요일 UI (일요일 빨간색)
        calendar.calendarWeekdayView.weekdayLabels.first?.textColor = .red
        print(calendar.calendarWeekdayView.weekdayLabels.first?.text)
        // 요일 UI (토요일 파란색)
        calendar.calendarWeekdayView.weekdayLabels.last?.textColor = .blue
        // M, T, W처럼 나오게 하기
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
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
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
}
