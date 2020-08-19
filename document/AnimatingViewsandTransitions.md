# Animating Views and Transitions

- Add animations to Individual Views
    - SwiftUI는 spring과 fluid 애니메이션 뿐만 아니라 사전 정의된 애니메이션, 커스텀된 기본 애니메이션을 포함한다.
    - 애니메이션 속도를 조정,애니메이션 시작 전에 delay 설정, 애니메이션 반복이 가능하다.

        ```swift
        Image(systemName: "chevron.right.circle")
                                .imageScale(.large)
                                .rotationEffect(.degrees(showDetail ? 90 : 0))
                                .animation(nil)  // 회전 애니메이션 끄기
                                .scaleEffect(showDetail ? 1.5 : 1)
                                .padding()
                                .animation(.spring())
        ```

- Animate the Effects of State Changes

    ```swift
    Button(action: {
        withAnimation(.easeInOut(duration: 4)) { // 4초동안 애니메이션 수행
    	    self.showDetail.toggle()
        }
    })
    ```

- Compose Animations for Complex Effects

    ```swift
    extension Animation {
        static func ripple(index: Int) -> Animation {
            Animation.spring(dampingFraction: 0.5)
                     .speed(2)
                     .delay(0.03 * Double(index))
        }
    }

    ForEach(data.indices) { index in
                        GraphCapsule(
                            index: index,
                            height: proxy.size.height,
                            range: data[index][keyPath: self.path],
                            overallRange: overallRange)
                        .colorMultiply(self.color)
                        .animation(.ripple(index: index))
                    }
    ```