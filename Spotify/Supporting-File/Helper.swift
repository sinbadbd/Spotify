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
extension UINavigationController {

  public func presentTransparentNavigationBar() {
    navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
    navigationBar.isTranslucent = true
    navigationBar.shadowImage = UIImage()
    setNavigationBarHidden(false, animated:true)
  }

  public func hideTransparentNavigationBar() {
    setNavigationBarHidden(true, animated:false)
//    navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
    navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
    navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
  }
}

extension UIImageView
{
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
    
    func addBlurEffect()
        {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds

            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
            self.addSubview(blurEffectView)
        }
}
