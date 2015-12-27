//
//  FileReader.swift
//  VoiceRecorder
//
//  Created by Chris Yu on 2015/12/26.
//  Copyright (c) 2015年 Chris Yu. All rights reserved.
//

import UIKit

class FileReader: NSObject {
    class func readFiles() -> [String] {
        return  NSBundle.mainBundle().pathsForResourcesOfType("mp3", inDirectory: nil) as! [String]
    }
}
