//
//  ContentView.swift
//  Shared
//
//  Created by Kuniaki Ohara on 2021/01/06.
//


import SwiftUI

struct CameraPage: View {
    
    @ObservedObject var user: User
    @State var imageData : Data = .init(capacity:0)
    @State var rawImage : Data = .init(capacity:0)
    @State var source:UIImagePickerController.SourceType = .camera

    @State var isActionSheet = true
    @State var isImagePicker = true
    

    
    var body: some View {
            NavigationView{
                VStack(spacing:0){
                        ZStack{
                            NavigationLink(
                                destination: Imagepicker(show: $isImagePicker, image: $imageData,  sourceType: source),
                                isActive:$isImagePicker,
                                label: {
                                    Text("TakePhoto")
                                })
                            VStack{
                                if imageData.count != 0{
                                    SendData(user:user)
                                    
//                                    Image(uiImage: UIImage(data: self.imageData)!)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(height: 250)
//                                        .cornerRadius(15)
//                                        .padding()
//                                }
//                                HStack(spacing:30){
//                                    Button(action: {
//                                            self.source = .photoLibrary
//                                            self.isImagePicker.toggle()
//                                    }, label: {
//                                        Text("Upload")
//                                    })
//                                    Button(action: {
//                                            self.source = .camera
//                                            self.isImagePicker.toggle()
//                                    }, label: {
//                                        Text("Take Photo")
//                                    })
//                                }
                            }
                        }
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    }
    
    
}

}


//
//import SwiftUI
//import AVFoundation
//
//struct CameraPage: View, CameraActions {
//    let LastProcessIndex = 4.0
//    let FaceMaskOpacity = 0.3
//    let screenSize: CGRect = UIScreen.main.bounds
//
//    @ObservedObject var events = UserEvents()
//    //@Binding var rootActive: Bool
//
//    @State var showCamera = true
//    @State var showGuide = true
//    @State var isSubCamera = false
//    //@ObservedObject var cameraController = CameraController()
//    //@State private var currentProgress: Double = 0.0
//    @State var photoNotTaken = true //1??????????????????false????????????????????????
//    @State private var goTakePhoto: Bool = false  //???????????????
//    @State var goSendPhoto = false
//    @State private var backToMain = false  //???????????????????????????????????????
//
//
//
//    var body: some View {
//        GeometryReader { bodyView in
//            ZStack{
//                CameraView(events: events, applicationName: "SwiftUICam")
//
//                VStack(spacing: -10){
//                    Text("?????????????????????????????????????????????????????????")
//                        .foregroundColor(Color.black)
//                        .font(Font.title)
//                        .frame(width: screenSize.width * 0.8)
//                        //.padding([.horizontal])
//
//                    Spacer().frame(height: screenSize.height * 0.04)
//
//                    HStack{
//                        Button(action: {
//                            self.showGuide = !self.showGuide
//                        })
//                            {Text("?????????on/off")
//                                .foregroundColor(Color.white)
//                                .font(Font.title3)
//                            }
//                            .onTapGesture {}
//                            .frame(width: screenSize.width * 1/3, height: screenSize.height * 0.05)
//                            .background(Color.black)
//                            .padding()
//
//
//                        Button(action: {
//                                self.rotateCamera(events: events)
//                        })
//                            {Text("?????????????????????")
//                                .foregroundColor(Color.white)
//                                .font(Font.title3)
//                            }
//                            .onTapGesture {}
//                            .frame(width: screenSize.width * 1/3, height: screenSize.height * 0.05)
//                            .background(Color.black)
//                            .padding()
//                    }
//
//                    Spacer().frame(height: screenSize.height * 0.02)  //??????????????????????????????????????????????????????????????????????????????
//
//                    //?????????
//                    ZStack{
//                        Rectangle()
//                            .fill(Color.blue)
//                            .frame(width: screenSize.width, height: screenSize.width * 0.9)  //???????????????????????????????????????CameraViewContoller????????????????????????
//                            .opacity(0)
//                        if(self.showGuide){
//                            Circle()
//                                .stroke(Color.white, lineWidth: 5)
//                                .frame(width: screenSize.width * 0.3, height: screenSize.height * 0.3)
//                                .opacity(FaceMaskOpacity)
//                        }
//                    }
//
//
//
//                    Spacer().frame(height: screenSize.height * 0.02)
//
//
//
//                    if(self.photoNotTaken){
//                        Button(action: {
//                            self.takePhoto(events: events)
//                            self.photoNotTaken = !self.photoNotTaken
//                        })
//                            {Text("??????")
//                                .foregroundColor(Color.white)
//                                .font(Font.largeTitle)
//                            }
//                            .onTapGesture {}
//                            .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.12)
//                            .background(Color.black)
//                            .padding()
//                    }else{
//                        Button(action: {
//                            self.goTakePhoto = true
//                        })
//                            {Text("?????????")
//                                .foregroundColor(Color.white)
//                                .font(Font.largeTitle)
//                            }
//                            .onTapGesture {}
//                            .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.12)
//                            .background(Color.black)
//                            .padding()
//                        .sheet(isPresented: self.$goTakePhoto) {
//                            CameraPage()
//                        }
//                    }
//
//
//                    Button(action: {
//                        //????????????sheet???????????????????????????????????????
//                        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
//                    }) {
//
//                        Text("??????")
//                            .foregroundColor(Color.white)
//                            .font(Font.largeTitle)
//                        }
//                        .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.08)
//                        .background(Color.black)
//                        .padding()
//                        .sheet(isPresented: self.$backToMain) {
//                            ContentView()
//
//                        }
//                }
//            }
//        }
//    }
//
//}
