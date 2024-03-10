//
//  NewCalendarViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/10/24.
//

import UIKit
import Then
import SnapKit
import FSCalendar
import Kingfisher

final class NewCalendarViewController: BaseViewController {


    
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(NewCalendarTableViewCell.self, forCellReuseIdentifier: NewCalendarTableViewCell.identifier)
        $0.backgroundColor = .orange
    }
    

    

    

    


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel.outputBookAPIResult.bind { data in
//            
//            self.book = data
//            self.collectionView.reloadData()
//        }

    }
    
    override func configureHierarchy() {
        [tableView].forEach {
            view.addSubview($0)
        }

    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide)
//            $0.size.equalTo(700)
        }

        

        

        

    }
    
    override func configureView() {
        view.setBackgroundColor()
    }
    

    


    

}






extension NewCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewCalendarTableViewCell.identifier, for: indexPath) as! NewCalendarTableViewCell
        
        cell.backgroundColor = .purple
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
