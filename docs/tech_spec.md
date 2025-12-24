# Tech Spec — FlowyDay MVP

## 1. 메타 정보
- **문서 버전**: 0.1.0
- **작성일**: 2025-12-24
- **작성자**: 방현석
- **대상 플랫폼**: iOS 16.0+ (iPad 전용)
- **아키텍처**: MVI (Model-View-Intent) + Clean Architecture
- **관련 문서**:
  - [overview.md](./overview.md)
  - [requirements.md](./requirements.md)
  - [architecture.md](./architecture.md)
  - [data_flow.md](./data_flow.md)
  - [ui_design.md](./ui_design.md)
  - [error_logs.md](./error_logs.md)
  - [원본 기획서](icloud://DA-008_FlowyDay.md)

---

## 2. 목표 (Goal)

FlowyDay는 Plan-Do-See 워크플로우를 디지털에 최적화한 iPad 일일 플래너다.

### 핵심 가치
사용자는 하루를 세 단계로 관리할 수 있다:
1. **Plan**: 할 일을 계획하고, 과거 항목을 재사용하며, 예상 시간을 설정한다
2. **Do**: 타이머로 실행하고, 전체 일정 맥락을 유지하며, 실제 소요 시간을 기록한다
3. **See**: 완료 항목을 확인하고, 통계를 분석하며, 회고를 작성한다

### 학습 목표
- SwiftUI + MVI 아키텍처 실전 경험
- Clean Architecture 적용
- Core Data, CloudKit 실전 사용
- StoreKit IAP 구현

---

## 3. 범위와 비범위 (Scope & Non-Scope)

### 3.1 Scope (MVP v1.0에 포함)

**Plan 기능**
- 작업 추가/수정/삭제 (CRUD)
- 예상 시간 설정 (분 단위)
- 카테고리 지정 (학습/건강/업무/취미/기타)
- 예정 시간 설정 (선택)
- 작업 상태 관리 (미시작/진행중/연기/취소/완료)
- 과거 항목 조회 및 재사용
- 날짜별 작업 관리

**Do 기능**
- 시간대별 그리드 (3:00-23:00, 10분 단위)
- 작업을 시간대에 할당
- 작업 번호 표시 (①②③...  ⒶⒷⒸ...)
- 카테고리별 색상 표시
- 현재 시간 표시 (빨간 선)
- Undo/Redo 기능
- 날짜 네비게이션 (전날/다음날)

**See 기능**
- 완료/미완료 항목 표시
- 카테고리별 시간 통계
- 작업별 평가 (별점 1-5)
- 전체 회고 작성

**데이터**
- 날짜별 로컬 저장 (UserDefaults)
- 날짜 네비게이션
- 데이터 자동 저장

**UI**
- iPad 가로 레이아웃
- Plan/Do 상단, See 하단
- 날짜 네비게이션 헤더
- 다크모드 지원

### 3.2 Non-Scope (v1.0에서 제외)

**v1.1+로 연기**
- 타이머 기능 (포모도로)
- iCloud 동기화
- 템플릿 기능
- 루틴 자동 추가
- AI 제안
- Quick Catch
- 드래그앤드롭
- Apple Pencil 지원
- Split View / Slide Over 최적화

**v2.0+로 연기**
- iPhone 앱
- macOS 앱
- 웹사이트

**수익화 (출시 준비 단계)**
- AdMob 광고
- IAP (Pro/Premium Tier)

---

## 4. 주요 시나리오 / 유저 플로우

### 4.1 일일 계획 작성 (Plan)
1. 앱 실행 → 오늘 날짜 표시
2. PLAN 탭에서 "+" 버튼 클릭
3. 작업 정보 입력:
   - 작업명 (필수)
   - 카테고리 (선택)
   - 예상 시간 (선택)
   - 예정 시간 (선택)
4. 저장 → 작업 목록에 표시 (동그라미 번호 포함)

### 4.2 실행 스케줄링 (Do)
1. DO 탭에서 시간대 그리드 확인
2. 원하는 시간대 칸 클릭
3. 작업 선택 시트에서 작업 선택
4. 작업이 할당되고 카테고리 색상 표시
5. 연속된 칸 클릭 시:
   - 같은 작업이 인접해 있으면 "이어서 하기" 옵션 제공
   - 여러 블록이 있으면 어떤 블록을 이을지 선택
6. 실수 시 Undo 버튼으로 되돌리기

### 4.3 회고 작성 (See)
1. SEE 탭에서 카테고리별 시간 통계 확인
2. 각 작업별 평가:
   - 별점 1-5 선택
   - 느낀 점 작성
3. 전체 회고 작성

### 4.4 날짜 이동
1. 상단 헤더에서 날짜 확인
2. ◀ 버튼: 전날
3. ▶ 버튼: 다음날
4. 날짜 텍스트 클릭: 오늘로 이동
5. 날짜 변경 시:
   - 현재 날짜 데이터 자동 저장
   - 새 날짜 데이터 자동 로드

---

## 5. 도메인 모델 정의

### 5.1 Task (작업)
```swift
struct Task: Identifiable, Codable {
    let id: String // UUID
    var text: String // 작업명
    var category: String? // 카테고리 (학습/건강/업무/취미/기타)
    var scheduledTime: String? // 예정 시간 (HH:mm 형식)
    var estimatedMinutes: Int? // 예상 시간 (분)
    var status: TaskStatus // 상태
    var actualMinutes: Int? // 실제 소요 시간
    var createdDate: Date // 생성일
    var qualityRating: Int? // 질적 평가 (1-5)
    var satisfactionNote: String? // 만족도 노트
}
```

### 5.2 TaskStatus (작업 상태)
```swift
enum TaskStatus: String, Codable, CaseIterable {
    case notStarted // 미시작 (□)
    case inProgress // 진행중 (☑)
    case postponed  // 연기 (>)
    case cancelled  // 취소 (-)
    case completed  // 완료 (✓)
}
```

### 5.3 TimeSlotAssignment (시간 할당)
```swift
struct TimeSlotAssignment: Codable {
    var hour: Int // 시간 (3-23)
    var slot: Int // 슬롯 (0-5, 10분 단위)
    var taskId: String // 작업 ID
}
```

### 5.4 DayData (일일 데이터)
```swift
struct DayData: Codable {
    var date: String // "yyyy-MM-dd" 형식
    var tasks: [Task] // 작업 목록
    var timeSlotAssignments: [TimeSlotAssignment] // 시간 할당
    var reflection: String // 전체 회고
}
```

### 5.5 계산 속성
```swift
// Task 확장
extension Task {
    var isActive: Bool { status != .cancelled && status != .completed }
    var isCompleted: Bool { status == .completed }
}
```

---

## 6. 아키텍처 & 계층 구조

### 6.1 MVI (Model-View-Intent) 패턴

FlowyDay는 **MVI + Clean Architecture** 구조를 따른다.

```
┌─────────────────┐
│      View       │ SwiftUI View (상태 구독, Intent 전달)
└────────┬────────┘
         │ Intent
         ▼
┌─────────────────┐
│   ViewModel     │ Intent → Action → State 변환
│  (State Store)  │ @Published var state: ViewState
└────────┬────────┘
         │ UseCase 호출
         ▼
┌─────────────────┐
│    UseCase      │ 비즈니스 로직
└────────┬────────┘
         │ Repository 호출
         ▼
┌─────────────────┐
│   Repository    │ 데이터 소스 추상화
└────────┬────────┘
         │
    ┌────┴────┐
    ▼         ▼
┌────────┐ ┌────────┐
│ Local  │ │ Remote │ (v1.1+)
│  Data  │ │  Data  │
└────────┘ └────────┘
```

### 6.2 계층별 책임

**View (SwiftUI)**
- UI 렌더링
- 사용자 입력을 Intent로 변환
- ViewModel의 State 구독 및 반영
- Navigation 처리

**ViewModel (State Store)**
- Intent 수신 및 Action 변환
- UseCase 호출
- State 업데이트 (@Published)
- Undo/Redo 스택 관리

**UseCase (Interactor)**
- 비즈니스 로직 처리
- 도메인 규칙 적용
- Repository 조합

**Repository**
- 데이터 소스 추상화
- Local/Remote 전환 로직
- 데이터 변환 (DTO ↔ Domain)

**DataSource**
- UserDefaults (MVP)
- Core Data (v1.1+)
- CloudKit (v1.1+)

### 6.3 의존성 규칙
- **내부 → 외부로만 의존**
- Domain은 어떤 계층도 의존하지 않음
- Data는 Domain에만 의존
- Presentation은 Domain에만 의존

---

## 7. 데이터 흐름 & 에러 처리 규칙

### 7.1 데이터 저장 흐름 (MVP)

**쓰기 (Write)**
```
User Action (Intent)
  ↓
ViewModel (Action)
  ↓
UseCase (Business Logic)
  ↓
Repository (saveData)
  ↓
UserDefaults (JSON 저장)
  key: "dayData_yyyy-MM-dd"
  value: DayData (JSON)
```

**읽기 (Read)**
```
날짜 변경 (Intent)
  ↓
ViewModel (loadData)
  ↓
Repository (loadData)
  ↓
UserDefaults (JSON 로드)
  ↓
DayData 파싱
  ↓
State 업데이트
```

### 7.2 날짜 전환 흐름
1. 사용자가 날짜 변경 (전날/다음날/오늘)
2. ViewModel이 현재 날짜 데이터 저장
3. selectedDate 변경
4. didSet에서 새 날짜 데이터 로드
5. Undo/Redo 스택 초기화

### 7.3 에러 처리 규칙

**에러 타입**
```swift
enum AppError: Error {
    case dataLoadFailed(reason: String)
    case dataSaveFailed(reason: String)
    case invalidDate
    case decodingFailed
    case encodingFailed
}
```

**처리 원칙**
- 모든 에러는 ViewModel에서 catch
- 사용자에게 명확한 메시지 표시
- error_logs.md에 기록
- 데이터 손실 방지 우선

**Fallback 전략**
- 로드 실패 시: 빈 상태로 초기화
- 저장 실패 시: 재시도 (최대 3회)
- 파싱 실패 시: 에러 로그 + 빈 상태

---

## 8. 비기능 요구사항 (Non-Functional Requirements)

### 8.1 성능
- 앱 시작: 1초 이내
- 날짜 전환: 500ms 이내
- 작업 추가/수정: 즉시 반영
- 그리드 렌더링: 60fps 유지

### 8.2 데이터
- 자동 저장: 모든 변경사항 즉시 저장
- 데이터 보존: 삭제하지 않는 한 영구 보존
- 용량: 1년치 데이터 < 50MB

### 8.3 UX
- 다크모드 지원
- 동적 타입 (Dynamic Type) 지원
- VoiceOver 지원 (기본)
- 햅틱 피드백 (v1.1+)

### 8.4 보안
- 사용자 데이터는 로컬에만 저장 (MVP)
- iCloud 사용 시 암호화 (v1.1+)
- 개인정보 수집 없음

### 8.5 로깅
- 에러 발생 시 error_logs.md에 기록
- 사용자 행동 로깅 없음 (프라이버시)
- Crash 리포트만 수집 (v1.1+)

---

## 9. 테스트 전략 개요

### 9.1 TDD (Test-Driven Development) 방식 채택

FlowyDay는 **TDD 방식**으로 개발한다. 모든 기능은 **Red-Green-Refactor** 사이클을 따른다.

**TDD 사이클**:
1. **Red**: 실패하는 테스트를 먼저 작성
2. **Green**: 테스트를 통과하는 최소한의 코드 작성
3. **Refactor**: 코드 품질 개선 (테스트는 여전히 통과)

**적용 범위**:
- **필수**: Domain Layer (Models, UseCases), Data Layer (Repository)
- **권장**: Presentation Layer (ViewModel)
- **선택**: UI Layer (SwiftUI Views)

### 9.2 Unit Test

**도메인 모델 테스트**
- Task, DayData 등의 Codable 테스트
- 계산 속성 테스트 (isActive, isCompleted 등)
- TaskStatus enum 케이스 테스트

**UseCase 테스트**
- 비즈니스 로직 테스트 (Mock Repository 사용)
- 에러 처리 테스트
- Edge Case 테스트

**Repository 테스트**
- 데이터 저장/로드 테스트 (Mock DataSource 사용)
- DTO ↔ Domain 변환 테스트
- 에러 처리 테스트

**ViewModel 테스트**
- Intent → Action → State 변환 테스트
- Mock UseCase 사용
- Undo/Redo 로직 테스트
- 날짜 전환 테스트

### 9.3 TDD 작업 흐름

각 기능 구현 시:
```
1. Write Test (Red)
   - 예: TaskTests.swift 작성
   - 테스트 실행 → 실패 확인

2. Write Code (Green)
   - 예: Task.swift 구현
   - 테스트 실행 → 통과 확인

3. Refactor
   - 코드 개선
   - 테스트 실행 → 여전히 통과
```

### 9.4 UI Test (선택)
- 주요 플로우 1개 이상
- 작업 추가 → 시간 할당 → 회고

### 9.5 Manual Test
- 날짜 전환 정상 동작
- Undo/Redo 정상 동작
- 데이터 저장/로드 정상 동작
- 다크모드 전환 정상 동작

### 9.6 테스트 커버리지 목표
- Domain Layer: 90%+
- Data Layer: 80%+
- Presentation Layer: 70%+
- 전체: 75%+

---

## 10. 제약사항 (Constraints)

### 10.1 필수 사용 기술
- SwiftUI (UI 프레임워크)
- Combine (반응형 프로그래밍)
- UserDefaults (MVP 데이터 저장)
- MVI 패턴 (아키텍처)

### 10.2 사용 금지
- UIKit (SwiftUI 학습 목적)
- Realm, Firebase (Core Data 학습 목적)
- 외부 네트워킹 라이브러리 (MVP에서 불필요)

### 10.3 코딩 스타일
- Swift API Design Guidelines 준수
- SwiftLint 사용 (권장)
- 주석은 "왜"에 집중 (What은 코드로 표현)
- 한 함수 = 한 책임

### 10.4 파일 구조
```
FlowyDay/
├── App/
│   └── FlowyDayApp.swift
├── Presentation/
│   ├── Views/
│   ├── ViewModels/
│   └── Components/
├── Domain/
│   ├── Models/
│   ├── UseCases/
│   └── Repositories/ (Protocols)
└── Data/
    ├── Repositories/ (Implementations)
    └── DataSources/
```

---

## 11. MVP 기능 우선순위

### P0 (필수 - Week 1-2)
- Task CRUD
- 날짜별 데이터 관리
- Do 그리드 + 작업 할당
- Undo/Redo
- 날짜 네비게이션
- 로컬 저장/로드

### P1 (중요 - Week 2-3)
- 카테고리별 색상
- See 탭 통계
- 작업 평가 (별점)
- 전체 회고

### P2 (보완 - Week 3-4)
- UI 폴리싱
- 다크모드 최적화
- 에러 처리 개선
- 테스트 작성

---

## 12. 변경 이력 (Change Log)

- **v0.2.0** (2025-12-24) — TDD 전략 추가
  - TDD (Test-Driven Development) 방식 채택
  - Red-Green-Refactor 사이클 명시
  - 테스트 커버리지 목표 설정
  - Unit Test 전략 상세화

- **v0.1.0** (2025-12-24) — 최초 작성
  - MVP 범위 정의
  - MVI 아키텍처 설계
  - 도메인 모델 정의
  - 데이터 흐름 정의

---

**문서 버전**: 0.2.0
**최종 수정일**: 2025-12-24
**다음 업데이트**: 개발 시작 후
