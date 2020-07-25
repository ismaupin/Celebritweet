//
//  AspectFillView.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/24/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Cocoa

class AspectFillView: NSImageView {
   
  override var image: NSImage? {

           set {

               self.layer = CALayer()

            self.layer?.contentsGravity = CALayerContentsGravity.resizeAspectFill

               self.layer?.contents = newValue

               self.wantsLayer = true

               

               super.image = newValue

           }

           

           get {

               return super.image

           }

       }

    
}
