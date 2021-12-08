//
//  ContentView.swift
//  SurfSwift
//
//  Created by laurie cluzeau on 06/12/2021.
//

import SwiftUI
import Foundation
//import CoreData

struct ContentView: View {
    
    @State var results = Records(spots: [])
    //    @Environment(\.managedObjectContext) private var viewContext
    //
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    
    init(){
        loadData()
    }
    
    var body: some View {
        //ContentView()
        Text("truc")
        
        
    }
    
    func loadData() {
        
        guard let url = URL(string: "https://api.airtable.com/v0/appxT9ln6ixuCb3o1/Surf%20Destinations?api_key=keytJfvmEMHuMhOp7") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(Records.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                        print(response)
                    }
                    return
                }
                
            }
        }.resume()
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
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
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ContentView().preferredColorScheme(.light).previewInterfaceOrientation(.portrait).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//            ContentView().preferredColorScheme(.light).previewInterfaceOrientation(.portrait).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        }
//    }
//}
