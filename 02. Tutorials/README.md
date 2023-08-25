# The Composable Architecture Tutorials

TCA의 [Step-by-step interactive Tutorial](https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture/) clone coding

## Essentials

- TCA에서 **Feature**를 build할 때 사용하는 기본적인 단위는 `Reducer`이다.
- Application의 로직과 동작을 구현하기 위해 `Reducer` protocol을 준수한다.
- `Reducer` protocol에는 다음과 같은 방법들이 포함된다.
  - `Action`이 시스템으로 전송될 때, `State`를 다음 상태로 진화시키는 방법
  - `Effect`가 외부와 통신하고, 시스템에 데이터를 다시 공급하는 방법
- 가장 중요한 것은 **Feature의 핵심 로직과 동작을 <u>SwiftUI의 `View`에 대한 언급 없이 완전히 분리</u>** 하여 빌드할 수 있다는 것이고, 이는 **Testable** 한 코드를 만들기 용이하다.
- `Store`는 **Feature**의 런타임 동작을 구성한다. 즉,
  - **Feature**를 업데이트하기 위해 **Action**을 처리할 수 있는 객체이다.
  - **Effect**를 실행하고, 해당 **Effect**로부터 파생된 데이터를 다시 시스템으로 공급할 수 있다.
  - 반드시, `Store`는 **한 번만 생성해야 한다.**
- `ViewStore`를 구성하여 `State`의 상태 변화를 관찰할 수 있게 된다.
  - 이 때, **SwiftUI**로 개발을 한다면 `WithViewStore`라는 경량 구문을 제공한다.
- TCA에서 말하는 `SideEffect`는 기능 개발에서 가장 중요한 측면이고, API 요청, 파일 시스템과의 상호 작용, 시간 기반 비동기 처리 등을 처리할 수 있게 해준다.
- `SideEffect`는 가장 복잡한 기능이기도 하다.
  - 네트워크 연결 상태, 접근 권한 등과 같은 외부 변수에 영향을 받기 쉽다.
  - 따라서, 실행할 때 마다 완전히 다른 값을 얻을 수도 있다.
- TCA는 `State`의 단순하고 순수한 상태 변화와, 복잡하고 지저분한 `SideEffect`를 분리한다. 이는 라이브러리의 **핵심 원칙 중 하나**이다.
- TCA는 `Reducer`에 `Effect`라는 개념을 직접 넣었다.
  - `Reducer`가 `State`를 변경하여 `Action`을 처리한 후, `Store`에서 실행되는 비동기 단위를 나타내는 **`Effect`를 반환할 수 있다.**
  - `Effect`는 **외부 시스템과 통신**하고, **외부의 데이터를 다시 `Reducer`에 공급**할 수 있다.

## Navigation