//
//  CatAppApp.swift
//  CatApp
//
//  Created by javi www on 11/9/22.
//

import SwiftUI

class AppState: ObservableObject {
    static var shared: AppState = .init()
    @Published var showInfo = false
    
    //Reserve view properties
    @Published var pushReserve:Bool = false
    var selectedCat: Cat = catsMockupData.first!
}

@main
struct CatAppApp: App {
    @ObservedObject var appState = AppState.shared
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                infoView
                    .opacity(appState.showInfo ? 1 : 0)
                    .animation(.easeInOut(duration: 0.23), value: appState.showInfo)
            }
        }
    }
    
    var infoView: some View {
        ZStack {
            
            Color.black.opacity(0.9)
                .ignoresSafeArea()
         
            VStack(spacing: 0) {
                Text("Cat App")
                    .font(.largeTitle.bold())
                    .padding(.top, 32)

                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("• Use CATAAS API")
                    Text("• Filter by tags")
                    Text("• Infinite scroll of cats")
                    Text("• Error handling")
                    Text("• Made with SwiftUI")
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 44)
                .padding(.leading, 32)
                .foregroundColor(.primary)
                .font(.system(size:16, weight: .regular))

                HStack(spacing: 6) {
                    Text("by")
                        .font(.subheadline)
                    
                    Text("Javiw")
                        .font(.headline)
                    
                    Image("javi_pro")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    
                    Text("for")
                        .font(.subheadline)
                    
                    Image("photoboothsupplyco_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)

                }
                .padding(.top, 84)
                .padding(.bottom, 32)
                .padding(.trailing, 32)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .opacity(1)
            }
            .padding(.horizontal, 12)
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            appState.showInfo = false
        }

    }

}
