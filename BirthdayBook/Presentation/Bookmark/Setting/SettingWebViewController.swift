//
//  SettingWebViewController.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/21/24.
//

import UIKit
import WebKit
import SnapKit

final class SettingWebViewController: BaseViewController {
    
    private let webView = WKWebView()
    
    var settingURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = settingURL {
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
}
