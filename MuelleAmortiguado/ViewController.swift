//
//  ViewController.swift
//  MuelleAmortiguado
//
//  Created by g336 DIT UPM on 6/10/15.
//  Copyright © 2015 g336 DIT UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, springViewDataSource {

    @IBOutlet weak var kSlider: UISlider!
    @IBOutlet weak var masaSlider: UISlider!
    @IBOutlet weak var lambdaSlider: UISlider!
    
    @IBOutlet weak var vel_posOutlet: SpringView!
    @IBOutlet weak var pos_timOutlet: SpringView!
    @IBOutlet weak var vel_timOutlet: SpringView!
    
    var spring : springModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vel_timOutlet.dataSource = self
        pos_timOutlet.dataSource = self
        vel_timOutlet.dataSource = self
        
        kSlider.sendActionsForControlEvents(.ValueChanged)
        masaSlider.sendActionsForControlEvents(.ValueChanged)
        lambdaSlider.sendActionsForControlEvents(.ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func kChange(sender: UISlider) {
        spring.k = Double(sender.value)
        
        vel_posOutlet.setNeedsDisplay()
        pos_timOutlet.setNeedsDisplay()
        vel_timOutlet.setNeedsDisplay()
    }
    
    @IBAction func masaChange(sender: UISlider) {
        spring.masa = Double(sender.value)
        
        vel_posOutlet.setNeedsDisplay()
        pos_timOutlet.setNeedsDisplay()
        vel_timOutlet.setNeedsDisplay()
    
    }
    
    @IBAction func lambdaChange(sender: UISlider) {
        spring.lambda = Double(sender.value)
        
        vel_posOutlet.setNeedsDisplay()
        pos_timOutlet.setNeedsDisplay()
        vel_timOutlet.setNeedsDisplay()
    }
    
    func startTimeOfSpringView( springView: SpringView ) -> Double{
        return 0
    }
    
    func endTimeOfSpringView(springView: SpringView) -> Double{
        return 200
    }

    func pointOfSpringView(springView: SpringView, atTime t: Double) -> Point{
        switch springView {
        case pos_timOutlet:
            return Point(x:t, y: spring.posAtTime(t))
        case vel_timOutlet:
            return Point(x:t, y: spring.speedAtTime(t))
        case vel_posOutlet:
            return Point(x: spring.posAtTime(t), y:spring.speedAtTime(t))
        default:
            return Point(x: 0.0, y: 0.0)
        }
    }
}


