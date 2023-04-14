//
//  WebView.swift
//  RehApp
//
//  Created by Akademija on 14.04.2023..
//

import Foundation
import UIKit
import WebKit

final class WebModalView: UIView {

    // MARK: - Properties

    let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.preferredContentMode = .mobile

        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        configuration.suppressesIncrementalRendering = false
        configuration.allowsInlineMediaPlayback = true
        configuration.allowsAirPlayForMediaPlayback = true
        configuration.allowsPictureInPictureMediaPlayback = false

        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = false
        webView.allowsLinkPreview = false
        webView.alpha = 0

        return webView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private let noValidURLLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nažalost, ne možemo pronaći traženu stranicu 😕"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .red
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .white
        addSubviews([
            webView, activityIndicator,
            noValidURLLabel
        ])

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            noValidURLLabel.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            noValidURLLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noValidURLLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            noValidURLLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            noValidURLLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Public methods

    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            webView.alpha = 1
        }
    }

    func showNoValidURLMessage() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            noValidURLLabel.alpha = 1
        }
    }
}
