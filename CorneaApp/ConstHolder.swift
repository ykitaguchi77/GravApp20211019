//
//  ConstHolder.swift
//  CorneaApp
//
//  Reused by Yoshiyuki Kitaguchi on 2021/04/19.
//  Created by Kuniaki Ohara on 2021/01/06.
//
import SwiftUI

class ConstHolder{
    static public let QUESTIONFILENAME = "testq.txt"
    static public let EVALIMAGESIZE = CGSize(width: 224, height: 224)
    static public let HWRATIO: CGFloat = 1 //縦横比
    static public let IMAGESCALE: CGFloat = 0.7 //プレビュー画面の大きさ
    static public let FACEMASKNAME1 = "front"
    static public let FACEMASKNAME2 = "left"
    static public let FACEMASKNAME3 = "right"
    static public let FACEMASKNAME4 = "down"
    static public let FACEMASKNAME5 = "up"
    static public let PROCESSINGMASKNAME = "Processing"
    
    
    static public let EVALURL = "http://20.63.174.246:80/api/v1/service/test/score"
    static public let EVALKEY = "chjl5DCcSgWUdpWgDkPENIZqCZoF8sJa"
    
    static public let IMAGECONTAINERURI = "https://gravdata.blob.core.windows.net/gravimage?sv=2019-12-12&st=2021-02-08T04%3A06%3A06Z&se=2021-02-28T04%3A06%3A00Z&sr=c&sp=w&sig=RKIGvk8oS47%2F680eDmUpsyyW03I7zv7S0i%2FVlwVU3RQ%3D"
    static public let TEXTCONTAINERURI = "https://gravdata.blob.core.windows.net/gravtext?sv=2019-12-12&st=2021-02-08T04%3A08%3A02Z&se=2021-02-28T04%3A08%3A00Z&sr=c&sp=w&sig=HUmrbS056b3yeRZwzLTbWdmHXrQF8vIUhM466IDU5Cc%3D"
}
