//
//  springVIew.swift
//  MuelleAmortiguado
//
//  Created by g336 DIT UPM on 8/10/15.
//  Copyright © 2015 g336 DIT UPM. All rights reserved.
//

import UIKit

struct Point{
    var x = 0.0
    var y = 0.0
}

protocol springViewDataSource : class{
    func startTimeOfSpringView( springView: SpringView ) -> Double
    func endTimeOfSpringView(springView: SpringView)-> Double
    func pointOfSpringView(springView: SpringView, atTime t: Double)-> Point
}

enum SpecificView{
    case PosVel,VelTime,PosTime
}

@IBDesignable
class SpringView : UIView{
    
    var scaleX: Double = 30.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    var scaleY: Double = 3.5{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    var originX: CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    var originY: CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    var resolution: Double = 500.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var type =  SpecificView.PosVel {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var lineWidth : Double = 1.5
    
    #if TARGET_INTERFACE_BUILDER
        var dataSource: springViewDataSource!
    #else
        weak var dataSource: springViewDataSource!
    #endif
    
    override func prepareForInterfaceBuilder(){
        class FakeDataSource: springViewDataSource{
        
            func startTimeOfSpringView(functionView: SpringView) -> Double{
                return 0
            }
            
            func endTimeOfSpringView(functionView: SpringView)-> Double {
                return 200
            }
            
            func pointOfSpringView(functionView: SpringView, atTime t: Double ) -> Point {
                return Point(x: t, y: t%50)
            }
            
        }
        dataSource = FakeDataSource()
    }
    
    override func drawRect(rect: CGRect) {
        drawAxis()
        drawFunction()
        drawLabels()
    }
    
    private func drawFunction() {
        
        let startTime = dataSource.startTimeOfSpringView(self)
        let endTime = dataSource.endTimeOfSpringView(self)
        let incrTime = max((endTime - startTime) / resolution , 0.01)
        let path = UIBezierPath()
        let color = UIColor.redColor()
        color.setStroke()
        
        var position = dataSource.pointOfSpringView(self, atTime: startTime)
        var x = xPosition(position.x)
        var y = yPosition(position.y)
        
        path.moveToPoint(CGPointMake(x, y))
        
        for var t = startTime ; t < endTime ; t += incrTime {
            position = dataSource.pointOfSpringView(self, atTime: t)
            x = xPosition(position.x)
            y = yPosition(position.y)
            path.addLineToPoint(CGPointMake(x, y))
        }
        
        path.lineWidth = CGFloat(lineWidth)
        
        path.stroke()
    }
    
    
    private func drawAxis() {
    
        let width = bounds.size.width
        let height = bounds.size.height
        
        let yaxis = UIBezierPath()
        yaxis.moveToPoint(CGPointMake(width/2 + originX , 0 - abs(originY)))
        yaxis.addLineToPoint(CGPointMake(width/2 + originX , height + abs(originY)))
       
        let xaxis = UIBezierPath()
        xaxis.moveToPoint(CGPointMake(0 - abs(originX), height/2 + originY))
        xaxis.addLineToPoint(CGPointMake(width + abs(originX), height/2 + originY))
        
        UIColor.blackColor().setStroke()
        
        yaxis.stroke()
        xaxis.stroke()
        
        
    }
    
    private func drawLabels(){
        let theSubviews = self.subviews
        
        for ( view ) in theSubviews
        {
            view.removeFromSuperview()
        }
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let yLabel =  UILabel(frame: CGRectMake((width-10), (height/2+10), 10, 10))
        yLabel.font = UIFont.systemFontOfSize(10)
        yLabel.setNeedsDisplay()
        
        let xLabel = UILabel(frame: CGRectMake((width/2) + 5, 0, 10, 10))
        xLabel.font = UIFont.systemFontOfSize(10)
        
        switch type{
        case .VelTime:
            xLabel.text = "t"
            yLabel.text = "v"
        case .PosTime:
            xLabel.text = "t"
            yLabel.text = "p"
        case .PosVel:
            xLabel.text = "v"
            yLabel.text = "p"
        }
        
        xLabel.setNeedsDisplay()
        
        self.sendSubviewToBack(xLabel)
        self.sendSubviewToBack(yLabel)
        self.addSubview(yLabel)
        self.addSubview(xLabel)
    }
    
    private func xPosition(x: Double) -> CGFloat {
        let width = bounds.size.width
        return width/2 + originX + CGFloat(x*scaleX)
        
    }
    
    private func yPosition(y: Double) -> CGFloat {
        let height = bounds.size.height
        return height/2 - CGFloat(y*scaleY) + originY
    }
    
	}