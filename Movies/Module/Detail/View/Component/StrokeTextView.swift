//
//  StrokeTextView.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

import SwiftUI

/**Creates a new `StrokeTextView` with the specified text, stroke width, and stroke color.

* Parameters:
*    text: The text to display.
*   width: The width of the stroke around the text.
*   color: The color of the stroke around the text.
*/
struct StrokeTextView: View {
    /// The text to display.
    let text: String
    
    /// The width of the stroke around the text.
    let width: CGFloat
    
    /// The color of the stroke around the text.
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
