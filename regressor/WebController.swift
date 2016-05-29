//
//  WebController.swift
//  regressor
//
//  Created by Robin Malhotra on 30/05/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import Cocoa
import WebKit
class WebController: NSViewController {

    @IBOutlet weak var webView: WebView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        webView.mainFrame.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.google.com")!))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WebController.printLoading), name: WebViewProgressFinishedNotification , object: self)
        // Do view setup here.
    }
    
    func printLoading()
    {
        print("khatma")
    }
    
}
