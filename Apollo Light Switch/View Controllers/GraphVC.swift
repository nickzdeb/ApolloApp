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
    func getChartData(with dataPoints: [Date], values: [Double])
    var sensorDuration: [Date] {get set}
    var dataSet: [Double] {get set}
}

class GraphVC: UIViewController, GetChartData {
    func getChartData(with dataPoints: [Date], values: [Double]) {
        
    }
    
    
    var sensorDuration = [Date]()
    var dataSet = [Double]()
    

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
    }
    
    
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
