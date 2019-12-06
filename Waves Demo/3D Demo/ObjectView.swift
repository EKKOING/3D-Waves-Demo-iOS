//
//  ObjectView.swift
//  3D Demo
//
//  Created by LorentzenN on 12/3/19.
//  Copyright © 2019 Lorentzen. All rights reserved.
//

import UIKit
import Foundation

class ObjectView: UIView, ThreeDimObjectDelegate {
    
    var path: UIBezierPath!
    var currentShape : ThreeDimObject = ThreeDimObject(points: [])
    weak var delegate: ObjectViewDelegate?
    
    var currentWaveStart : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
        currentShape = ThreeDimObject(points: [])
        currentShape.delegate = self
        currentShape.runTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        currentShape = ThreeDimObject(points: [])
        currentShape.delegate = self
    }
    
    override func draw(_ rect: CGRect) {
        self.drawCircles()
    }
    
    func valsUpdated() {
        currentWaveStart = currentWaveStart + 0.2
        if currentWaveStart > 4 * CGFloat(Double.pi) {
            currentWaveStart = currentWaveStart - (CGFloat(Double.pi)  * ((currentWaveStart / CGFloat(Double.pi)) - 2))
            //print(currentWaveStart)
        }
        delegate?.redraw()
    }
    
    func drawCircles() {
        
        self.path = UIBezierPath()
        
        var paths : [UIBezierPath] = []
        
        var yHeight : CGFloat = 0
        var xMod : CGFloat = 0
        for waveNum in 0..<8 {
            
            let path1 = UIBezierPath()
            path1.move(to: CGPoint(x: -1, y: CGFloat(sin(currentWaveStart + xMod)) + yHeight + (CGFloat(self.frame.height) / 2.0)))
            for screenLocX in 0..<Int(self.frame.width) {
                let sinInput : CGFloat = currentWaveStart + ((CGFloat(screenLocX) + xMod) / CGFloat((Double.pi * 20)))
                let waveAmplitude : CGFloat = (10.0 * (4.0 / (CGFloat(waveNum) + 4.0)))
                path1.addLine(to: CGPoint(x: CGFloat(screenLocX), y: CGFloat(sin(sinInput)) * waveAmplitude + (CGFloat(self.frame.height) / 2.0) + yHeight))
            }
            path1.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            path1.addLine(to: CGPoint(x: 0.0, y: self.frame.height))
            path1.close()
            UIColor(hue: CGFloat(202.0 / 360.0) + (0.001 * CGFloat(waveNum)), saturation: ((35.0 / 8.0) * CGFloat(waveNum) + 40.0) / 100.0, brightness: 0.8, alpha: (0.82 / 9.0) * (CGFloat(waveNum) + 1.0)).setFill()
            path1.lineWidth = 3.0 / ( (8.0 - CGFloat(waveNum)) / 8.0 * 2.0 + 1.0)
            path1.fill()
            path1.stroke()
            paths.append(path1)
            yHeight = yHeight + 20
            xMod = xMod + 20
        }
        
        for path2 in paths {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path2.cgPath
        }
    }
    
}

protocol ObjectViewDelegate : class {
    ///Passes the readout for the timer for display on the screen
    func redraw()
}
