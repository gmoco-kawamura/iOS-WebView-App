//
//  ContentView.swift
//  PopupSample2
//
//  Created by 川村拓也 on 2024/02/29.
//

import SwiftUI
import UIKit
import SampleSDKkawamura4

// SwiftUIビュー
struct ContentView: View {
    // ポップアップ表示の状態管理
    @State private var showingPopup = false

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Show Popup") {
                self.showingPopup = true
            }
            .sheet(isPresented: $showingPopup) {
                // ポップアップとして表示するビュー
                PopupWebView()
            }
        }
        .padding()
    }
}

// ポップアップとして表示するWebViewを含むSwiftUIビュー
struct PopupWebView: View {
    var body: some View {
        // UIViewControllerRepresentableを使ってPTPopupWebViewをラップ
        PTPopupWebViewRepresentable()
    }
}

// PTPopupWebViewをSwiftUIで使用するためのラッパー
struct PTPopupWebViewRepresentable: UIViewControllerRepresentable {
//    var onClose: (() -> Void)?

    func makeUIViewController(context: Context) -> UIViewController {
        let popupWebView = PTPopupWebViewController()
        popupWebView.popupView.URL(string: "https://google.com")
        popupWebView.onClose = {
            print("popup closed")
        }
        return popupWebView
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
