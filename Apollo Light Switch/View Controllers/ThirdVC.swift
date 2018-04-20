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

    /** Active Components */
    @IBOutlet var roomNameLabel: UILabel!
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humLabel: UILabel!
    @IBOutlet var roomActivityLabel: UILabel!
    @IBOutlet var lightLabel: UILabel!
    
    @IBOutlet var tempGraph: UIButton!
    @IBOutlet var humGraph: UIButton!
    @IBOutlet var motionGraph: UIButton!
    @IBOutlet var lightGraph: UIButton!
    
    
    @IBOutlet var deleteButton: UIButton!
    
    
    /** Active Data sets*/
    var roomName: String?
    var uuid: String?
    var temp_hum_array = [Temp_Hum]()
    var motion_array = [MotionObject]()
    var light_array = [LightObject]()
    
    enum DataSet {
        case temp
        case hum
        case light
        case motion
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(temp_hum_array)
        setUpLabel()
        getRoomTempHum()
        getMotionSenseData()
        getLightSensor()
    }
    
    func getRoomTempHum() {
        let query = PFQuery(className: "temp_hum")
        query.whereKey("uuid", equalTo: uuid!)
        query.findObjectsInBackground { (objects, error) in
            if (error == nil){
                for object in objects! {
                    let temp_humObject = Temp_Hum()
                    temp_humObject.entry_num = object["entry_num"] as! Int
                    temp_humObject.humidity = object["humidity"] as! Double
                    temp_humObject.temperature = object["temperature"] as! Double
                    temp_humObject.uuid = object["uuid"] as! String
                    self.temp_hum_array.append(temp_humObject)
                }
                self.setUpTemp()
                self.setUpHum()
            }
        }
    }
    
    func getMotionSenseData() {
        let query = PFQuery(className: "motion")
        query.whereKey("uuid", equalTo: uuid!)
        query.findObjectsInBackground { (objects, error) in
            if (error == nil){
                for object in objects! {
                    let motionObject = MotionObject()
                    motionObject.uuid = object["uuid"] as! String
                    motionObject.motion = object["motion"] as! Bool
                    motionObject.entry_num = object["entry_num"] as! Int
                    self.motion_array.append(motionObject)
                }
                self.setUpMotionLabel()
            }
        }
    }
    
    func getLightSensor() {
        let query = PFQuery(className: "lighting")
        query.whereKey("uuid", equalTo: uuid!)
        query.findObjectsInBackground { (objects, error) in
            if (error == nil){
                for object in objects! {
                    let lightObject = LightObject()
                    lightObject.uuid = object["uuid"] as! String
                    lightObject.lighting = object["lighting"] as! Int
                    lightObject.entry_num = object["entry_num"] as! Int
                    lightObject.day = object["day"] as! Int
                    lightObject.time = object["time"] as! String
                    self.light_array.append(lightObject)
                }
                self.setUpLight()
            }
        }
    }
    
    
    @objc func buttonPressed() {
        print("button pressed!!")
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
        if let lastEntryTemp = self.temp_hum_array.last {
            tempLabel.text = "\(lastEntryTemp.temperature)"
        }
    }
    
    func setUpHum() {
        if let lastEntryTemp = self.temp_hum_array.last {
            humLabel.text = "\(lastEntryTemp.humidity)"
        }
    }
    
    func setUpMotionLabel() {
        if let lastEntry = self.motion_array.last {
            if (lastEntry.motion){
                roomActivityLabel.text = "Active"
            } else {
                roomActivityLabel.text = "Inactive"
            }
        }
    }
    
    func setUpLight() {
        if let lastEntryTemp = self.light_array.last {
            if (lastEntryTemp.lighting < 50){
                lightLabel.text = "Dark"
            } else if (lastEntryTemp.lighting > 50 && lastEntryTemp.lighting < 200) {
                lightLabel.text = "Average Lighgting"
            } else {
                lightLabel.text = "BRIGHT"
            }
            
            lightLabel.sizeToFit()
        }
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
            query.whereKey("UUID", equalTo: self.uuid!)
            query.findObjectsInBackground(block: { (objects: [PFObject]?, error: Error?) -> Void in
                    if error == nil {
                        for object in objects! {
                            object.deleteEventually()
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
    
    
    @IBAction func tempPicturePushed(_ sender: Any) {
        self.goToGraphVC(dataSet: .temp)
    }
    
    @IBAction func humidityPushed(_ sender: Any) {
        self.goToGraphVC(dataSet: .hum)
    }
    
    @IBAction func lightingPushed(_ sender: Any) {
        self.goToGraphVC(dataSet: .light)
    }
    
    @IBAction func motionPushed(_ sender: Any) {
        self.goToGraphVC(dataSet: .motion)
    }
    
    
    
    func goToGraphVC(dataSet: DataSet) {
        let destinationVC = GraphVC()

        switch dataSet {
        case .temp:
            destinationVC.tempArray = temp_hum_array
            destinationVC.dataChoiceSet = .temp
            break
        case .hum:
            destinationVC.humArray = temp_hum_array
            destinationVC.dataChoiceSet = .hum
            break
        case .light:
            destinationVC.lightArray = light_array
            destinationVC.dataChoiceSet = .light
            break
        case .motion:
            destinationVC.motionArray = motion_array
            destinationVC.dataChoiceSet = .motion
            break
        }
        
        self.present(destinationVC, animated: true, completion: nil)
    }
}
