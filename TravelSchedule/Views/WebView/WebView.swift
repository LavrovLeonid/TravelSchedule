//
//  WebView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/28/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        let webView = WKWebView()
        
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
