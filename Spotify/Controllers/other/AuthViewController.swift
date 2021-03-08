//
//  AuthViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit
import WebKit


class AuthViewController: UIViewController {

    private let webView : WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    public var completionHandle : ((Bool) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.fitToSuper()
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webView.load(URLRequest(url: url))
     }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        webView.frame = view.bounds
//    }
}


extension AuthViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        guard let code = URLComponents(string: url.absoluteString)?
                                .queryItems?
                                .first(where: {$0.name == "code"})?.value
        else {
            return
        }
        
        print("code:\(code)")
        
        AuthManager.shared.exchangeCodeForToken(code: code) { success in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                self.completionHandle?(success)
            }
        }
    }
}
