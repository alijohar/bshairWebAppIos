//
//  helper.swift
//  bshairWebAppIos
//
//  Created by johar on 10/16/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit

class helper: NSObject {
    class func saveFontName (NewFontName:String){
        let def = UserDefaults.standard
        def.setValue(NewFontName, forKey: "FontName")
        def.synchronize()
    }
//
    class func getFontName () -> String{
        let def = UserDefaults.standard
        if (def.object(forKey: "FontName") == nil){
            return "NoFontName"
        }
        else{
        return  def.object(forKey: "FontName") as! String
    }
    }
    
    class func saveFontSize (NewFontSize:String){
        let def = UserDefaults.standard
        def.setValue(NewFontSize, forKey: "FontSize")
        def.synchronize()
    }
    class func getFontSize () -> String{
        let def = UserDefaults.standard
        if (def.object(forKey: "FontSize") == nil){
            return "NoFontSize"
        }
        else {
        return  def.object(forKey: "FontSize") as! String
        }
    }
    
    class func saveFontNameRow (row:Int){
        let def = UserDefaults.standard
        def.setValue(row, forKey: "FontNameRow")
        def.synchronize()

    }

    class func saveFontSizeRow (row:Int){
        let def = UserDefaults.standard
        def.setValue(row, forKey: "FontSizeRow")
        def.synchronize()
        
    }
    
    class func getFontNameRow () -> Int{
        let def = UserDefaults.standard
        if (def.object(forKey: "FontNameRow") == nil){
            return 1000
        }
        else{
            return  def.object(forKey: "FontNameRow") as! Int
        }
    }
    
    class func getFontSizeRow () -> Int{
        let def = UserDefaults.standard
        if (def.object(forKey: "FontSizeRow") == nil){
            return 1000
        }
        else {
            return  def.object(forKey: "FontSizeRow") as! Int
        }
    }

    

}
