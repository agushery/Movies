//
//  StrokeTextView.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

struct StrokeTextView: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .font(.system(.title2, design: .default, weight: .semibold))
            .foregroundColor(color)
            Text(text)
                .font(.system(.title2, design: .default, weight: .semibold))
                .foregroundColor(.black)
        }
    }
}

struct StrokeTextView_Previews: PreviewProvider {
    static var previews: some View {
        StrokeTextView(text: "Title", width: 1, color: .red)
    }
}
