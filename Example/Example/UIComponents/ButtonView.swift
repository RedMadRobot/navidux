//
//  ButtonView.swift
//  Example
//
//  Created by Александр Евсеев on 06.11.2022.
//

import SwiftUI

struct ButtonView: View {
    let action: () -> Void
    let title: String
    
    var body: some View {
        Button(
            action: action) {
                HStack {
                    Text(title)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
        .padding(.horizontal, 32)
    }
}
