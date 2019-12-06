//
//  ThreeDimObject.swift
//  3D Demo
//
//  Created by LorentzenN on 12/3/19.
//  Copyright © 2019 Lorentzen. All rights reserved.
//

import Foundation
class ThreeDimObject {
    var points : [SpecialPoint]
    var myTimer : Timer
    
    weak var delegate: ThreeDimObjectDelegate?
    
    init(points : [SpecialPoint]) {
        self.points = points
        myTimer = Timer()
    }
    
    func runTimer() {
        myTimer = Timer.scheduledTimer(timeInterval: 0.07, target: self, selector: #selector(updateVals), userInfo: nil, repeats: true)
    }
    
    @objc func updateVals() {
        delegate?.valsUpdated()
    }
}

protocol ThreeDimObjectDelegate : class {
    ///Reminds other class to re draw
    func valsUpdated()

}
