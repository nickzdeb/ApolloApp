//
//  FourthVCViewController.swift
//  Apollo Light Switch
//
//  Created by Nick on 4/24/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import Charts


class FourthVCViewController: UIViewController {
    
    var sensorDuration = [Date]()
    var sensorDuration2 = [Int]()
    var dataSet = [Double]()
    var dataSet2 = [String]()
    
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

    @IBOutlet var lineChartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setChartValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let ThirdVC = storyboard.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdVC
        present(ThirdVC, animated: true, completion: nil)
    }
    
    func setChartValues(_ count : Int = 20) {
        let values = (0..<count).map{ (i)->ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(count))+3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
//        for object in lightArray {
//            sensorDuration2.append(object.time)
//            dataSet2.append(object.lighting)
//        }
        
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
