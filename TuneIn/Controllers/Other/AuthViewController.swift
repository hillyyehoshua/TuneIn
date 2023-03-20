//
//  AuthViewController.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/7/23.
//

import UIKit
import WebKit
import SwiftUI

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private let webView: WKWebView = {
        
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView =  WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = UIColor(Color("Dark Blue"))
        webView.navigationDelegate = self
        view.addSubview(webView)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
