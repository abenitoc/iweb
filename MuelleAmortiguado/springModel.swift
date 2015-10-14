//
//  springModel.swift
//  MuelleAmortiguado
//
//  Created by g336 DIT UPM on 6/10/15.
//  Copyright © 2015 g336 DIT UPM. All rights reserved.
//

import Foundation

class springModel{
    var masa = 10.0{
    didSet{
        updatectes()
    }
}

    var k = 1000.0{
        didSet{
            updatectes()
        }
    }
    var lambda = 20.0{
        didSet{
            updatectes()
        }
}
    
    private var wo = 1.0, gamma = 1.0, omega = 1.0, A = 1.0, fi = 1.0, xo = 2.0, vo = 0.0
    
    func updatectes(){
            wo = sqrt(k/masa)
            gamma = lambda/(masa*2)
            omega = sqrt((wo*wo)-(gamma*gamma))
            A = sqrt((xo*xo)+pow((vo+gamma*xo)/omega,2))
            fi = atan2(xo*omega,(wo*omega*xo))
    }
    
    func posAtTime(t:Double)->Double{
        let wtf = omega * t + fi
        let e = gamma * t
        
        return A*exp(-e)*sin(wtf)
    }
    
    func speedAtTime(t:Double)->Double{
        let ini = gamma * A
        let wtf = omega * t + fi
        let e = gamma * t
        return -ini * exp(-e) * sin(wtf) + A * exp(-e) * omega * cos(wtf)
    }
    
    
}