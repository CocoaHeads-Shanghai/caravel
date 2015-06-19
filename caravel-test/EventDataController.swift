//
//  EventDataController.swift
//  caravel-test
//
//  Created by Adrien on 29/05/15.
//  Copyright (c) 2015 Coshx Labs. All rights reserved.
//

import Foundation
import UIKit
import Caravel

public class EventDataController: UIViewController {
    
    @IBOutlet weak var _webView: UIWebView!
    
    private func _raise(name: String) {
        NSException(name: name, reason: "", userInfo: nil).raise()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        Caravel.getDefault(_webView).whenReady() { bus in
            bus.post("Bool", aBool: true)
            bus.post("Int", anInt: 42)
            bus.post("Float", aFloat: 19.92)
            bus.post("Double", aDouble: 20.15)
            bus.post("String", aString: "Churchill")
            bus.post("HazardousString", aString: "There is a \" and a '")
            bus.post("Array", anArray: [1, 2, 3, 5])
            bus.post("Dictionary", aDictionary: ["foo": 45, "bar": 89])
            bus.post("ComplexArray", anArray: [["name": "Alice", "age": 24], ["name": "Bob", "age": 23]])
            bus.post("ComplexDictionary", aDictionary: ["name": "Cesar", "address": ["street": "Parrot", "city": "Perigueux"], "games": ["Fifa", "Star Wars"]])
            
            bus.register("Int") { name, data in
                if let i = data as? Int {
                    if i != 987 {
                        self._raise("Int - bad value")
                    }
                } else {
                    self._raise("Int - bad type")
                }
            }
            
            bus.register("Float") { name, data in
                if let f = data as? Float {
                    if f != 19.89 {
                        self._raise("Float - bad value")
                    }
                } else {
                    self._raise("Float - bad type")
                }
            }
            
            bus.register("Double") { name, data in
                if let d = data as? Double {
                    if d != 15.15 {
                        self._raise("Double - bad value")
                    }
                } else {
                    self._raise("Double - bad type")
                }
            }
            
            bus.register("String") { name, data in
                if let s = data as? String {
                    if s != "Napoleon" {
                        self._raise("String - bad value")
                    }
                } else {
                    self._raise("String - bad type")
                }
            }
            
            bus.register("Array") { name, data in
                if let a = data as? NSArray {
                    if a.count != 3 {
                        self._raise("Array - bad length")
                    }
                    if a[0] as! Int != 3 {
                        self._raise("Array - bad first element")
                    }
                    if a[1] as! Int != 1 {
                        self._raise("Array - bad second element")
                    }
                    if a[2] as! Int != 4 {
                        self._raise("Array - bad third element")
                    }
                } else {
                    self._raise("Array - bad type")
                }
            }
            
            bus.register("Dictionary") { name, data in
                if let d = data as? NSDictionary {
                    if d.count != 2 {
                        self._raise("Dictionary - bad length")
                    }
                    if d.valueForKey("movie") as! String != "Once upon a time in the West" {
                        self._raise("Dictionary - bad first pair")
                    }
                    if d.valueForKey("actor") as! String != "Charles Bronson" {
                        self._raise("Dictionary - bad second pair")
                    }
                } else {
                    self._raise("Dictionary - bad type")
                }
            }
        }
        
        _webView.loadRequest(NSURLRequest(URL: NSBundle.mainBundle().URLForResource("event_data", withExtension: "html")!))
    }
}