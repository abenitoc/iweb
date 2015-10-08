//
//  ViewController.swift
//  MuelleAmortiguado
//
//  Created by g336 DIT UPM on 6/10/15.
//  Copyright © 2015 g336 DIT UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kSlider: UISlider!
    @IBOutlet weak var masaSlider: UISlider!
    @IBOutlet weak var lambdaSlider: UISlider!
    
    @IBOutlet weak var vel_posOutlet: UIView!
    @IBOutlet weak var pos_timOutlet: UIView!
    @IBOutlet weak var vel_timOutlet: UIView!
    
    var spring : springModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

