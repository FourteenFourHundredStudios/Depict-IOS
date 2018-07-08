//
//  Depict.swift
//  Depict
//
//  Created by Marc Fervil on 27/6/18.
//  Copyright © 2018 Marc Fervil. All rights reserved.
//

import Foundation
import JavaScriptCore
import UIKit

class Depict {
    
    var jsContext: JSContext!
    var view: UIView!
    
    var display : ((String) -> () )?
    
    var propertyMap : Dictionary<AnyHashable, Dictionary<AnyHashable, Any>> = [ : ]
    
    init(view : UIView){
        
        self.jsContext = JSContext()
        self.view = view
        setupBuiltins()
        startJS()
    
    }
    
    func startJS(){
        
        self.jsContext.evaluateScript(loadFile(name: "depict"))
        self.propertyMap = jsContext.objectForKeyedSubscript("propertyMap").toDictionary() as! Dictionary<AnyHashable, Dictionary<AnyHashable, Any>>
        
        self.jsContext.evaluateScript(loadFile(name: "init"))
    
    }
    
    func loadFile(name : String) -> String{
        do{
            let jsSourcePath : String = Bundle.main.path(forResource: "/DepictJS/"+name, ofType: "js")!
            let jsSourceContents = try String(contentsOfFile: jsSourcePath)
            return jsSourceContents
        }catch{
            print(error)
        }
        return ""
    }
    

    func setupBuiltins(){

        let display: @convention(block) (String) -> Void = { messsage in
            print("Depict:", messsage)
        }
        
        let depict: @convention(block) (JSValue) -> Void = { elements in
            for elementValue in elements.toDictionary().keys{
                //let element = elementValue as? Dictionary <String, Any>
                //print(el)
                let element = elements.forProperty(elementValue as! String)!
             
                
                let elementView = self.renderElement(element)

                self.view.addSubview(elementView)
                self.initView(elementView)
                
                
            }
        }

        self.jsContext.setObject(display, forKeyedSubscript: "print" as NSCopying & NSObjectProtocol )
        self.jsContext.setObject(depict, forKeyedSubscript: "__depict__" as NSCopying & NSObjectProtocol )
    }
    
    func viewFromIs( _ jsElement :  JSValue) -> UIView {
    
        let d = DepictButton(jsElement)
        d.text = "butts"
        
        let views = [
            "layout" : UIStackView(),
            "text" : UILabel(),
            "textInput" : UITextField(),
            "button" : d
            
        ]
        //print("YEEEE",jsElement.toDictionary())
    
       // print (jsElement.forProperty("is"))
        
        return views[jsElement.forProperty("is")!.toString()!]!
    }
    
    func initView(_ element : UIView){
        
        
        
        if let elementStackView = element as? UIStackView {
            
            elementStackView.distribution  = UIStackViewDistribution.equalSpacing
            elementStackView.translatesAutoresizingMaskIntoConstraints = false;
            elementStackView.spacing = 10.0
            elementStackView.alignment = .fill
            
            let margins = elementStackView.superview!.layoutMarginsGuide
            
            //let margins = elementStackView.superview!
            
            let leading = elementStackView.leadingAnchor.constraint(equalTo:  margins.leadingAnchor)
            
        
            
            leading.priority = UILayoutPriority(rawValue: 1)
            leading.isActive = true
            
            let top = elementStackView.topAnchor.constraint(equalTo: margins.topAnchor)
            
            top.priority = UILayoutPriority(rawValue: 1)
            top.isActive = true
            
          
          //  let f = UILabel()
          //  f.text = "DONE"
            
         //   elementStackView.addArrangedSubview(f)
            
            
        }
    }
    

    func renderElement(_ element : JSValue) -> UIView{
        let elementView = viewFromIs(element)
        
        
        for i in element.toDictionary().keys{
            
            let key = (i as! String)
            
            if key == "with" || key == "is" || key == "onClick" {
                continue
            }
            
            let value = element.forProperty(key).toString()
            
            let swiftVal = propertyMap[key]!["ios"]!
            
   
            elementView.setValue(value!, forKey: swiftVal as! String)
            

        }
        
        if element.hasProperty("with"){


            for i in 0...element.forProperty("with").toArray().count-1 {
            
                let element = element.forProperty("with").atIndex(i)!
                //print(element.toDictionary())
                
                let renderedView = renderElement(element)
                
                
                
                (elementView as? UIStackView)!.addArrangedSubview(renderedView)
                initView(renderedView)
            }
        }
        
        
        return elementView
    }
    
    
    
    
    
}
    

    

 

    
    







