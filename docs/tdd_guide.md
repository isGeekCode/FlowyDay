# TDD 가이드 — FlowyDay

> Test-Driven Development 실전 가이드
> Red-Green-Refactor 사이클을 어떻게 적용하는가

---

## 목차
1. [TDD란 무엇인가](#tdd란-무엇인가)
2. [RED: 테스트 작성 기준](#red-테스트-작성-기준)
3. [GREEN: 구현 기준](#green-구현-기준)
4. [REFACTOR: 리팩토링 기준](#refactor-리팩토링-기준)
5. [실전 예시: Task 모델](#실전-예시-task-모델)

---

## TDD란 무엇인가

### Red-Green-Refactor 사이클

```
📕 RED (실패)
   ↓
   실패하는 테스트를 먼저 작성
   "무엇을 만들어야 하는가" 정의

📗 GREEN (성공)
   ↓
   테스트를 통과시키는 최소한의 코드 작성
   "빠르게 동작하게 만들기"

📘 REFACTOR (개선)
   ↓
   코드 품질 개선 (테스트는 여전히 통과)
   "깔끔하게 만들기"

   → 다시 RED로 (다음 기능)
```

### TDD의 핵심 원칙

1. **테스트 먼저, 코드 나중**
   - ❌ 코드 작성 → 테스트 작성
   - ✅ 테스트 작성 → 코드 작성

2. **작은 단위로 반복**
   - 한 번에 하나의 기능만
   - 테스트 1개 → 구현 → 통과 → 다음

3. **실패를 확인**
   - RED 단계에서 테스트가 실패하는지 꼭 확인
   - 통과하면 안 됨! (아직 코드가 없으니까)

---

## RED: 테스트 작성 기준

### 1. 무엇을 테스트할 것인가?

**출발점: Tech Spec의 요구사항**

예시 - Task 모델 (tech_spec.md#5.1):
```swift
struct Task: Identifiable, Codable {
    let id: String
    var text: String
    var status: TaskStatus
    // ... 기타 필드

    var isActive: Bool { ... }
    var isCompleted: Bool { ... }
}
```

**이것을 테스트로 변환:**

| 요구사항 | 테스트 |
|---------|--------|
| `Codable` 프로토콜 준수 | `testTaskCodable()` |
| `isActive` 계산 속성 | `testTaskIsActive_When상태_Returns결과()` |
| `isCompleted` 계산 속성 | `testTaskIsCompleted_When상태_Returns결과()` |
| 옵션 필드 초기화 | `testTaskInitialization_WithOptionalFields()` |

---

### 2. 테스트 작성 체크리스트

#### ✅ 1) 명확한 테스트 이름

**형식**: `test[대상]_[조건]_[예상결과]()`

```swift
// ✅ 좋은 예
func testTaskIsActive_WhenNotStarted_ReturnsTrue()
func testTaskIsActive_WhenCompleted_ReturnsFalse()

// ❌ 나쁜 예
func testTask()
func test1()
func testIsActive()
```

**이유**: 테스트 이름만 봐도 무엇을 검증하는지 알아야 함

---

#### ✅ 2) Given-When-Then 구조

```swift
func testTaskIsActive_WhenNotStarted_ReturnsTrue() {
    // Given: 테스트 데이터 준비 (전제 조건)
    let task = Task(
        id: "1",
        text: "작업",
        status: .notStarted,
        // ...
    )

    // When: 동작 실행 (테스트할 행동)
    // 계산 속성이라면 생략 가능
    let result = task.isActive

    // Then: 결과 검증 (기대하는 결과)
    XCTAssertTrue(result)
    // 또는 XCTAssertTrue(task.isActive)
}
```

**각 섹션의 역할:**
- **Given**: "이런 상황에서"
- **When**: "이렇게 하면"
- **Then**: "이런 결과가 나와야 한다"

---

#### ✅ 3) 하나의 테스트는 하나만 검증

```swift
// ✅ 좋은 예: 각각 분리
func testTaskIsActive_WhenNotStarted_ReturnsTrue() { ... }
func testTaskIsActive_WhenInProgress_ReturnsTrue() { ... }
func testTaskIsActive_WhenCompleted_ReturnsFalse() { ... }

// ❌ 나쁜 예: 여러 케이스를 한 테스트에
func testTaskIsActive() {
    let task1 = Task(status: .notStarted)
    XCTAssertTrue(task1.isActive)

    let task2 = Task(status: .completed)
    XCTAssertFalse(task2.isActive)

    // 어느 부분에서 실패했는지 파악하기 어려움!
}
```

---

#### ✅ 4) 경계값과 엣지 케이스 포함

**테스트해야 할 케이스:**

1. **정상 케이스** (Happy Path)
   ```swift
   func testTaskCodable() { ... }
   ```

2. **경계값** (Boundary Values)
   ```swift
   // 상태별로 모두 테스트
   func testTaskIsActive_WhenNotStarted_ReturnsTrue()
   func testTaskIsActive_WhenInProgress_ReturnsTrue()
   func testTaskIsActive_WhenPostponed_ReturnsTrue()
   func testTaskIsActive_WhenCancelled_ReturnsFalse()
   func testTaskIsActive_WhenCompleted_ReturnsFalse()
   ```

3. **옵션 값** (Optional Values)
   ```swift
   func testTaskInitialization_WithOptionalFields() {
       // category = nil, scheduledTime = nil 등
   }
   ```

4. **에러 케이스** (Error Cases) - 해당되는 경우
   ```swift
   func testRepository_WhenSaveFails_ThrowsError() { ... }
   ```

---

### 3. RED 단계 체크리스트

작성 후 확인:

- [ ] 테스트 이름이 명확한가?
- [ ] Given-When-Then 구조로 작성했는가?
- [ ] 하나의 테스트가 하나만 검증하는가?
- [ ] 경계값/엣지 케이스를 포함했는가?
- [ ] **테스트를 실행하면 실패하는가?** ← 가장 중요!

---

### 4. RED 작성 흐름 (실전)

**Step 1: Tech Spec 확인**
```
tech_spec.md#5.1 Task 모델 정의 읽기
→ Codable, Identifiable, 계산 속성 확인
```

**Step 2: 테스트할 항목 리스트업**
```
1. Codable 테스트
2. isActive 테스트 (상태별)
3. isCompleted 테스트
4. 초기화 테스트
```

**Step 3: 테스트 파일 생성**
```swift
// FlowyDayTests/Domain/Models/TaskTests.swift
import XCTest
@testable import FlowyDay

final class TaskTests: XCTestCase {
    // 테스트 메서드 작성
}
```

**Step 4: 각 항목별 테스트 작성**
```swift
func testTaskCodable() throws {
    // Given-When-Then
}
```

**Step 5: 실행 및 실패 확인**
```bash
Cmd+U (Xcode Test)
→ ❌ 컴파일 에러 (Task 타입 없음)
→ 성공! 이제 GREEN 단계로
```

---

## GREEN: 구현 기준

### 핵심 원칙

> **"테스트를 통과시키는 최소한의 코드만 작성한다"**

### 무엇이 "최소한"인가?

**❌ 하지 말아야 할 것:**
- 나중에 필요할 것 같은 기능 미리 추가
- 완벽하게 만들려고 오래 고민
- 테스트에 없는 기능 구현
- 성능 최적화 (아직 이름)

**✅ 해야 할 것:**
- 테스트가 요구하는 것만 구현
- 가장 간단한 방법으로
- 빠르게 초록불 켜기
- 리팩토링은 나중에 (REFACTOR 단계에서)

### GREEN 작성 흐름

**Step 1: 실패하는 테스트 확인**
```
❌ testTaskCodable: Task 타입이 없음
→ Task.swift 파일 생성 필요
```

**Step 2: 최소 구현**
```swift
// Domain/Models/Task.swift
struct Task: Identifiable, Codable {
    let id: String
    var text: String
    var status: TaskStatus
    // 테스트가 요구하는 필드만
}
```

**Step 3: 테스트 실행**
```bash
Cmd+U
→ ✅ testTaskCodable 통과!
```

**Step 4: 다음 실패 테스트로**
```
❌ testTaskIsActive: isActive 속성이 없음
→ 계산 속성 추가
```

**Step 5: 반복**
```
모든 테스트가 ✅ 될 때까지
```

---

## REFACTOR: 리팩토링 기준

### 언제 리팩토링하는가?

**타이밍**: 모든 테스트가 ✅ 통과한 후

### 무엇을 리팩토링하는가?

**코드 스멜 (개선이 필요한 신호):**

1. **중복 코드**
   ```swift
   // Before
   if status == .cancelled || status == .completed {
       return false
   }

   // After (확장 메서드로 추출)
   extension TaskStatus {
       var isInactive: Bool {
           self == .cancelled || self == .completed
       }
   }
   ```

2. **긴 함수**
   - 함수를 작은 단위로 분리

3. **매직 넘버/문자열**
   ```swift
   // Before
   let slots = 6

   // After
   private let slotsPerHour = 6
   ```

4. **불명확한 이름**
   ```swift
   // Before
   var temp: Bool

   // After
   var isActive: Bool
   ```

### REFACTOR 체크리스트

- [ ] 중복 코드를 제거했는가?
- [ ] 함수/변수 이름이 의도를 명확히 표현하는가?
- [ ] 긴 함수를 분리할 수 있는가?
- [ ] 매직 넘버/문자열을 상수로 추출했는가?
- [ ] **테스트가 여전히 ✅ 통과하는가?** ← 가장 중요!

---

## 실전 예시: Task 모델

### 전체 흐름

```
📕 RED
├─ TaskTests.swift 작성 (8개 테스트)
├─ Given-When-Then 구조
├─ 경계값 포함 (모든 status)
└─ 실행 → ❌ 실패 확인

📗 GREEN
├─ Task.swift 생성
├─ Identifiable, Codable 구현
├─ 모든 필드 정의
├─ isActive, isCompleted 계산 속성
└─ 실행 → ✅ 모두 통과

📘 REFACTOR
├─ 코드 리뷰
├─ 중복 제거
├─ 이름 개선
└─ 실행 → ✅ 여전히 통과
```

### RED: 작성한 테스트 목록

```swift
// 1. Codable 테스트
testTaskCodable()

// 2. isActive 테스트 (상태별)
testTaskIsActive_WhenNotStarted_ReturnsTrue()
testTaskIsActive_WhenInProgress_ReturnsTrue()
testTaskIsActive_WhenCompleted_ReturnsFalse()
testTaskIsActive_WhenCancelled_ReturnsFalse()

// 3. isCompleted 테스트
testTaskIsCompleted_WhenCompleted_ReturnsTrue()
testTaskIsCompleted_WhenNotCompleted_ReturnsFalse()

// 4. 초기화 테스트
testTaskInitialization_WithOptionalFields()
```

**총 8개 테스트 = 요구사항을 완전히 커버**

### GREEN: 구현 (다음 단계에서)

```swift
struct Task: Identifiable, Codable {
    // 필드 정의
    let id: String
    var text: String
    var status: TaskStatus
    // ...

    // 계산 속성
    var isActive: Bool {
        status != .cancelled && status != .completed
    }

    var isCompleted: Bool {
        status == .completed
    }
}
```

**특징**:
- 테스트가 요구하는 것만 구현
- 간단하고 명확
- 모든 테스트 통과

---

## 요약

### TDD 한 줄 정리

```
1. 테스트부터 작성 (RED)
2. 최소 구현으로 통과 (GREEN)
3. 코드 개선 (REFACTOR)
4. 반복
```

### RED 테스트 작성 기준 (핵심)

1. **Tech Spec 기반** - 요구사항을 테스트로
2. **명확한 이름** - `test[대상]_[조건]_[결과]()`
3. **Given-When-Then** - 구조화된 테스트
4. **하나씩** - 하나의 테스트는 하나만 검증
5. **경계값 포함** - 정상/경계/에러 케이스
6. **실패 확인** - RED 단계에서 꼭 실패해야 함

### 체크리스트

**RED 작성 후:**
- [ ] Tech Spec 요구사항 확인했는가?
- [ ] 테스트 이름이 명확한가?
- [ ] Given-When-Then 구조인가?
- [ ] 경계값을 포함했는가?
- [ ] **실행 시 실패하는가?**

**GREEN 구현 후:**
- [ ] 최소한의 코드만 작성했는가?
- [ ] **모든 테스트가 통과하는가?**

**REFACTOR 후:**
- [ ] 중복을 제거했는가?
- [ ] 이름이 명확한가?
- [ ] **여전히 모든 테스트가 통과하는가?**

---

**문서 버전**: 1.0.0
**작성일**: 2025-12-30
**대상 독자**: FlowyDay 개발자 (나 자신 포함)
