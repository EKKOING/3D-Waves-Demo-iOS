//
//  ViewController.swift
//  3D Demo
//
//  Created by LorentzenN on 12/3/19.
//  Copyright © 2019 Lorentzen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ObjectViewDelegate{
    
    var objectView : ObjectView = ObjectView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectView = ObjectView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        objectView.delegate = self
        
        self.view.addSubview(objectView)

    }
    
    func redraw() {
        objectView.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
        }
    }
}

