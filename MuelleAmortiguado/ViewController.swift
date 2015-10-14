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
        
        spring = springModel()
        
        vel_timOutlet.dataSource = self
        pos_timOutlet.dataSource = self
        vel_posOutlet.dataSource = self
        
        vel_timOutlet.type = SpecificView.VelTime
        pos_timOutlet.type = SpecificView.PosTime
        vel_posOutlet.type = SpecificView.PosVel
        
        
        vel_posOutlet.scaleX = 30.0
        vel_posOutlet.scaleY = 2.5
        
        pos_timOutlet.scaleX = 30.0
        pos_timOutlet.scaleY = 25.0
        
        vel_posOutlet.scaleX = 30.0
        vel_posOutlet.scaleY = 3.5
        
        kSlider.sendActionsForControlEvents(.ValueChanged)
        masaSlider.sendActionsForControlEvents(.ValueChanged)
        lambdaSlider.sendActionsForControlEvents(.ValueChanged)
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
        return 10
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
            return Point(x: t, y: t)
        }
    }
}


