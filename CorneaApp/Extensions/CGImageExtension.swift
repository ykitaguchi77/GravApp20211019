//
//  CGImageExtension.swift
//  TestProduct (iOS)
//
//  Created by Kuniaki Ohara on 2021/02/02.
//

import SwiftUI

extension CGImage {
    var data: Data? {
        guard let mutableData = CFDataCreateMutable(nil, 0),
            let destination = CGImageDestinationCreateWithData(mutableData, "public.png" as CFString, 1, nil) else { return nil }
        CGImageDestinationAddImage(destination, self, nil)
        guard CGImageDestinationFinalize(destination) else { return nil }
        return mutableData as Data
    }
    
    func cropToSquare() -> CGImage {
        let rectlength = min(self.width, self.height)
        let left = (self.width - rectlength) / 2
        let top = (self.height - rectlength) / 2
        let croppingRect = CGRect(x: left, y: top, width: rectlength, height: rectlength)
        let croppedImage = self.cropping(to: croppingRect)!
        
        return croppedImage
    }
}
