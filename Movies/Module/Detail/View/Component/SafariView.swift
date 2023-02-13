//
//  SafariView.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    
    let url: String
    
    let urlPrank: URL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: URL(string: self.url) ?? urlPrank)
        return safariVC
    }
}
