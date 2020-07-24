//
//  CircleImage.swift
//  Landmarks
//
//  Created by pandora on 2020/07/24.
//  Copyright © 2020 pandora. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
        .frame(width: 200, height: 200)
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.gray, lineWidth: 4))
        .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
