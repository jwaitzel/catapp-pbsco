//
//  Home.swift
//  CatApp
//
//  Created by javi www on 11/9/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            CatListView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            AppState.shared.showInfo.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundColor(.secondary)
                        }
                    }
                }
        }
        .preferredColorScheme(.dark)
        //MARK: For navigation back button color
        .accentColor(.white)

    }
    

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
