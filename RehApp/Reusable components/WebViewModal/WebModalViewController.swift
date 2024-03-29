//
//  WebViewController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 14.04.2023..
//

import Foundation
import UIKit
import WebKit

final class WebModalViewController: UIViewController {

    // MARK: - Properties

    private let webModalView = WebModalView()
    private let url: URL?
    private let screenTitle: String?

    // MARK: - Lifecycle

    init(url: URL?, screenTitle: String?) {
        self.url = url
        self.screenTitle = screenTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = webModalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configureNavigationBar()

        guard let url = url else {
            webModalView.showNoValidURLMessage()
            return
        }

        webModalView.webView.load(URLRequest(url: url))
        webModalView.webView.navigationDelegate = self
        webModalView.startAnimating()
    }

    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Odustani",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissAction))
        navigationItem.title = screenTitle
    }

    @objc func dismissAction() {
        dismiss(animated: true)
    }
}

extension WebModalViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webModalView.stopAnimating()

        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Završi",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissAction))
    }

}
