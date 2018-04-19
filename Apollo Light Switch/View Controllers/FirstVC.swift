//
//  ViewController.swift
//  Apollo Light Switch
//
//  Created by Nick on 3/28/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import Parse

class FirstVC: UIViewController {

    @IBOutlet var nextButtonPush: UIButton!
    @IBOutlet var smartWireImage: UIImageView!
    
    
    let pdf = "Installation Guide"
    @IBAction func To_Installation_Guide(_ sender: Any) {
        // performSegue(withIdentifier: "segue_to_installation", sender: self)
        if let url = Bundle.main.url(forResource: pdf, withExtension: "pdf") {
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            //self.view.addSubview(webView)
            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            pdfVC.title = pdf
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func NextPushed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "secondVC") as! SecondVC
        present(secondVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

