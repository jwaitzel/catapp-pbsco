//
//  CatCardView.swift
//  CatApp
//
//  Created by javi www on 11/10/22.
//

import SwiftUI

struct CatCardView: View {
    var cat: Cat
    var body: some View {
        let imageHeight: CGFloat = 400
        ZStack {
            VStack {
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
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .fill(.gray.opacity(0.2))
                            .overlay {
                                ProgressView()
                            }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                .contentShape(Rectangle())
                .onTapGesture {
                    UISelectionFeedbackGenerator().selectionChanged()
                    AppState.shared.selectedCat = cat
                    AppState.shared.pushReserve = true
                }

                //MARK: Cat info
                CatInfoView(cat:cat)
                    .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity)
            
        }
    }
}

struct CatInfoView: View {
    var cat:Cat
    var body: some View {
        VStack(spacing:4) {
            let catOwner = cat.owner ?? "null"
            HStack {
                if catOwner != "null" {
                    HStack(spacing: 0) {
                        Text("Owner: ")
                        Text(catOwner)
                            .fontWeight(.semibold)
                    }
                } else {
                    Text("Stray")
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "star.fill")
                        
                        Text(String(format: "%.2f", CGFloat.random(in: 4.5...5)))
                    }
                }
                .foregroundColor(.primary)
            }
            .padding(.top, 14)
            .padding(.bottom, 4)
            
            let distanceRandom = Int(CGFloat.random(in: 1...30))
            VStack(spacing: 4) {
                Text("\(distanceRandom) kilometers away")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.gray)
            .padding(.bottom, 8)
            
            //MARK: Tags
            if !cat.tags.isEmpty  {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(cat.tags.indices, id: \.self) { cTagIdx in
                            let cTag = cat.tags[cTagIdx]
                            Button {
                                
                            } label: {
                                Text(cTag.lowercased())
                            }
                            .foregroundColor(.primary)
                            
                            //Remove for last
                            if cTag != cat.tags.last {
                                Text("-")
                            }
                            
                            
                        }
                    }
                }
            }
            
            HStack {
                
                HStack(spacing: 4) {
                    Text("$\(Int.random(in: 5...100))")
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("night")
                }
                
                
                Spacer()
                
                Button {
                    UISelectionFeedbackGenerator().selectionChanged()
                    AppState.shared.selectedCat = cat
                    AppState.shared.pushReserve = true
                } label: {
                    Text("RESERVE")
                        .fontWeight(.bold)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 24)
                        .background {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(.white, lineWidth: 2)
                        }
                        .foregroundColor(.white)
                }
                .tint(.black)
                .foregroundColor(.black)
                
            }
            .padding(.top, 32)
        }
        .padding(.horizontal, 8)
    }
    
}

struct CatCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
