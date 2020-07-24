# Creating and Combining Views

- Customize the Text View
    - 뷰의 타입에 따른 커스텀 가능한 속성들을 보여준다
        1. [Preview 창] command + 좌클릭 → Show SwiftUI Inspector
        2. [Code Editor 창] Text를 command 좌클릭 → Show SwiftUI Inspector

            ![Creating%20and%20Combining%20Views%201cb25d787db944f28e3a2fba517caf77/Untitled.png](Creating%20and%20Combining%20Views%201cb25d787db944f28e3a2fba517caf77/Untitled.png)

        3. control + option + click
- Combine Views Using Stacks
    - 스택뷰 만들기

        [Code Editor 창] Text를 command 좌클릭 → Embed in VStack(HStack)

    - 개념

        body 프로퍼티는 Single view만 리턴한다.

        Spacer() : 뷰가 컨텐츠에 따라 크기를 가지지 않고, 부모 뷰의 모든 공간을 사용하도록 확장된다.

        padding() : 정해진 edge inset에 따라 뷰를 padding 한다.

    ```swift
    import SwiftUI

    struct ContentView: View {
        var body: some View {
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                HStack {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                    .font(.subheadline)
                }
            }
            .padding()
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    ```

- Create a Custom Image View

    ```swift
    import SwiftUI

    struct CircleImage: View {
        var body: some View {
            Image("turtlerock")
            .clipShape(Circle())    // 뷰 모양 자르기 
            .overlay(               // 기존 뷰 앞에 다른 뷰를 overlay 함
                Circle().stroke(Color.gray, lineWidth: 4))
            .shadow(radius: 10)     // 이 뷰에 그림자 추가
        }
    }

    struct CircleImage_Previews: PreviewProvider {
        static var previews: some View {
            CircleImage()
        }
    }
    ```

- Use UIKit and SwiftUI Views Together
    - UIViewReprentable

        SwiftUI에서 이 프로토콜을 채택하여 UIView 객체를 생성, 갱신, 해제하는 데 사용할 수 있다

        1. func makeUIView(context: Context)

            뷰 객체를 만들 때 사용.

            처음 뷰를 생성할 때 이 메소드는 단 한번 호출된다

            이후 모든 업데이트는 updateUIView 메소드가 호출된다

        2. func updateUIView(_ uiView: Self.UIViewType, context: Context)

            앱의 상태가 변경될 때 변경사항의 영향을 받는 부분을 업데이트한다.

    - Preview

        static mode : SwiftUI만 렌더링함

        → 아래 예시 MKMapView는 UIView의 서브클래스이므로 지도를 프리뷰로 보려면 

        live preview로 바꿔줘야한다.

        ![Creating%20and%20Combining%20Views%201cb25d787db944f28e3a2fba517caf77/Untitled%201.png](Creating%20and%20Combining%20Views%201cb25d787db944f28e3a2fba517caf77/Untitled%201.png)

        ```swift
        import SwiftUI
        import MapKit

        struct MapView: UIViewRepresentable {
            func makeUIView(context: Context) -> MKMapView {
                MKMapView(frame: .zero)
            }
            
            func updateUIView(_ uiView: MKMapView, context: Context) {
                let coordinate = CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868)
                let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                uiView.setRegion(region, animated: true)
            }
        }

        struct MapView_Previews: PreviewProvider {
            static var previews: some View {
                MapView()
            }
        }
        ```

- Compose the Detail View
    - VStack을 embed해서 위에서 만든 MapView, CircleImage를 순서대로 구성한다

        ```swift
        import SwiftUI

        struct ContentView: View {
            var body: some View {
                VStack {
                    MapView()
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 300) // width = contentSize
                    
                    CircleImage()
                        .offset(y: -130)
                        .padding(.bottom, -130)
                    
                    VStack(alignment: .leading) {
                        Text("Turtle Rock")
                            .font(.title)
                        HStack {
                            Text("Joshua Tree National Park")
                                .font(.subheadline)
                            Spacer()
                            Text("California")
                            .font(.subheadline)
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
        }

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
        ```

        ![Creating%20and%20Combining%20Views%201cb25d787db944f28e3a2fba517caf77/Untitled%202.png](Creating%20and%20Combining%20Views%201cb25d787db944f28e3a2fba517caf77/Untitled%202.png)