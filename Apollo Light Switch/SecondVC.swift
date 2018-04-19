//
//  SecondVC.swift
//  Apollo Light Switch
//
//  Created by Nick on 3/28/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import CoreData
import Parse

class SecondVC: UIViewController {

    @IBOutlet var ButtonToGoBack: UIButton!
    @IBOutlet var ButtonToRoom: UIButton!
    @IBOutlet var tableOfRooms: UITableView!
    
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
    
    var currentRoomNames: [RoomObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructTableView()
        
        //Check database for previous rooms added by user
        
        let roomQuery = PFQuery(className:"Room")
        roomQuery.findObjectsInBackground { (objects, error) in
            if (error == nil){
                for object in objects! {
                    
                    //let myObject = object["roomName"] as! String
                    let myObject = RoomObject(roomName: object["roomName"] as! String, uuid: object["UUID"] as! String)
                    self.currentRoomNames.append(myObject)
                    //print(self.currentRoomNames)
                    
                    //Loads the TableView with currentRoomNames when secondVC is initiated
                    self.tableOfRooms.beginUpdates()
                    self.tableOfRooms.reloadData()
                    self.tableOfRooms.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                    self.tableOfRooms.endUpdates()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonToGoBackPushed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let FirstVC = storyboard.instantiateViewController(withIdentifier: "firstVC") as! FirstVC
        present(FirstVC, animated: true, completion: nil)
    }
    
    @IBAction func ButtonToRoomPushed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let ThirdVC = storyboard.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdVC
        present(ThirdVC, animated: true, completion: nil)
    }
    
    @IBAction func AddNewRoomButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add New Room", message: "Please give a name and UUID for this room", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "Enter Name"
        })
        
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "Enter UUID"
        })
        
        //Done button
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {(action) in
            if let roomNameTextField = alert.textFields?[0] {
                if let uuidTextField = alert.textFields?[1] {
                    let roomName = roomNameTextField.text!
                    let uuid = uuidTextField.text!
                    
                    let myObject = RoomObject(roomName: roomName, uuid: uuid)
                    
                    //Reloads the TableView after user enters new room
                    self.tableOfRooms.reloadData()
                    self.tableOfRooms.beginUpdates()
                    self.currentRoomNames.append(myObject)
                    self.tableOfRooms.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                    self.tableOfRooms.endUpdates()
                    
                    //Saves to database through parse
                    let room = PFObject(className:"Room")
                    room["roomName"] = roomName
                    room["UUID"] = uuid //For identification for multiple devices
                    room.saveInBackground {
                        (success: Bool, error: Error?) in
                        if (success) {
                            print("The object has been saved.")
                        } else {
                            print("There was a problem, check error.description")
                        }
                    }
                    
                }}
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in
            //Closes alert
        }))
        
        present(alert, animated:true, completion: nil)
    }

}
