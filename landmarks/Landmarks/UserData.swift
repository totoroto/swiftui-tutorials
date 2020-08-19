//
//  UserData.swift
//  Landmarks
//
//  Created by pandora on 2020/08/02.
//  Copyright © 2020 pandora. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
