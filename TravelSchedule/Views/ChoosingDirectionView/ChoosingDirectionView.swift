//
//  ChoosingDirectionView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/28/24.
//

import SwiftUI

struct ChoosingDirectionView: View {
    var fromText: Binding<String>
    var toText: Binding<String>
    
    var onTapFrom: (() -> Void)?
    var onTapTo: (() -> Void)?
    var onChange: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 0) {
                VStack {
                    TextField(
                        text: fromText
                    ) {
                        Text("Откуда")
                            .foregroundStyle(Color.grayUniversal)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal)
                    .foregroundStyle(Color.blackUniversal)
                    .disabled(true)
                }
                .background(Color.white)
                .onTapGesture {
                    onTapFrom?()
                }
                VStack {
                    TextField(
                        text: toText
                    ) {
                        Text("Куда")
                            .foregroundStyle(Color.grayUniversal)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal)
                    .foregroundStyle(Color.blackUniversal)
                    .disabled(true)
                }
                .background(Color.white)
                .onTapGesture {
                    onTapTo?()
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            Button(action: onChange) {
                Image(.changeIcon)
                    .renderingMode(.template)
                    .tint(.black)
                    .frame(width: 36, height: 36)
                    .background(Color.white)
                    .cornerRadius(36 / 2)
            }
        }
        .padding()
        .background(Color.travelBlue)
        .cornerRadius(20)
    }
}

#Preview {
    ChoosingDirectionView(fromText: .init(get: {
        ""
    }, set: {_ in 
        
    }), toText: .init(get: {
        ""
    }, set: {_ in 
        
    }), onTapFrom: {
        
    }, onTapTo: {
        
    }, onChange: {
        
    })
}
