//
//  LandmarkList.swift
//  Landmarks
//
//  Created by pandora on 2020/07/26.
//  Copyright © 2020 pandora. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(userData.landmarks) { landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
                
            }
            .navigationBarTitle(Text("Landmarks")) // 위치 여기..
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
// 아이폰SE 사이즈로 렌더링
//        LandmarkList()
//        .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        
        LandmarkList().environmentObject(UserData())
    }
}
