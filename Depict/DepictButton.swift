//
//  DepictButton.swift
//  Depict
//
//  Created by Marc Fervil on 28/6/18.
//  Copyright © 2018 Marc Fervil. All rights reserved.
//

import Foundation
import UIKit
import JavaScriptCore

class DepictButton : UIButton {
    
    var this : JSValue = JSValue()
    
    
    @objc dynamic var text : String! {
        get{
            return self.titleLabel?.text
        }
        set(newValue){
            
            self.setTitle(newValue, for: .normal)

        }
    }

    

    
    init(_ this: JSValue) {
        super.init(frame: .zero)
        
        //UIButton(type: .System)
        
       // super.init(type: UIButtonType.system)
        
        
        //self.setBy = UIButtonType.system
        
        
        //self.setTitle("fewf", for: .normal)
        
        
        
        
        DispatchQueue.main.async() {
            let dumbButton = UIButton(type: .system)
            dumbButton.setTitle("a", for: .normal)
        
          //  print(dumbButton.titleLabel?.font)
        
            
            
            self.titleLabel?.font = dumbButton.titleLabel?.font
            self.setTitleColor(dumbButton.titleLabel?.textColor, for: .normal)
           
            
           // self.backgroundColor =
            
            //self.backgroundColor = dumbButton.backgroundColor
        }
        
        self.this = this

        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
        //self.setTitle("dewffefewffffwfwofkowfkoewkfewfkweofwew", for: .normal)
    
        
        
       // self.backgroundColor = .red
 
    }
    
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onPress() {
     //   print( this.toDictionary())
        //print(this)
        
        
        this.forProperty("onClick").call(withArguments: [this])
    }
    
    
}
