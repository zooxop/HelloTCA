# The Composable Architecture

> TCA Github Repository의 메인 README를 직접 번역해보면서 TCA Base knowledge를 익힌다.  
> 번역 참고 : [TCA README in Korean](https://gist.github.com/pilgwon/ea05e2207ab68bdd1f49dff97b293b17)

The Composable Architecture(TCA)는 **일관되고 이해할 수 있는 방식**으로 애플리케이션을 만들기 위해 탄생한 라이브러리이다.  
모든 애플 플랫폼(iOS, macOS, tvOS, watchOS)에서 사용이 가능하다.  
TCA는 다음 3가지 항목을 염두에 두고 만들어졌다.
- 합성 (Composition)
- 테스팅 (Testing)
- 인체 공학 (Ergonomics)

## The Composable Architecture란

다양한 목적과 복잡도를 가진 애플리케이션을 만들기 위해 필요한 핵심 도구를 제공한다.

- **상태(State) 관리**
  - 간단한 값 타입들로 애플리케이션의 상태를 관리하는 방법
  - 상태 공유를 통해 화면에서 일어나는 변화(Mutation)를 다른 화면에서 즉시 관측(Observe)하는 방법
- **합성(Composition)**
  - 기능을 여러 개의 독립된 모듈로 추출하는 방법
  - 이 모듈을 다시 합쳐서 거대한 기능을 작은 컴포넌트의 집합으로 구성하는 방법
- **Side Effects**
  - 애플리케이션 바깥세상과 접촉하는 작업을 테스트할 수 있고, 이해하기 쉽게 작성하는 방법
- **Testing**
  - 아키텍쳐 내부의 기능을 테스트하는 방법
  - 여러 파트로 구성된 기능의 통합 테스트를 작성하는 방법
  - 사이드 이펙트가 애플리케이션에 끼치는 영향에 대해 전체 테스트를 작성하는 방법
  - (* 이 테스트 방식은, 비즈니스 로직이 예상대로 잘 작동하는지에 대한 강한 보증도 제공한다.)
- **인체 공학(Ergonomics)**
  - 위의 내용들을 가능한 한 적은 개념의 간단한 API로 이루는 방법

## 기본 사용법

TCA를 통해 기능을 만들기 위해서는, 도메인을 구성하는 몇 가지 타입을 정의해야 한다.

- **State**: **비즈니스 로직을 수행**하거나 **UI를 그릴 때 필요한 데이터**에 대한 설명을 나타냄.
- **Action**: **사용자가 하는 행동**이나 **Notification** 등, 애플리케이션에서 생길 수 있는 모든 행동을 나타냄.
- **Environment**: API 클라이언트나 Analytics 클라이언트와 같이 **애플리케이션이 필요로 하는 의존성(Dependency)**을 가지고 있는 타입.
- **Reducer**: 어떤 Action이 주어졌을 때, 현재 State를 다음 상태로 변화시키는 방법을 가지고 있는 함수. 또한, Reducer는 실행할 수 있는 Effect 타입의 값을 반환한다.
- **Store**: 실제로 기능이 작동하는 공간. 우리는 **사용자의 Action을 보내서 Store는 Reducer와 Effect를 실행**할 수 있고, **Store에서 일어나는 State 변화를 관측해서 UI를 업데이트** 할 수도 있다.

위의 타입을 정의하는 것으로 즉시 **코드에 테스트 가능성을 부여**할 수 있다.  
게다가, 크고 복잡한 기능을 **서로 결합 가능한 작고 독립된 모듈**로 쪼갤 수도 있다.

## 예시 코드

1. 화면에 숫자와, 이 숫자를 증감시킬 수 있는 +, - 버튼이 있다고 가정
2. 탭 하면 API를 호출해서 숫자에 관한 무작위 사실을 알림창으로 보여주는 버튼 추가.

### **\[Reducer\]**

기능을 구현하기 위해, `Reducer`를 준수하여 기능의 도메인과 동작을 담을 새 `struct` 를 만든다.

```swift
import ComposableArchitecture

struct Feature: Reducer {
    
}
```

### **\[State\]**

`Reducer` 내부에 `State` 를 정의한다.  
(이 예제에서는 현재 값을 나타내는 Int 변수와 API Response를 Alert으로 표시할 때 사용할 String 변수를 갖고 있음.)

```swift
struct Feature: Reducer {
    struct State: Equatable {
        var count = 0
        var numberFactAlert: String?
    }
}
```

### **\[Action\]**

기능의 **동작에 대한 유형**을 정의한다.  
(이 예제에서는 증가, 감소, API 호출 버튼을 Tap하는 **명백한 동작**과, API 응답을 Alert으로 보여주거나 Alert을 해제하는 **다소 명확하지 않은 동작**이 존재한다.)

```swift
struct Feature: Reducer {
    struct State: Equatable { /* ... */ }
    enum Action: Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
    }
}
```

### \[reduce()\]

`reduce()` method는 **실제 비즈니스 로직과 동작을 처리**한다.  
현재 상태를 다음 상태로 변경하는 방법을 작성하고, 어떤 `Effect`를 실행해야 하는지도 작성한다.  
만약 `Effect`를 실행할 필요가 없다면, `.none`을 반환하면 된다.

```swift
struct Feature: Reducer {
    struct State: Equatable { /* ... */ }
    enum Action: Equatable { /* ... */ }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .factAlertDismissed:
            state.numberFactAlert = nil
            return .none

        case .decrementButtonTapped:
            state.count -= 1
            return .none

        case .incrementButtonTapped:
            state.count += 1
            return .none

        case .numberFactButtonTapped:
            return .run { [count = state.count] send in
                let (data, _) = try await URLSession.shared.data(
                from: URL(string: "http://numbersapi.com/\(count)/trivia")!
                )
                await send(
                .numberFactResponse(String(decoding: data, as: UTF8.self))
                )
            }

        case let .numberFactResponse(fact):
            state.numberFactAlert = fact
            return .none
        }
    }
}
```

> 참고 : 해당 예제의 API는 `http`로 호출해야만 하므로, 프로젝트의 `Info` 탭에 다음 설정값을 추가해야 에러를 방지할 수 있다.  
> App Transport Security Settings - Allow Arbitrary Loads 항목 추가, `YES`로 설정.

### \[View\]

마지막으로, Feature를 표시하는 `View`를 정의한다.  
이 `View`는 `State`의 모든 변경 사항을 observing하고, Re-Rendering할 수 있도록 `StoreOf<Feature>`를 보유하고, `State`를 변경하도록 모든 User `Action`을 `Store`로 전송할 수 있다.  
(* `.alert` modifier의 요구 조건을 충족시키기 위해, `Identifiable`을 준수하는 `FactAlert` 구조체로 한 번 감싸서 매개변수로 사용한다.)

```swift
struct FeatureView: View {
    let store: StoreOf<Feature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                Button("−") { viewStore.send(.decrementButtonTapped) }
                Text("\(viewStore.count)")
                Button("+") { viewStore.send(.incrementButtonTapped) }
                }

                Button("Number fact") { viewStore.send(.numberFactButtonTapped) }
            }
            .alert(
                item: viewStore.binding(
                    get: { $0.numberFactAlert.map(FactAlert.init(title:)) },
                    send: .factAlertDismissed
                ),
                content: { Alert(title: Text($0.title)) }
            )
        }
    }
}

struct FactAlert: Identifiable {
    var title: String
    var id: String { self.title }
}
```

### 실행

이제 `View`를 표시할 준비가 되었다.  
`View`를 불러올 때 `Store`를 구성해서 주입해줄 수 있는데, 예를들어 앱의 Entry Point(`@main`)에서 `FeatureView`를 불러올 때 다음과 같이 사용할 수 있다.

```swift
import ComposableArchitecture

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            FeatureView(
                store: Store(initialState: Feature.State()) {
                    Feature()
                }
            )
        }
    }
}
```

이 정도면 화면에 `View`를 표시하기에 충분하다. 물론 순수 SwiftUI 방식으로 코드를 작성하는 것보다 몇 단계가 더 필요하지만, 이는 몇 가지 이점이 있다.
- **일관된 방식으로 상태 변이를 적용**할 수 있다.
  - (일부 Observable 객체와 UI Component의 다양한 Action Closure에 로직을 분산시키는 방법 대신.)
- **Side Effect를 간결하게 표현**할 수 있는 방법도 제공한다.
- 추가 작업을 많이 하지 않고도 `Effect`를 포함한 로직을 즉시 Test할 수 있다.

## Testing

작성중..