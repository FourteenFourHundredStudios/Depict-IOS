//
//  ViewController.swift
//  Depict
//
//  Created by Marc Fervil on 27/6/18.
//  Copyright © 2018 Marc Fervil. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        _ = Depict(view: self.view!)
        

    }

    func demo(){
    
        
        
        
      //  self.jsContext.objectForKeyedSubscript("test").call(withArguments: [])
        
        /*
        if let functionFullname = self.jsContext.objectForKeyedSubscript("test") {
            // Call the function that composes the fullname.
            if let fullname = functionFullname.call(withArguments: ["bird"]) {
                print(fullname)
            }
        }*/

    }
    
    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

