////
////  Informations.swift
////  CorneaApp
////
////  Created by Yoshiyuki Kitaguchi on 2021/04/18.
////
//
//import SwiftUI
//import CoreData
//
////変数を定義
//struct SavedData: View {
//    @ObservedObject var user: User
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.newdate, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {    // ナビゲーションバーを表示する為に必要
//            List {
//                ForEach(items) { item in
//                    Text("Item at \(item.newdate!, formatter: itemFormatter)")
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                /// ナビゲーションバーの左にEditボタンを配置
//                ToolbarItem(placement: .navigationBarLeading) {
//                    EditButton()
//                }
//
//                /// ナビゲーションバーの右に+ボタン配置
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newDate = Item(context: viewContext)
//            newDate.newdate = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
