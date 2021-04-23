//
//  CameraConfirmPage.swift
//  TestProduct
//
//  Created by Kuniaki Ohara on 2021/01/22.
//
import SwiftUI

struct CameraConfirmPage<Content: View>: View {
    var Destination: Content
    @State var goMainPage = false
    
    var body: some View {
        NavigationLink(destination: Destination, isActive: $goMainPage){
            EmptyView()
        }
        GeometryReader { bodyView in
            VStack{
                Text("撮影した画像を確認してください").padding().foregroundColor(Color.black)
                    .font(Font.title)
                
                ScrollView(.vertical){
                    GetImageStack(images: ResultHolder.GetInstance().GetUIImages(), shorterSide: GetShorterSide(screenSize: bodyView.size))
                }
                
                Button(action:{ self.goMainPage = true }){
                    Text("OK")
                        .foregroundColor(Color.white)
                        .font(Font.title)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 50)
                    .background(Color.black)
                .padding([.bottom, .horizontal])
            }
        }
        .background(Color.white)
        .navigationTitle("ImageConfirmPage")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    public func GetImageStack(images: [UIImage], shorterSide: CGFloat) -> some View {
        let padding: CGFloat = 10.0
        let imageLength = shorterSide / 3 + padding * 2
        let colCount = Int(shorterSide / imageLength)
        let rowCount = Int(ceil(Float(images.count) / Float(colCount)))
        return VStack(alignment: .leading) {
            ForEach(0..<rowCount){
                i in
                HStack{
                    ForEach(0..<colCount){
                        j in
                        if (i * colCount + j < images.count){
                            let image = images[i * colCount + j]
                            Image(uiImage: image).resizable().frame(width: imageLength, height: imageLength).padding(padding)
                        }
                    }
                }
            }
        }
        .border(Color.black)
    }
    
    public func GetShorterSide(screenSize: CGSize) -> CGFloat{
        let shorterSide = (screenSize.width < screenSize.height) ? screenSize.width : screenSize.height
        return shorterSide
    }
    
    func getIsLandscape() -> Bool{
        var isLandscape = false
        switch UIApplication.shared.windows.first?.windowScene?.interfaceOrientation{
        case .portrait:
            isLandscape = false
        case .portraitUpsideDown:
            isLandscape = false
        case .landscapeLeft:
            isLandscape = true
        case .landscapeRight:
            isLandscape = true
        default:
            print("unknown orientation")
            break
        }
        
        return isLandscape
    }
}

//struct CameraConfirmPage_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraConfirmPage(cameraController: none)
//    }
//}
