//
//  ContentView.swift
//  Shared
//
//  Created by Kuniaki Ohara on 2021/01/06.
//
import SwiftUI
import AVFoundation

struct CameraPage: View {
    let LastProcessIndex = 4.0
    let FaceMaskOpacity = 0.3
    let MASKNAMES:[String] = [ConstHolder.FACEMASKNAME1, ConstHolder.FACEMASKNAME2,ConstHolder.FACEMASKNAME3,ConstHolder.FACEMASKNAME4,ConstHolder.FACEMASKNAME5]

    //@Binding var rootActive: Bool
    
    @State var showCamera = true
    @State var showGuide = true
    @State var isSubCamera = false
    @ObservedObject var cameraController = CameraController()
    @State private var currentProgress: Double = 0.0
    @State var goSendPhoto = false
    @State private var backToMain = false  //保存してメインに戻るボタン

    
    var body: some View {
        /*
        NavigationLink(destination:CameraConfirmPage <ContentView>(Destination: ContentView(rootActive: self.$isActive)), isActive: $goSendPhoto){
            EmptyView()
        }
        */
        GeometryReader { bodyView in
            ZStack{
                Color.white
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 0, maxHeight: CGFloat.infinity)
                
                VStack{
                    HStack{
                        Spacer()
                        
                        Button(action:{
                            self.isSubCamera = !self.isSubCamera
                            self.cameraController.SwitchDevice()
                        }){
                            Text("インカメ切り替えアイコン").foregroundColor(Color.white)
                        }
                        .background(Color.black)
                        .padding()
                        
                        Button(action:{
                            self.showGuide = !self.showGuide
                        }){
                            Text("ガイド オン/オフ アイコン").foregroundColor(Color.white)
                        }
                        .background(Color.black)
                        .padding()
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                            self.backToMain = true /*またはself.show.toggle() */
                    }) {
                        Text("保存")
                            .foregroundColor(Color.white)
                            .font(Font.largeTitle)
                    }
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                        .background(Color.black)
                        .padding()
                    .sheet(isPresented: self.$backToMain) {
                        ContentView()
                    }
                    

                    /*
                    ProgressView("ステップ数" + String(Int(currentProgress)) + " / " + String(Int(LastProcessIndex)), value: currentProgress, total: LastProcessIndex)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.black))
                        .foregroundColor(Color.black)
                        .padding([.horizontal])
                    */
                    
                }
                .padding()
                
                VStack{
                    Text("角膜をガイドに合わせて撮影してください")
                        .foregroundColor(Color.black)
                        .font(Font.title)
                        .padding([.horizontal])
                    
                    if (self.showCamera){
                        ZStack{
                            
                            // isSubCamera内もelse内も全く同じだが、isSubCameraをトリガーとした再読み込みのためにある
                            if (self.isSubCamera){
                                CALayerView(caLayer: cameraController.CALayer)
                                    .frame(width:self.cameraController.ImageSize.width,
                                        height:self.cameraController.ImageSize.height)
                                    .border(Color.black)
                                    .padding()
                                    .onAppear(){
                                        cameraController.cameraPreviewLayer?.frame = CGRect(x:0, y:0, width: cameraController.ImageSize.width, height: cameraController.ImageSize.height)
                                    }
                            } else {
                                CALayerView(caLayer: cameraController.CALayer)
                                    .frame(width:self.cameraController.ImageSize.width,
                                        height:self.cameraController.ImageSize.height)
                                    .border(Color.black)
                                    .padding()
                                    .onAppear(){
                                        cameraController.cameraPreviewLayer?.frame = CGRect(x:0, y:0, width: cameraController.ImageSize.width, height: cameraController.ImageSize.height)
                                    }
                            }
                            
                            if (self.showGuide){
                                Image(uiImage: (UIImage(named: self.MASKNAMES[Int(currentProgress)])!.resize(size:self.cameraController.ImageSize))!)
                                    .opacity(FaceMaskOpacity)
                                    .frame(width:self.cameraController.ImageSize.width,
                                        height:self.cameraController.ImageSize.height)
                                    .border(Color.black)
                                    .padding()
                            }
                        }
                        
                        
                        Button(action:{
                            if(self.showCamera){
                                self.cameraController.ResetPhoto()
                                self.showCamera = false
                                self.cameraController.TakePhoto(progress: self.currentProgress)
                            }
                                }){
                            Text("撮影").foregroundColor(Color.white)
                                .font(Font.title)
                        }
                        .frame(minWidth:0, maxWidth:self.cameraController.ImageSize.width, minHeight: 50)
                            .background(Color.black)
                    } else {
                        ZStack{
                            // 表示する必要はないが、パディングがずれるため表示している
                            CALayerView(caLayer: cameraController.CALayer)
                                .frame(width:self.cameraController.ImageSize.width,
                                    height:self.cameraController.ImageSize.height)
                                .border(Color.black)
                                .padding()
                                .onAppear(){
                                    cameraController.cameraPreviewLayer?.frame = CGRect(x:0, y:0, width: cameraController.ImageSize.width, height: cameraController.ImageSize.height)
                                }
                            
                            Image(uiImage: (cameraController.Image ?? UIImage(named: ConstHolder.PROCESSINGMASKNAME)!.resize(size:self.cameraController.ImageSize))!)
                                .frame(width:self.cameraController.ImageSize.width,
                                    height:self.cameraController.ImageSize.height)
                                .border(Color.black)
                                .padding()
                        }
                        
                        
                        Button(action:{
                            if(!self.showCamera){
                                self.showCamera = true
                                cameraController.ResetPhoto()
                            }}){
                            Text("再撮影").foregroundColor(Color.white)
                                .font(Font.title)
                            }
                            .frame(minWidth:0, maxWidth:self.cameraController.ImageSize.width, minHeight: 50)
                            .background(Color.black)
                    }
                    
                    /*
                    Button(action:{
                        self.currentProgress += 1.0
                        if (self.currentProgress > LastProcessIndex){
                            self.currentProgress -= 1.0
                            self.goSendPhoto = true
                        }
                        self.showCamera = !self.cameraController.ShowPhoto(progress: self.currentProgress)
                            }){
                        Text("次へ").foregroundColor(Color.white)
                            .font(Font.title)
                    }
                    .frame(minWidth:0, maxWidth:self.cameraController.ImageSize.width, minHeight: 50)
                    .background(getButtonColor(enabled:cameraController.Image != nil && !self.showCamera))
                    .disabled(cameraController.Image == nil || self.showCamera)
                    */
                    
                    /*
                    Button(action:{
                        self.currentProgress -= 1.0
                        self.showCamera = !self.cameraController.ShowPhoto(progress: self.currentProgress)
                            }){
                        Text("前へ").foregroundColor(Color.white)
                            .font(Font.title)
                    }
                    .frame(minWidth:0, maxWidth:self.cameraController.ImageSize.width, minHeight: 50)
                    .background(getButtonColor(enabled: Int(self.currentProgress) > 0))
                    .disabled(Int(self.currentProgress) < 1)
                    */
                }
            }
            .background(Color.white)
            .navigationTitle("Camera Page (250px)")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                cameraController.captureSession.startRunning()
                cameraController.SetImageSize(screenSize: bodyView.size)
                self.showCamera = !self.cameraController.ShowPhoto(progress: self.currentProgress)
            }
        }
    }
    
    func getButtonColor(enabled: Bool) -> Color {
        return enabled ? .black : .gray
    }
}

//struct CameraPage_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CameraPage()
//        }
//    }
//}
