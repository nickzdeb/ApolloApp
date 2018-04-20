//
//  GraphVC.swift
//  Apollo Light Switch
//
//  Created by Ethan Bonin on 4/19/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import Charts

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [Int])
    var sensorDuration2: [String] {get set}
    var dataSet2: [Int] {get set}
}

class GraphVC: UIViewController, GetChartData {
    func getChartData(with dataPoints: [String], values: [Int]) {
        
    }
    
    
    var sensorDuration = [Date]()
    var sensorDuration2 = [String]()
    var dataSet = [Double]()
    var dataSet2 = [Int]()
    

    /** Active Components */
    var ChartsView = LineChartView()
    

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
        constructChartsView()
        populateChartData()
        //lineChart()
    }
    
    func populateChartData() {
        
        for object in lightArray {
            sensorDuration2.append(object.time)
            dataSet2.append(object.lighting)
        }
        
        self.getChartData(with: sensorDuration2, values: dataSet2)
        //print(dataSet2)
         //print(sensorDuration2)
        //print(lightArray)
        //print("this called")
        //timeOfDay =
        //sensorData =
    }
    
//    func lineChart() {
//        let lineChart = lineChart(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height))
//        lineChart.delegate = self
//        self.view.addSubview(lineChart)
//    }
    
}


extension GraphVC {
    
    func constructChartsView() {
        layoutChartsView()
    }
    
    
    func layoutChartsView() {
        ChartsView.frame = CGRect(x: 0,
                                  y: 100,
                                  width: self.view.frame.width,
                                  height: self.view.frame.height)
        self.view.addSubview(ChartsView)
    }
}
