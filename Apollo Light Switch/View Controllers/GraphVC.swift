//
//  GraphVC.swift
//  Apollo Light Switch
//
//  Created by Ethan Bonin on 4/19/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import Charts
import CoreGraphics

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [Int])
    var sensorDuration2: [String] {get set}
    var dataSet2: [Int] {get set}
}

class GraphVC: UIViewController, GetChartData {
    func getChartData(with dataPoints: [String], values: [Int]) {
        
    }
    
    @IBOutlet var graphView: UIView!
    
    var sensorDuration = [Date]()
    var sensorDuration2 = [String]()
    var dataSet = [Double]()
    var dataSet2 = [Int]()
    
    

    /** Active Data sets */
    var tempArray = [Temp_Hum]()
    var humArray = [Temp_Hum]()
    var lightArray = [LightObject]()
    var motionArray = [MotionObject]()
    var dataChoiceSet: DataSet = .temp
    
    enum DataSet {
        case temp
        case hum
        case light
        case motion
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setChartValues()
    }
    
    func setChartValues() {
        var myData = [[String:Int]]()
        print(dataChoiceSet)
        
        if dataChoiceSet == .light {
            for object in lightArray {
                sensorDuration2.append(object.time)
                dataSet2.append(object.lighting)
                myData.append([object.time:object.lighting])
            }
        }
        
        else if dataChoiceSet == .temp {
            for object in tempArray {
                myData.append([object.time:Int(object.temperature)])
            }
        }

        else if dataChoiceSet == .hum {
            for object in humArray {
                myData.append([object.time:Int(object.humidity)])
            }
        }

        else if dataChoiceSet == .motion {
            for object in motionArray {
                if object.motion {
                    myData.append([object.time:1])
                }
                else {
                    myData.append([object.time:0])
                }
            }
        }
        
        let graph = GraphView(frame: CGRect(x: 0, y: 100, width: 420, height: 200), data: myData)
        self.view.addSubview(graph)
    }
    
}

