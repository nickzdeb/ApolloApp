//
//  ViewController.swift
//  Apollo Light Switch
//
//  Created by Nick on 3/28/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import Parse

class ThirdVC: UIViewController {

    
    @IBOutlet var roomNameLabel: UILabel!
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humLabel: UILabel!
    @IBOutlet var roomActivityLabel: UILabel!
    @IBOutlet var lightLabel: UILabel!
    
    @IBOutlet var deleteButton: UIButton!
    
    
    var roomName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpLabel() {
        roomNameLabel.text = roomName!
        if let name = roomName {
            roomNameLabel.text = name
        }
    }
    
    func setUpTemp() {
        //tempLabel.text = //Something from database
    }
    
    func setUpHum() {
        
    }
    
    func setUpRoomActivity() {
        
    }
    
    func setUpLight() {
        
    }
    
    @IBAction func backButtonPushed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "secondVC") as! SecondVC
        present(destinationVC, animated: true, completion: nil)
    }
    
    
    @IBAction func deletePushed(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "Deleting this room will remove all associated data", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {(action) in
            //Deletes room from database
            print("Confirmed")
            
            
            let query = PFQuery(className: "Room")
            query.whereKey("columnName", equalTo: "roomName")
            
            query.findObjectsInBackground(block: { (objects: [PFObject]?, error: Error?) -> Void in
                if error == nil {
                    for object in objects! {
                        object.deleteInBackground()
                    }
                }
            }
        )
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let SecondVC = storyboard.instantiateViewController(withIdentifier: "secondVC") as! SecondVC
            self.present(SecondVC, animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in
            //Closes alert
        }))
        
        
        present(alert, animated:true, completion: nil)
    }
    
}
