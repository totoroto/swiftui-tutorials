# Handling User Input

- Mark the User's Favorite Landmarks

    SwiftUI에서 view에 if문 사용 가능

    ```swift
    struct LandmarkRow: View {
        var body: some View {
            HStack {
                landmark.image
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(landmark.name)
                Spacer()
                
                if landmark.isFavorite {
                    Image(systemName: "star.fill")
                        .imageScale(.medium)
                        .foregroundColor(.yellow)
                }
            }
        }
    }
    ```

- Filter the List View

    `@State`는 가변적인 값 또는 값의 집합이고 뷰의 컨텐츠나 레이아웃, 행위에 영향을 준다

    ```swift
    struct LandmarkList: View {
        @State var showFavoritesOnly = false
        
        var body: some View {
            NavigationView {
                List(landmarkData) { landmark in
                    if !self.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                    
                }
                .navigationBarTitle(Text("Landmarks"))
            }
        }
    }
    ```

- Add a Control to Toggle the State

    리스트에서 정적 뷰 + 동적 뷰를 결합하거나 둘 이상의 동적 뷰 그룹을 결합하려면 

     `ForEach`를 사용하자

    ```swift
    struct LandmarkList: View {
        @State var showFavoritesOnly = false
        
        var body: some View {
            NavigationView {
                List {
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Favorites only")
                    }
                    
                    ForEach(landmarkData) { landmark in
                        if !self.showFavoritesOnly || landmark.isFavorite {
                            NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                                LandmarkRow(landmark: landmark)
                            }
                        }
                    }
                    
                }
                .navigationBarTitle(Text("Landmarks")) 
            }
        }
    }
    ```

- Use an Observable Object for Storage

    유저가 즐겨찾는 특정 랜드마크를 제어하려면 landmark data를 `ObservableObject`에 저장하자

    SwiftUI는 뷰에 영향을 주는 `ObservableObject`의 변화를 감시하고, 변화하면 올바른 뷰를 표시

    ```swift
    import SwiftUI
    import Combine

    final class UserData: ObservableObject {
        @Published var showFavoritesOnly = false
        @Published var landmarks = landmarkData
    }
    // subscriber는 change를 pick up할 수 있다
    ```

- Adopt the Model Object in Your Views

    위에서 만든 UserData를 이용해 앱의 datastore에 맞게 뷰를 업데이트 하자

    ```swift
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
    struct LandmarkList_Previews: PreviewProvider {
        static var previews: some View {      
            LandmarkList().environmentObject(UserData())
        }
    }
    ```

    ```swift
    // SceneDelegate.swift
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(rootView: LandmarkList().environmentObject(UserData()))
    ```

    ```swift
    struct LandmarkDetail: View {
        @EnvironmentObject var userData: UserData
        var landmark: Landmark
        
        var landmarkIndex: Int {
            userData.landmarks.firstIndex(where: {$0.id == landmark.id })!
        }
    // 생략
    }
    ```

- Create a Favorite Button for Each Landmark

    하드코딩된 즐겨찾기 버튼 바꾸기

    ```swift
    struct LandmarkDetail: View {
        
        var body: some View {
            VStack {
               
                VStack(alignment: .leading) {
                    HStack {
                        Text(landmark.name)
                            .font(.title)

                        Button(action: {
                            self.userData.landmarks[self.landmarkIndex].isFavorite.toggle()
                        }) {
                            if self.userData.landmarks[self.landmarkIndex].isFavorite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            } else {
                                Image(systemName: "star")
                                .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .padding()
                Spacer()
            }
            .navigationBarTitle(Text(landmark.name), displayMode: .inline)
        }
    }
    ```