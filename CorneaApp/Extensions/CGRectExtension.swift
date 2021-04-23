//
//  ContentView.swift
//  Shared
//
//  Created by Kuniaki Ohara on 2021/01/06.
//
import SwiftUI

extension CGRect {
    /// 反転させたサイズを返す
    var switched: CGRect {
        return CGRect(x: minY, y: minX, width: height, height: width)
    }
}
