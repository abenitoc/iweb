//
//  springVIew.swift
//  MuelleAmortiguado
//
//  Created by g336 DIT UPM on 8/10/15.
//  Copyright © 2015 g336 DIT UPM. All rights reserved.
//

import UIKit

struct Point{
    var x = 0
    var y = 0
}

protocol springViewDataSource : class{
    func startTimeOfSpringView( springView: SpringView ) -> Double
    func endTimeOfSpringView(springView: SpringView)-> Double
    func pointOfSpringView(springView: SpringView, t: Double)-> Point
}

class SpringView : UIView{
    var dataSource = 1.0
}