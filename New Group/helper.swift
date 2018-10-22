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
        return  def.object(forKey: "FontName") as! String

    }
    
    class func saveFontSize (NewFontSize:String){
        let def = UserDefaults.standard
        def.setValue(NewFontSize, forKey: "FontSize")
        def.synchronize()
    }
    class func getFontSize () -> String{
        let def = UserDefaults.standard
        return  def.object(forKey: "FontSize") as! String
        
    }
    

}
