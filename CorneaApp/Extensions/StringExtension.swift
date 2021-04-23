//
//  StringExtension.swift
//  TestProduct (iOS)
//
//  Created by Kuniaki Ohara on 2021/02/02.
//
import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
