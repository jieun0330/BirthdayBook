//
//  BookViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/11/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import RealmSwift
import Toast

final class BookDetailViewController: BaseViewController {
    
    private let mainView = BookDetailView()
    private let vc = AladinWebViewController()
    private var viewModel = BookDetailViewModel()
    
    var users: Results<BookRealm>?
    var notification: NotificationToken?
    private let realm = try! Realm()
    
    private lazy var bookMarkButton = UIBarButtonItem.setBarButtonItem(image: .bookmarkIconInactive,
                                                                       target: self,
                                                                       action: #selector(bookMarkButtonClicked))
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = realm.objects(BookRealm.self)

        notification = users?.observe { changes in
            switch changes {
            case .initial(let users):
                print("Initial count:", users.count)
            case .update(let users, let deletions, let insertions, let modifications):
                print("Update count:", users.count)
                print("Delete count", deletions.count)
                if insertions.count > 0 {
                    
                }
                print("Insert count", insertions.count)
                print("Modify count", modifications.count)
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        // realm에 있는지 확인
        if viewModel.isBookMarked() {
            bookMarkButton.image = .bookmarkIcon
        } else {
            bookMarkButton.image = .bookmarkIconInactive
        }
    }
        
    override func configureView() {
        navigationItem.rightBarButtonItem = bookMarkButton
        mainView.purchaseButton.addTarget(self, action: #selector(purchaseButtonClicked), for: .touchUpInside)
    }
    
    // 웹뷰 링크는 ISBN이 아닌 itemID로 들어가야한다
    @objc private func purchaseButtonClicked() {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configure<T: BookDataProtocol>(data: T) {
        
        mainView.setData(data)
        viewModel.configure(data: data)
        vc.bookISBN = data.itemId
    }
    
    @objc private func bookMarkButtonClicked() {
        
        viewModel.bookMarkButtonClicked()
        
        if viewModel.isBookMarked() {
            bookMarkButton.image = .bookmarkIcon
            view.makeToast("즐겨찾기에 저장되었습니다")
            
        } else {
            bookMarkButton.image = .bookmarkIconInactive
            view.makeToast("즐겨찾기에서 삭제되었습니다")
        }
    }
}
