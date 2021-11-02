//
//  ContentView.swift
//  CorneaApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/04/18.
//


import SwiftUI

//変数を定義
class User : ObservableObject {
    @Published var date: Date = Date()
    @Published var id: String = ""
    @Published var selected_hospital: Int = 0
    @Published var selected_disease: Int = 0
    @Published var free_disease: String = ""

    @Published var hospitals: [String] = ["", "筑波大", "大阪大", "東京歯科大市川", "鳥取大", "宮田眼科", "順天堂大", "ツカザキ病院", "広島大", "新潟大", "富山大", "福島県立医大", "東京医大"]
    @Published var disease: [String] = ["", "角膜ジストロフィー", "角膜細菌感染", "角膜真菌感染", "周辺角膜潰瘍", "翼状片"]
}



struct ContentView: View {
    @ObservedObject var user = User()
    //CoreDataの取り扱い
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var goTakePhoto: Bool = false  //撮影ボタン
    @State private var isPatientInfo: Bool = false  //患者情報入力ボタン
    @State private var goSendData: Bool = false  //送信ボタン
    @State private var savedData: Bool = false  //送信ボタン
    
    var body: some View {
        VStack(spacing:0){
            Text("Cornea app")
                .font(.largeTitle)
                .padding(.bottom)
            
            Image("IMG_1273")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Button(action: { self.goTakePhoto = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "camera")
                    Text("撮影")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$goTakePhoto) {
                CameraPage()
            }
            
            Button(action: { self.isPatientInfo = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "info.circle")
                    Text("患者情報入力")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$isPatientInfo) {
                Informations(user: user)
                //こう書いておかないとmissing as ancestorエラーが時々でる
            }
                        
            Button(action: { self.goSendData = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "square.and.arrow.up")
                    Text("送信")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$goSendData) {
                SendData(user: user)
            }
            
            Button(action: { self.savedData = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "folder")
                    Text("リスト")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:200, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$savedData) {
                SavedData(user: user)
            }
            
        }
    }
}
