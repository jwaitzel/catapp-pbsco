//
//  ReserveCatView.swift
//  CatApp
//
//  Created by javi www on 11/10/22.
//

import SwiftUI

struct ReserveCatView: View {
    var cat: Cat
    var body: some View {
        ZStack {
            AsyncImage(url: cat.imageURL()) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                else if let _ = phase.error {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(0.3)
                } else {
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5, alignment: .center)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.65, alignment: .top)
            .clipped()
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        
            CatInfoView(cat:cat)
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
}

struct ReserveCatView_Previews: PreviewProvider {
    static var previews: some View {
        ReserveCatView(cat: catsMockupData.first!)
            .preferredColorScheme(.dark)
    }
}
