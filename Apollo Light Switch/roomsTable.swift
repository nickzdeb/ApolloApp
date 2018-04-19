//
//  roomsTable.swift
//  Apollo Light Switch
//
//  Created by Nick on 4/6/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension SecondVC: UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let roomCount = currentRoomNames else {
//            return 0
//        }
        return  currentRoomNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") as! UITableViewCell
        
        cell.textLabel?.text = currentRoomNames[indexPath.row].roomName
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected row", indexPath.row)
        
        //Grab cell info
        let cell = tableView.cellForRow(at: indexPath)
        let roomName = cell?.textLabel?.text!
        
        //Prepare view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdVC
        
        destinationVC.roomName = roomName
        destinationVC.uuid = currentRoomNames[indexPath.row].uuid
        
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    
    func constructTableView() {
        tableOfRooms.delegate = self
        tableOfRooms.dataSource = self
        //tableOfRooms.dataSource = currentRoomNames as? UITableViewDataSource
    }
    
    
    
    
}
