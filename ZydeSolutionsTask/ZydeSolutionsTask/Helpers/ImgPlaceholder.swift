//
//  ImgPlaceholder.swift
//  ZydeSolutionsTask
//
//  Created by Shyam Kumar on 10/1/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation
import UIKit

struct ImgPlaceholder {
    
    
    
    static func generateImg(str: String, imgView: UIImageView, gradientBg:Bool? = nil, plainBg:Bool? = nil)  {
       
        var firstChar: Substring = ""
        
        var secondChar: Substring = ""
        
        var name: String = ""
        
        firstChar = str.prefix(1)

        if str.contains(" ") {
          if let range = str.range(of: " ") {
              let char = str[range.upperBound...]
                 secondChar = char.prefix(1)
          }
        }
        
        name = String(firstChar + secondChar).uppercased()
        
        if let _ = gradientBg {
           
            if String(secondChar).isEmpty {
                ConfigureImg.gradColor(a: String(firstChar), b: String(firstChar), imageView: imgView)
            }else {
                 ConfigureImg.gradColor(a: String(firstChar), b: String(secondChar), imageView: imgView)
            }
            
        } else {
              ConfigureImg.plainBg(str: name, imageView: imgView)
        }
        

        ConfigureImg.nameLbl(str: name, imageView: imgView)
        
        
        
    }
}

