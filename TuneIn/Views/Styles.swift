//
//  Styles.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 2/16/23.
//

import SwiftUI

struct Styles{
    struct BackButton: View {
        var presentationMode: Binding<PresentationMode>
        init(presentationMode: Binding<PresentationMode>) {
            self.presentationMode = presentationMode
        }
        
        var body: some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                ZStack {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

