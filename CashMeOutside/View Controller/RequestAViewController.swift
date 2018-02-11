//
//  RequestAViewController.swift
//  CashMeOutside
//
//  Created by Anish Adhikari on 2/11/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit
import WebKit
import FirebaseDatabase

class RequestAViewController: UIViewController {
    
    var ref: DatabaseReference!
    var url: String = "https://www.google.com/maps"

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUrlWebView()
        
        performUrlOperation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func performUrlOperation() {
        
        
        ref = Database.database().reference()
        ref.child("receiver").child("anish").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let coords = value?["coords"] as? NSDictionary
            
            let lat = coords?["latitude"]
            let lng = coords?["longitude"]
            
            
            let currentLat = 38.895835
            let currentLng =  -77.011761
            
            self.url = "https://www.google.com/maps/dir/\(currentLat),\(currentLng)/\(lat!),\(lng!)"
            
            self.loadUrlWebView()
            
            print(self.url)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    func loadUrlWebView() {
        let requestURL = URL(string:url)
        // Place the URL in a URL Request.
        let request = URLRequest(url: requestURL!)
        // Load Request into WebView.
        webView.load(request)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
