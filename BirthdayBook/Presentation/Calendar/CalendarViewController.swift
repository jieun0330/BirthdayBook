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
import Kingfisher

final class CalendarViewController: BaseViewController {
    
    private let viewModel = CalendarViewModel()
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private var selectedDate: Date?
    
    private lazy var logo = UIBarButtonItem.setBarButtonItem(image: .logo,
                                                             target: self,
                                                             action: #selector(logoClicked))
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = DesignSystemColor.pink.color
        $0.layer.cornerRadius = 50
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner)
    }
    
    private lazy var calendar = FSCalendar().then {
        $0.delegate = self
        $0.dataSource = self
        //        $0.layer.borderWidth = 1
        //        $0.layer.borderColor = UIColor.red.cgColor
    }
    
    private lazy var calendarButton = UIButton().then {
        $0.setImage(.calendarIcon.withTintColor(DesignSystemColor.red.color), for: .normal)
        $0.addTarget(self, action: #selector(calendarButtonClicked), for: .touchUpInside)
    }
    
    private let birthdayDateLabel = UILabel().then {
        $0.font = DesignSystemFont.font15.font
        $0.textColor = DesignSystemColor.red.color
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: createLayout()).then {
        $0.backgroundColor = .none
        $0.delegate = self
        $0.dataSource = self
        $0.prefetchDataSource = self
        $0.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        //        $0.layer.borderColor = UIColor.green.cgColor
        //        $0.layer.borderWidth = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = false
        
        let today = Date()
        birthdayDate(date: today)
        
        viewModel.outputAladinAPIResult.bind { data in
            if data.count > 1 {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        KingfisherCache.shared.removeCache()
        KingfisherCache.shared.checkCurrentCacheSize()
    }
    
    func birthdayDate(date: Date) {
        let dateString = DateFormatManager.shared.calenderString(date: date)
        viewModel.inputDate.value = dateString
        
        let birthdayLabel = DateFormatManager.shared.birthdayLabel(date: date)
        birthdayDateLabel.text = "\(birthdayLabel)과 생일이 똑같은 책이에요"
    }
    
    override func configureHierarchy() {
        
        [scrollView].forEach {
            view.addSubview($0)
        }
        
        [contentView].forEach {
            scrollView.addSubview($0)
        }
        
        [calendar, calendarButton, birthdayDateLabel, backgroundView, collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }
        
        calendarButton.snp.makeConstraints {
            $0.centerY.equalTo(calendar.calendarHeaderView)
            $0.trailing.equalToSuperview().offset(-30)
            $0.size.equalTo(15)
        }
        
        birthdayDateLabel.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(80)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(birthdayDateLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(450)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(collectionView).offset(120)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalTo(collectionView)
        }
    }
    
    override func configureView() {
        view.setBackgroundColor()
        setCalendarUI()
        navigationItem.leftBarButtonItem = logo
    }
    
    @objc private func logoClicked() { }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width / 1.5, height: width / 1.0)
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    @objc private func calendarButtonClicked() {
        if calendar.scope == .month { // 월간 -> 주간
            changeCalendar(month: false)
            scrollView.isScrollEnabled = false
        } else { // 주간 -> 월간
            changeCalendar(month: true)
            scrollView.isScrollEnabled = true
        }
    }
    
    private func changeCalendar(month: Bool) {
        calendar.setScope(month ? .month : .week, animated: true)
    }
    
    private func setCalendarUI() {
        // Header DateFormat - March
        calendar.appearance.headerDateFormat = "MMMM"
        // 양옆 년도, 월 지우기
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        // 헤더 색상
        calendar.appearance.headerTitleColor = .black
        // 헤더 정렬 설정
        calendar.appearance.headerTitleAlignment = .left
        // 헤더 정렬 left로 줬는데 많이 안가서 offset 설정
        calendar.appearance.headerTitleOffset = CGPoint(x: -75, y: 0)
        
        // 주간 달력
        calendar.scope = .week
        // 달에 유효하지 않은 날짜 지우기
        calendar.placeholderType = .none
        // Today에 표시되는 선택 전 동그라미 색
        calendar.appearance.todayColor = DesignSystemColor.pink.color
        calendar.appearance.borderRadius = 0.5
        // 선택된 날의 동그라미 색
        calendar.appearance.selectionColor = .none
        calendar.appearance.todaySelectionColor = DesignSystemColor.pink.color
        // 요일 UI (평일 검정색)
        calendar.appearance.weekdayTextColor = .black
        // 요일 M, T, W처럼 나오게 하기
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        // 요일 UI (일요일 빨간색)
        calendar.calendarWeekdayView.weekdayLabels.first?.textColor = .red
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
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(#function)
        
        selectedDate = date
        birthdayDate(date: date)
        
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        print(#function)
        
        if date != selectedDate {
            APIManager.shared.bookISBNArray.removeAll()
            viewModel.outputAladinAPIResult.value.removeAll()
        }
        
        return true
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .black
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
        return DesignSystemColor.pink.color
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputAladinAPIResult.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        if viewModel.outputAladinAPIResult.value.count > 1 {
            let aladinData = viewModel.outputAladinAPIResult.value[indexPath.item]
            cell.bookTitle.text = aladinData.title
            cell.author.text = aladinData.author
            cell.coverImage.kf.setImage(with: URL(string: aladinData.cover), options: [.transition(.fade(1))])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = BookDetailViewController()
        vc.configure(data: viewModel.outputAladinAPIResult.value[indexPath.item])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CalendarViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if viewModel.outputAladinAPIResult.value.count - 1 == item.item {
                viewModel.inputISBNTrigger.value = ()
            }
        }
    }
}
