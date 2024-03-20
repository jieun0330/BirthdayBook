//
//  WebViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/16/24.
//

import UIKit
import WebKit
import SnapKit

final class WebViewController: BaseViewController {
    
    private let webView = WKWebView()
    private let viewModel = WebViewModel()
    var bookISBN = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.inputItemID.value = self.bookISBN
        
        if let url = viewModel.outputURL.value {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func configureHierarchy() {
        [webView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.setBackgroundColor()
    }
}
