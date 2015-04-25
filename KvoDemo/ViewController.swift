//
//  ViewController.swift
//  KvoDemo
//
//  Created by pandazheng on 15/4/24.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import UIKit

class MyClass1 : NSObject
{
    dynamic var value : Bool = false
}

class MyClass2 : NSObject
{
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        println("I heard about the change!")
        println(object.valueForKeyPath(keyPath)!)
        println(change)
        println(context == &con)
        let c = UnsafeMutablePointer<String>(context)
        let s = c.memory
        println(s)
    }
}

private var con = "ObserveValue"




class ViewController: UIViewController {

    var objectA : NSObject!
    var objectB : NSObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        objectA = MyClass1()
        objectB = MyClass2()
        let opts : NSKeyValueObservingOptions = .New | .Old
        objectA.addObserver(objectB, forKeyPath: "value", options: opts, context: &con)
        (objectA as! MyClass1).value = true
        objectA.removeObserver(objectB, forKeyPath: "value")
        objectA = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

