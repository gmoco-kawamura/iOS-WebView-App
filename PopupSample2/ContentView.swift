//
//  ContentView.swift
//  PopupSample2
//
//  Created by 川村拓也 on 2024/02/29.
//

//import SwiftUI
//import UIKit
//import iOS_WebView_SDK
//
//// SwiftUI View
//struct ContentView: View {
//    // State management for popup display
//    @State private var showingPopup = false
//
//    var body: some View {
//        VStack {
//            Button("Show Popup") {
//                self.showingPopup = true
//            }
//            .sheet(isPresented: $showingPopup) {
//                PopupWebView()
//            }
//        }
//        .padding()
//    }
//}
//
//// ポップアップとして表示するWebViewを含むSwiftUIビュー
//struct PopupWebView: View {
//    var body: some View {
//        // UIViewControllerRepresentableを使ってPTPopupWebViewをラップ
//        PTPopupWebViewRepresentable()
//    }
//}
//
//// PTPopupWebViewをSwiftUIで使用するためのラッパー
//struct PTPopupWebViewRepresentable: UIViewControllerRepresentable {
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        let popupWebView = PTPopupWebViewController()
//        _ = popupWebView.popupView.URL(string: "https://google.com")
//        popupWebView.onClose = {
//            print("popup closed")
//        }
//        return popupWebView
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


//import SwiftUI
//import UIKit
//import CueLightShow
//
//struct ContentView: View {
//    // モーダル表示の状態を管理するための変数
//    @State private var isShowingWebView = false
//
//    var body: some View {
//        Button("Show WebView") {
//            // ボタンをタップしたときにWebViewを表示する
//            self.isShowingWebView = true
//        }
//        .sheet(isPresented: $isShowingWebView) {
//            // WebViewControllerをUIHostingControllerでラップして表示
//            WebViewControllerWrapper()
//        }
//    }
//}
//
//// WebViewControllerをSwiftUIで扱えるようにラップするためのコンポーネント
//struct WebViewControllerWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let googleUrl = URL(string: "https://google.com")!
//        let webViewController = WebViewController()
////        try? webViewController.navigateTo(url: googleUrl, progressHandler: nil)
//        do {
//            try webViewController.navigateTo(url: googleUrl, progressHandler: nil)
//        } catch {
//            print(error)
//        }
//        // WebViewControllerのインスタンスを作成
//        return webViewController
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        // 更新時の処理（この例では特に何もしない）
//    }
//}
//
//// SwiftUIのプレビュー
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

import SwiftUI
import WebKit
//import RoktWebViewSDK
import iOS_WebView_SDK3

// RoktWKWebView を SwiftUI で使用できるようにするラッパー
struct RoktWKWebViewRepresentable: UIViewRepresentable {
    var delegate: RoktWKWebViewDelegate?
    func makeUIView(context: Context) -> WKWebView {
        let webView = RoktWKWebView(frame: .zero)
        webView.roktDelegate = delegate
        if let url = URL(string: "https://google.com"){
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 必要に応じて更新処理をここに追加
    }
}

class WebViewDelegate: RoktWKWebViewDelegate {
    func webViewDidOpenURL(_ webView: RoktWKWebView, url: URL) {
        // URLをログに出力
        print("Opened URL: \(url.absoluteString)")
    }
}

// ContentView での RoktWKWebViewRepresentable の使用例
struct ContentView: View {
    // モーダル表示の状態を管理するための変数
    @State private var isShowingWebView = false
    let webViewDelegate = WebViewDelegate()
    var body: some View {
        Button("Show WebView"){
            self.isShowingWebView = true
        }
        .sheet(isPresented: $isShowingWebView) {
            RoktWKWebViewRepresentable(delegate: webViewDelegate)
        }
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
