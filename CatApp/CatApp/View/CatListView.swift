//
//  CatListView.swift
//  CatApp
//
//  Created by javi www on 11/9/22.
//

import SwiftUI

struct CatListView: View {
    
    @ObservedObject var catListViewModel: CatListViewModel = .init()
    @ObservedObject var appState = AppState.shared

    @State var segmentedIndex:Int = 0
    @Namespace var animation
    
    @State var tagNames: [String] = ["random", "black", "fluffy", "white", "sleeping", "FAT", "angry", "focused", "Grumpy", "professional", "cute", "programmer", "Relaxed"]


    init() {
        catListViewModel.fetch()
    }
    
    var body: some View {
        ZStack {
            //MARK: Cat list
            catList

            NavigationLink("Reserve", isActive: $appState.pushReserve) {
                ReserveCatView(cat: appState.selectedCat)
                    .preferredColorScheme(.dark)

            }
            .hidden()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Cats")
        .alert(isPresented: .constant(catListViewModel.errorMessage != nil)) {
            Alert(title: Text("Error"),
                  message: Text(catListViewModel.errorMessage ?? ""),
                  dismissButton: .default(Text("OK")))
        }
        
    }
    
    var filterList: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 44.0) {
                ForEach(0..<tagNames.count, id: \.self) { idx in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5)) {
                            segmentedIndex = idx
                        }
                        
                        let tag = tagNames[idx]
                        catListViewModel.reloadWithTag(idx == 0 ? "" : tag)
                        UISelectionFeedbackGenerator().selectionChanged()
                    } label: {
                        VStack(spacing: 8) {
                            Text((tagNames[idx % tagNames.count]).lowercased())
                                .font(.caption2)
                                .fontWeight(.bold)
                        }
                        .frame(height: 34)
                        .foregroundColor(.white)
                        .overlay {
                            if idx == segmentedIndex {
                                Rectangle()
                                    .fill(.white)
                                    .padding(.horizontal, -2)
                                    .frame(height:1)
                                    .offset(y: 16)
                                    .matchedGeometryEffect(id: "tab", in: animation)
                            }
                        }
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 24)
        }
        .padding(.top, 0)
        .padding(.bottom, 16)
    }

    var catList: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            //MARK: Filter list
            filterList

            if catListViewModel.cats.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.75)
            } else {
                
                VStack(spacing: 64) {
                    ForEach(catListViewModel.cats) { cat in
                        CatCardView(cat: cat)
                    }
                }
                .padding(.top, 16)
                .background(GeometryReader {
                    Color.clear
                        .preference(key: ViewOffsetKey.self,
                        value: -$0.frame(in: .named("scroll")).origin.y / $0.frame(in: .named("scroll")).height)
                })
                .onPreferenceChange(ViewOffsetKey.self) {
                    if $0 > 0.85 && !catListViewModel.fetchingMore {
                        DispatchQueue.main.async {
                            catListViewModel.fetchMore()
                        }
                    }
                }
                
                if catListViewModel.fetchingMore {
                    //Loader at the end
                    ProgressView()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 84.0)
                }
                
            }
        }
        .coordinateSpace(name: "scroll")

    }

}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
