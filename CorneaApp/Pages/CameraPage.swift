//
//  ContentView.swift
//  Shared
//
//  Created by Kuniaki Ohara on 2021/01/06.
//
import SwiftUI
import AVFoundation

struct CameraPage: View, CameraActions {
    let LastProcessIndex = 4.0
    let FaceMaskOpacity = 0.3
    let MASKNAMES:[String] = [ConstHolder.FACEMASKNAME1]

    @ObservedObject var events = UserEvents()
    //@Binding var rootActive: Bool
    
    @State var showCamera = true
    @State var showGuide = true
    @State var isSubCamera = false
    //@ObservedObject var cameraController = CameraController()
    @State private var currentProgress: Double = 0.0
    @State var goSendPhoto = false
    @State private var backToMain = false  //保存してメインに戻るボタン

    
    var body: some View {
        GeometryReader { bodyView in
 
                VStack{
                    
                    //インカメ切り替えアイコン

                    
                    //ガイドメッセージ
                    /*
                    Text("角膜をガイドに合わせて撮影してください")
                        .foregroundColor(Color.black)
                        .font(Font.title)
                        .padding([.horizontal])
                    */
                    CameraView(events: events, applicationName: "SwiftUICam")

                    
                    //Spacer()
                    Button(action: {
                            self.rotateCamera(events: events)
                        
                    })
                        {Text("カメラ切り替え")
                            .foregroundColor(Color.white)
                            .font(Font.largeTitle)
                        }
                        .onTapGesture {}
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 60)
                        .background(Color.black)
                        .padding()
                    
                    Button(action: {
                            self.takePhoto(events: events)
                    })
                        {Text("撮影")
                            .foregroundColor(Color.white)
                            .font(Font.largeTitle)
                        }
                        .onTapGesture {}
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 60)
                        .background(Color.black)
                        .padding()
                    
                
                    Button(action: {
                            self.backToMain = true /*またはself.show.toggle() */
                    }) {
                        Text("保存")
                            .foregroundColor(Color.white)
                            .font(Font.largeTitle)
                        }
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 60)
                        .background(Color.black)
                        .padding()
                        .sheet(isPresented: self.$backToMain) {
                            ContentView()
                        }
                }
                }
    }

}

//struct CameraPage_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CameraPage()
//        }
//    }
//}
