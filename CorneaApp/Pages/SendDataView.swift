//
//  SendData.swift
//  CorneaApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/04/18.
//

import SwiftUI

struct SendData: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        
        VStack{
                GeometryReader { bodyView in
                    VStack{
                        Text("内容を確認してください").padding().foregroundColor(Color.black)
                            .font(Font.title)
                        
                        ScrollView(.vertical){
                            GetImageStack(images: ResultHolder.GetInstance().GetUIImages(), shorterSide: GetShorterSide(screenSize: bodyView.size))
                        }
                        
                        Text("撮影日時:")
                        Text(self.user.date, style: .date)
                        Text("ID: \(self.user.id)")
                        Text("施設: \(self.user.selected_hospital)")
                        Text("診断名: \(self.user.selected_disease)")
                        Text("自由記載: \(self.user.free_disease)")
                    }
                }

                
        
        /*
        Form {
                    TextField("撮影日時", Date: $user.date)
                    TextField("ID", text: $user.id)
                    TextField("施設", text: $user.selected_hospital)
                TextField("診断名", text: self.hospitals[self.selected_disease])
                    TextField("自由記載", text: $user.free_disease)
            }
            .disabled(user.id.isEmpty)
        */
            
                Spacer()
                Button(action: {
                }) {
                    Text("送信")
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.black)
                    .padding()
                }
            
            
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
                                Image(uiImage: image).resizable().frame(width: imageLength*2.4, height: imageLength*2.4).padding(padding)
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
    
    /*
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
    */
}


/*
struct SendData_Previews: PreviewProvider {
    static var previews: some View {
        SendData()
    }
}
*/
