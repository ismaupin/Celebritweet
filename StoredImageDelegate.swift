//
//  StoredImageDelegate.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 8/8/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation
import Cocoa


public protocol StoredImageDelegate {
    func didSetFirstTweet(_ image:NSImage)
    func didSetSecondTweet(_ image:NSImage)
}
