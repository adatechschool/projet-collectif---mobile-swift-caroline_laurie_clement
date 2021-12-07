//
//  ContentView.swift
//  SurfSwift
//
//  Created by laurie cluzeau on 06/12/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        VStack {
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 350)
           durban_spot()
                .offset(y:-100)
                .padding(.bottom, -100)
                
            VStack(alignment: .leading){
                Text("Addington")
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
                
            }
            
            Text("Durban")
            Spacer()
        }
//        .padding()
    
        Spacer()
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().preferredColorScheme(.light).previewInterfaceOrientation(.portrait).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView().preferredColorScheme(.light).previewInterfaceOrientation(.portrait).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}