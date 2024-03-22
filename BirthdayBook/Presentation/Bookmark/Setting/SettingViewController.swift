//
//  SettingViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/21/24.
//

import UIKit
import SnapKit
import Then

final class SettingViewController: BaseViewController {
        
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(SettingTableViewCell.self,
                    forCellReuseIdentifier: SettingTableViewCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        navigationItem.title = "설정"
        view.setBackgroundColor()
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingEnum.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier,
                                                 for: indexPath) as! SettingTableViewCell
        
        cell.settingTitle.text = SettingEnum.allCases[indexPath.row].setting
        cell.selectionStyle = .none
        
        if indexPath.row == 2 {
            cell.version.text = "버전 1.0.0"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 2 {
            let vc = SettingWebViewController()
            vc.settingURL = SettingEnum.allCases[indexPath.row].url
            navigationController?.pushViewController(vc, animated: true)
        } 
    }
}
