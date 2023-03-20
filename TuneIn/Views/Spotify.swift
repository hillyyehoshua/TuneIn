//
//  Spotify.swift
//  TuneIn
//
//  Created by Izzy Hood on 2/20/23.
//

import UIKit
import SwiftUI

struct Spotify: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = ViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
