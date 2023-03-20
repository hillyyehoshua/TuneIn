//
//  LoginViewController.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/7/23.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(Color("Blue"))
        button.setTitle("Sign in with Spotify", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TuneIn"
        view.backgroundColor = UIColor(Color("Dark Blue"))
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn()), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: CGFloat, y: <#T##CGFloat#>, width: 230, height: <#T##CGFloat#> )
    }
    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
