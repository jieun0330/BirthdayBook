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
    private var libraryBook: [Doc] = []
    private var naverBook: [Item] = []

    private lazy var logo = UIBarButtonItem(image: .logo,
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonItemClicked)).then {_ in
    }
    
    
    private let background = UIView().then {
        $0.backgroundColor = DesignSystemColor.pink.color
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
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = DesignSystemColor.red.color
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: CalendarViewController.createLayout()).then {
        $0.backgroundColor = DesignSystemColor.pink.color
        $0.delegate = self
        $0.dataSource = self
        $0.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
    }
    
//    private let indicatorView = UIActivityIndicatorView().then {
//        $0.hidesWhenStopped = false
//        $0.startAnimating()
//        $0.backgroundColor = DesignSystemColor.pink.color
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let today = DateFormatManager.shared.calenderString(date: Date())
        viewModel.inputDate.value = today
        let birthdayLabel = DateFormatManager.shared.birthdayLabel(date: Date())
        birthdayDateLabel.text = "\(birthdayLabel)과 생일이 똑같은 책이에요"
        
//        DispatchQueue.main.async {
            viewModel.outputLibraryBookAPIResult.bind { data in
                self.libraryBook = data
                self.collectionView.reloadData()
//                self.indicatorView.stopAnimating()
//                self.indicatorView.isHidden = true
            }
        
//        viewModel.outputNaverAPIResult.bind { data in
//            self.naverBook = data
//            print("data", data)
//        }
        

        
//        self.view.bringSubviewToFront(self.indicatorView)
    }
    
    override func configureHierarchy() {
        [background, calendar, calendarButton, birthdayDateLabel, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {

        calendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }
        
        calendarButton.snp.makeConstraints {
            $0.centerY.equalTo(calendar.calendarHeaderView)
            $0.trailing.equalToSuperview().offset(-30)
            $0.size.equalTo(15)
        }
        
        birthdayDateLabel.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(birthdayDateLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        background.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(300)
            $0.horizontalEdges.equalToSuperview()
        }
        
//        indicatorView.snp.makeConstraints {
//            $0.top.equalTo(calendar.snp.bottom)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//            $0.horizontalEdges.equalToSuperview()
//        }
        
    }
    
    override func configureView() {
        view.setBackgroundColor()
        setCalendarUI()
        navigationItem.leftBarButtonItem = logo
    }
    
    @objc private func leftBarButtonItemClicked() {
        
    }
    
    private static func createLayout() -> UICollectionViewFlowLayout {
        
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
        calendar.appearance.todayColor = DesignSystemColor.red.color
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.borderRadius = 0.5
        // 선택된 날의 동그라미 색
        calendar.appearance.selectionColor = DesignSystemColor.pink.color
        calendar.appearance.todaySelectionColor = DesignSystemColor.red.color
        // 요일 UI (평일 검정색)
        calendar.appearance.weekdayTextColor = .black
        // 요일 UI (일요일 빨간색)
        calendar.calendarWeekdayView.weekdayLabels.first?.textColor = .red
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
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
//        self.indicatorView.startAnimating()
        APIManager.shared.emptyArray.removeAll()
        let stringDate = DateFormatManager.shared.calenderString(date: date)
        viewModel.inputDate.value = stringDate
        
        let birthdayLabel = DateFormatManager.shared.birthdayLabel(date: date)
        birthdayDateLabel.text = "\(birthdayLabel)과 생일이 똑같은 책이에요"
        
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return libraryBook.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        let libraryData = self.libraryBook[indexPath.item]
        cell.coverImage.kf.setImage(with: URL(string: libraryData.titleURL))
//        , placeholder: UIImage(named: "placeholder")
        cell.author.text = libraryData.author
        cell.bookTitle.text = libraryData.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = BookDetailViewController()
        navigationController?.pushViewController(vc, animated: true)

        vc.libraryBook = libraryBook[indexPath.item]
        
        // 1. didSelect했을 때 해당 책 이름으로 네이버 api를 쏜다
//        print("title", libraryBook[indexPath.item].title)
//        let test = libraryBook[indexPath.item].title
//        APIManager.shared.naverRequest(text: test) { data in
//            if !data.items.isEmpty {
//                vc.bookDescription.text = data.items[0].description
//
//            } 
//            
//        }
        
        // 2. 책 이름으로 검색하면 안나오니까 ISBN으로 검색해야 한다
        // 네이버는 입력값에 ISBN이 없어서 카카오로 바꿔야 할 것 같다
        // query랑 isbn 둘중 하나만 맞으면 으로 해 야되나 
        print("isbn", libraryBook[indexPath.item].eaIsbn)
        
        

    }
}
