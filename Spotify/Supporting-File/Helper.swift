//
//  Helper.swift
//  Spotify
//
//  Created by Imran on 23/3/21.
//

import UIKit

class Helper {
    
    static func getAttributedText(string:String?=nil, font:UIFont?=nil, color:UIColor?=nil, lineSpace:Float?=nil, alignment:NSTextAlignment?=nil) -> NSMutableAttributedString{
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment=alignment ?? NSTextAlignment(rawValue: 0)!
        textStyle.lineSpacing=CGFloat(lineSpace ?? 0)
        //paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        let aMutableString = NSMutableAttributedString(
            string: string ?? "",
            attributes:[NSAttributedString.Key.font:font ?? UIFont.systemFont(ofSize: 14),NSAttributedString.Key.paragraphStyle:textStyle,NSAttributedString.Key.foregroundColor:color!])
        return aMutableString
    }
}
