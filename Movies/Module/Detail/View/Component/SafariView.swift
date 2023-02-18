//
//  SafariView.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SafariServices
import SwiftUI
let siteYoutube: String = "YouTube"

/**
A SwiftUI view that wraps a SFSafariViewController to display a webpage.

To use this view, create an instance and pass in a string URL to the url parameter. A SFSafariViewController will be created to display the webpage.

* Parameter
    -  url: The string URL to display in the SFSafariViewController.

Note: If the URL is invalid or cannot be loaded, a prank URL will be loaded instead.

*/
struct SafariView: UIViewControllerRepresentable {
    
    let url: String
    
    let urlPrank: URL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: URL(string: EndPoints.Gets.youtubeURL(key: url).url) ?? urlPrank)
        return safariVC
    }
}
