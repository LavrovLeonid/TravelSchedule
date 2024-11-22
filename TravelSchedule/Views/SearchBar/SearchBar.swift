//
//  SearchBar.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/15/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State var isSearching: Bool = false
    
    var placeholder = "Поиск..."
    
    var body: some View {
        HStack (spacing: 0) {
            HStack (spacing: 0) {
                HStack {
                    TextField(placeholder, text: $searchText)
                        .font(.system(size: 17))
                        .padding(.leading, 8)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                }
                .padding()
                .cornerRadius(16)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    isSearching = true
                })
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 17, height: 17)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        if isSearching && searchText.count > 0 {
                            Button(action: { searchText = "" }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.vertical)
                            })
                            
                        }
                        
                    }.padding(.horizontal, 10)
                        .foregroundColor(.gray)
                )
            }
            .frame(height: 37)
            .background(Color(red: 118.0/255, green: 118.0/255, blue: 128.0/255).opacity(0.12))
            .cornerRadius(10)
        }
        .frame(height: 37)
        .padding(.horizontal, 16)
    }
}
