# TODO — FlowyDay MVP

## 상태 규칙
- [ ] `TODO`   : 아직 착수하지 않은 작업
- [~] `DOING` : 진행 중인 작업
- [x] `DONE`  : 완료된 작업 (테스트 통과)

---

## 1. 문서화 및 초기 세팅

### T-001 — 프로젝트 문서 작성
- 상태: [x] DONE
- 목적: 개발 전 체계적인 문서를 준비한다
- 관련 Tech Spec 섹션: 전체
- 작업 내용:
  - [x] overview.md 작성
  - [x] tech_spec.md 작성
  - [x] todo.md 작성 (현재 문서)
  - [ ] requirements.md 작성
  - [ ] architecture.md 작성
  - [ ] data_flow.md 작성
  - [ ] ui_design.md 작성
  - [ ] error_logs.md 초기화
- Definition of Done:
  - 모든 문서가 생성되고 기본 내용이 작성됨
  - howToMakeTechSpecAndTODO.md 규칙을 따름
- Test:
  - 문서 간 링크가 정상 작동
  - AI가 문서만 보고 프로젝트 이해 가능
- 참고 문서:
  - howToMakeTechSpecAndTODO.md
  - DA-008_FlowyDay.md (기획서)

---

### T-002 — Xcode 프로젝트 생성
- 상태: [ ] TODO
- 목적: SwiftUI 기반 iPad 앱 프로젝트를 생성한다
- 관련 Tech Spec 섹션: 6. 아키텍처 & 계층 구조
- 작업 내용:
  - Xcode에서 새 iOS App 프로젝트 생성
  - 프로젝트명: FlowyDay
  - Interface: SwiftUI
  - Lifecycle: SwiftUI App
  - Language: Swift
  - 최소 버전: iOS 16.0
  - Device: iPad only
- Definition of Done:
  - 프로젝트가 생성되고 빌드 가능
  - iPad 시뮬레이터에서 실행 가능
  - "Hello, World!" 화면 표시
- Test:
  - iPad Pro 12.9" 시뮬레이터에서 빌드 & 실행
  - 가로/세로 모두 정상 표시
- 참고 문서:
  - tech_spec.md#6-아키텍처--계층-구조
  - tech_spec.md#104-파일-구조

---

### T-003 — 기본 폴더 구조 구성
- 상태: [ ] TODO
- 목적: MVI + Clean Architecture 폴더 구조를 만든다
- 관련 Tech Spec 섹션: 6. 아키텍처 & 계층 구조
- 작업 내용:
  - App/ 폴더 생성 (FlowyDayApp.swift)
  - Presentation/ 폴더 생성
    - Views/
    - ViewModels/
    - Components/
  - Domain/ 폴더 생성
    - Models/
    - UseCases/
    - Repositories/ (Protocols)
  - Data/ 폴더 생성
    - Repositories/ (Implementations)
    - DataSources/
- Definition of Done:
  - 모든 폴더가 생성됨
  - 각 폴더에 .gitkeep 또는 README.md 추가
  - 프로젝트가 여전히 빌드 가능
- Test:
  - 폴더 구조가 tech_spec과 일치
  - Xcode 프로젝트 네비게이터에서 정상 표시
- 참고 문서:
  - tech_spec.md#62-계층별-책임
  - tech_spec.md#104-파일-구조

---

## 2. 도메인 레이어 구현 (TDD 적용)

### T-010 — Task 모델 (Red-Green-Refactor)
- 상태: [ ] TODO
- 목적: Task 도메인 모델을 TDD로 구현한다
- 관련 Tech Spec 섹션: 5.1 Task, 9.1 TDD
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Domain/Models/TaskTests.swift 생성
  - 작성할 테스트:
    - `testTaskCodable()` - Task를 JSON으로 인코딩/디코딩
    - `testTaskIsActive()` - status별 isActive 값 확인
    - `testTaskIsCompleted()` - status별 isCompleted 값 확인
    - `testTaskInitialization()` - 기본값 확인
  - 테스트 실행 → **실패 확인** (Task 타입 없음)

  **[GREEN] 최소 구현으로 테스트 통과**:
  - Domain/Models/Task.swift 생성
  - Task 구조체 정의 (Identifiable, Codable)
  - 모든 필드 정의 (id, text, category, status, estimatedMinutes 등)
  - 계산 속성 구현 (isActive, isCompleted)
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 코드 개선**:
  - 불필요한 코드 제거
  - 주석 추가 (필요 시)
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과 (4개 이상)
  - ✅ Task 모델이 Tech Spec과 100% 일치
  - ✅ Codable 정상 작동
  - ✅ 코드 커버리지 90%+
- 참고 문서:
  - tech_spec.md#51-task
  - tech_spec.md#91-tdd-방식-채택

---

### T-011 — TaskStatus, TimeSlotAssignment, DayData 모델 (TDD)
- 상태: [ ] TODO
- 목적: 나머지 도메인 모델을 TDD로 구현한다
- 관련 Tech Spec 섹션: 5.2~5.4
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Domain/Models/TaskStatusTests.swift 생성
    - `testAllCases()` - 5개 케이스 존재 확인
    - `testRawValues()` - rawValue 확인
    - `testCodable()` - JSON 인코딩/디코딩
  - FlowyDayTests/Domain/Models/TimeSlotAssignmentTests.swift 생성
    - `testCodable()` - JSON 인코딩/디코딩
    - `testValidHourRange()` - hour 범위 (3-23)
    - `testValidSlotRange()` - slot 범위 (0-5)
  - FlowyDayTests/Domain/Models/DayDataTests.swift 생성
    - `testCodable()` - JSON 인코딩/디코딩
    - `testWithMultipleTasks()` - 여러 Task 포함
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Domain/Models/TaskStatus.swift 생성
  - Domain/Models/TimeSlotAssignment.swift 생성
  - Domain/Models/DayData.swift 생성
  - Codable 준수, 모든 필드 정의
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 코드 개선**:
  - Helper methods 추가 고려
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ Tech Spec과 100% 일치
  - ✅ 코드 커버리지 90%+
- 참고 문서:
  - tech_spec.md#52-taskstatus
  - tech_spec.md#53-timeslotassignment
  - tech_spec.md#54-daydata

---

### T-012 — Repository 프로토콜 정의
- 상태: [ ] TODO
- 목적: 데이터 접근 인터페이스를 정의한다
- 관련 Tech Spec 섹션: 6.2 계층별 책임
- 작업 내용:
  - Domain/Repositories/DayDataRepository.swift 생성
  - 프로토콜 정의:
    ```swift
    protocol DayDataRepository {
        func loadDayData(for date: Date) -> Result<DayData?, AppError>
        func saveDayData(_ data: DayData, for date: Date) -> Result<Void, AppError>
    }
    ```
- Definition of Done:
  - ✅ 프로토콜 정의됨
  - ✅ Result 타입 사용 (에러 처리)
  - ✅ 컴파일 가능
- Test:
  - Mock 구현으로 프로토콜 준수 가능 확인
- 참고 문서:
  - tech_spec.md#62-계층별-책임

---

### T-013 — TaskUseCase 구현 (TDD)
- 상태: [ ] TODO
- 목적: Task 관련 비즈니스 로직을 TDD로 구현한다
- 관련 Tech Spec 섹션: 6.2 계층별 책임
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Domain/UseCases/TaskUseCaseTests.swift 생성
  - Mock Repository 생성
  - 테스트 작성:
    - `testAddTask()` - 작업 추가 성공
    - `testUpdateTask()` - 작업 수정 성공
    - `testDeleteTask()` - 작업 삭제 성공
    - `testGetActiveTasks()` - 활성 작업만 조회
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Domain/UseCases/TaskUseCase.swift 생성
  - Repository 주입
  - 메서드 구현 (addTask, updateTask, deleteTask, getActiveTasks)
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 개선**:
  - 중복 코드 제거
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ Mock Repository로 격리된 테스트
  - ✅ 순수 비즈니스 로직만 포함
- 참고 문서:
  - tech_spec.md#92-unit-test

---

### T-014 — TimeSlotUseCase, DayDataUseCase 구현 (TDD)
- 상태: [ ] TODO
- 목적: 나머지 UseCase를 TDD로 구현한다
- 관련 Tech Spec 섹션: 6.2 계층별 책임
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Domain/UseCases/TimeSlotUseCaseTests.swift 생성
    - `testAssignTask()` - 시간 슬롯에 작업 할당
    - `testRemoveAssignment()` - 할당 제거
    - `testGetTaskBlocks()` - 작업 블록 조회
  - FlowyDayTests/Domain/UseCases/DayDataUseCaseTests.swift 생성
    - `testLoadDayData()` - 데이터 로드
    - `testSaveDayData()` - 데이터 저장
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Domain/UseCases/TimeSlotUseCase.swift 생성
  - Domain/UseCases/DayDataUseCase.swift 생성
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 개선**:
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ 비즈니스 로직 검증됨
- 참고 문서:
  - tech_spec.md#62-계층별-책임

---

## 3. 데이터 레이어 구현 (TDD 적용)

### T-020 — LocalDataSource 구현 (TDD)
- 상태: [ ] TODO
- 목적: UserDefaults 기반 로컬 저장소를 TDD로 구현한다
- 관련 Tech Spec 섹션: 7.1 데이터 저장 흐름
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Data/DataSources/LocalDataSourceTests.swift 생성
  - Mock UserDefaults 사용
  - 테스트 작성:
    - `testSaveData()` - 데이터 저장 성공
    - `testLoadData()` - 데이터 로드 성공
    - `testLoadNonexistentData()` - 없는 데이터 로드 시 nil 반환
    - `testSaveAndLoadRoundTrip()` - 저장 후 로드 시 데이터 일치
    - `testInvalidJSON()` - 잘못된 JSON 처리
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Data/DataSources/LocalDataSource.swift 생성
  - UserDefaults 주입
  - save/load 메서드 구현
  - Key 형식: "dayData_yyyy-MM-dd"
  - JSONEncoder/Decoder 사용
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 개선**:
  - 중복 코드 제거
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ 저장/로드 정상 동작
  - ✅ 에러 처리 구현
  - ✅ 코드 커버리지 80%+
- 참고 문서:
  - tech_spec.md#71-데이터-저장-흐름-mvp

---

### T-021 — DayDataRepositoryImpl 구현 (TDD)
- 상태: [ ] TODO
- 목적: DayDataRepository 프로토콜 구현체를 TDD로 작성한다
- 관련 Tech Spec 섹션: 6.2 계층별 책임
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Data/Repositories/DayDataRepositoryImplTests.swift 생성
  - Mock LocalDataSource 생성
  - 테스트 작성:
    - `testLoadDayDataSuccess()` - 로드 성공
    - `testLoadDayDataFailure()` - 로드 실패 시 에러 반환
    - `testSaveDayDataSuccess()` - 저장 성공
    - `testSaveDayDataFailure()` - 저장 실패 시 에러 반환
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Data/Repositories/DayDataRepositoryImpl.swift 생성
  - LocalDataSource 주입
  - loadDayData(), saveDayData() 구현
  - 에러 처리 (Result 타입 사용)
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 개선**:
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ 프로토콜 모든 메서드 구현
  - ✅ Mock으로 격리된 테스트
  - ✅ 에러 처리 완료
- 참고 문서:
  - tech_spec.md#62-계층별-책임
  - tech_spec.md#73-에러-처리-규칙

---

## 4. Presentation 레이어 - Plan (ViewModel TDD, View 일반 구현)

### T-030 — PlanViewModel 구현 (TDD + MVI)
- 상태: [ ] TODO
- 목적: Plan 화면의 상태 관리를 TDD로 구현한다
- 관련 Tech Spec 섹션: 6.1 MVI 패턴, 9.1 TDD
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Presentation/ViewModels/PlanViewModelTests.swift 생성
  - Mock TaskUseCase 생성
  - 테스트 작성:
    - `testAddTaskIntent()` - Intent → State 변환
    - `testUpdateTaskIntent()` - 작업 수정
    - `testDeleteTaskIntent()` - 작업 삭제
    - `testLoadTasksIntent()` - 작업 목록 로드
    - `testStateUpdate()` - State가 @Published로 업데이트
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Presentation/ViewModels/PlanViewModel.swift 생성
  - ViewState 정의 (tasks: [Task])
  - Intent 정의 (addTask, updateTask, deleteTask, loadTasks)
  - Action → State 변환 로직
  - TaskUseCase 주입 및 호출
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 개선**:
  - MVI 패턴 최적화
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ @Published var state: PlanViewState
  - ✅ Intent → Action → State 흐름 명확
  - ✅ Mock으로 격리된 테스트
- 참고 문서:
  - tech_spec.md#61-mvi-model-view-intent-패턴
  - tech_spec.md#92-unit-test

---

### T-031 — PlanBlockView 구현
- 상태: [ ] TODO
- 목적: Plan 탭 UI를 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Views/PlanBlockView.swift 생성
  - 작업 목록 표시 (LazyVStack)
  - + 버튼 (AddTaskSheet 표시)
  - 각 작업 카드:
    - 체크박스 (상태별)
    - 동그라미 번호 (회색)
    - 작업 정보 (제목, 카테고리, 시간)
    - 우측 컬러 바 (카테고리 색상)
- Definition of Done:
  - ViewModel의 state 구독
  - Intent 전달 (onAddTask, onUpdateTask...)
  - 다크모드 대응
- Test:
  - Preview에서 정상 표시
  - 작업 추가/수정/삭제 동작
- 참고 문서:
  - tech_spec.md#41-일일-계획-작성-plan
  - FlowyDay2/Views/PlanBlockView.swift (참고)

---

### T-032 — AddTaskSheet 구현
- 상태: [ ] TODO
- 목적: 작업 추가 시트를 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Views/AddTaskSheet.swift 생성
  - Form 레이아웃:
    - 작업명 입력 (필수)
    - 카테고리 선택 (Picker)
    - 예상 시간 입력 (Stepper, 분 단위)
    - 예정 시간 선택 (DatePicker, 선택)
  - 저장/취소 버튼
- Definition of Done:
  - 모든 필드 입력 가능
  - 저장 시 ViewModel로 Intent 전달
  - 입력 검증 (작업명 필수)
- Test:
  - Preview에서 정상 표시
  - 저장 후 시트 닫힘
- 참고 문서:
  - tech_spec.md#41-일일-계획-작성-plan

---

### T-033 — TaskStatusCheckbox 컴포넌트
- 상태: [ ] TODO
- 목적: 상태별 체크박스를 구현한다
- 관련 Tech Spec 섹션: 5. 도메인 모델 정의
- 작업 내용:
  - Presentation/Components/TaskStatusCheckbox.swift 생성
  - TaskStatus에 따른 아이콘:
    - notStarted: □ (빈 사각형)
    - inProgress: ☑ (체크된 사각형)
    - postponed: > (화살표)
    - cancelled: - (대시)
    - completed: ✓ (체크)
  - 탭 시 상태 변경 다이얼로그
- Definition of Done:
  - 모든 상태에 대한 아이콘 표시
  - 탭 시 액션 호출
- Test:
  - Preview에서 모든 상태 확인
- 참고 문서:
  - tech_spec.md#52-taskstatus-작업-상태

---

## 5. Presentation 레이어 - Do (ViewModel TDD, View 일반 구현)

### T-040 — DoViewModel 구현 (TDD + MVI)
- 상태: [ ] TODO
- 목적: Do 화면의 상태 관리를 TDD로 구현한다
- 관련 Tech Spec 섹션: 6.1 MVI 패턴, 9.1 TDD
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Presentation/ViewModels/DoViewModelTests.swift 생성
  - Mock TimeSlotUseCase 생성
  - 테스트 작성:
    - `testAssignTaskIntent()` - 작업 할당
    - `testRemoveAssignmentIntent()` - 할당 제거
    - `testUndoIntent()` - Undo 동작
    - `testRedoIntent()` - Redo 동작
    - `testUndoRedoStack()` - 스택 관리 (최대 50개)
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Presentation/ViewModels/DoViewModel.swift 생성
  - ViewState 정의 (timeSlotAssignments, undoStack, redoStack)
  - Intent 정의 (assignTask, removeAssignment, undo, redo)
  - TimeSlotUseCase 주입
  - Undo/Redo 로직 구현
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 개선**:
  - 스택 관리 최적화
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ Undo/Redo 스택 정상 동작
  - ✅ 최대 50개 제한 검증
  - ✅ Mock으로 격리된 테스트
- 참고 문서:
  - tech_spec.md#61-mvi-model-view-intent-패턴

---

### T-041 — DoBlockView 구현
- 상태: [ ] TODO
- 목적: Do 탭 시간 그리드 UI를 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Views/DoBlockView.swift 생성
  - 헤더:
    - DO 제목
    - Undo/Redo 버튼
  - 시간 그리드 (3:00-23:00, 10분 단위)
  - 시간 표시 (왼쪽)
  - 6개 슬롯 (가로)
  - TimeSlotCell 컴포넌트 사용
- Definition of Done:
  - 그리드 레이아웃 정상 표시
  - 스크롤 가능
  - Undo/Redo 버튼 동작
- Test:
  - Preview에서 정상 표시
  - iPad 가로/세로 모두 확인
- 참고 문서:
  - tech_spec.md#42-실행-스케줄링-do
  - FlowyDay2/Views/DoBlockView.swift (참고)

---

### T-042 — TimeSlotCell 구현
- 상태: [ ] TODO
- 목적: 개별 시간 슬롯 셀을 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Components/TimeSlotCell.swift 생성
  - 기본 상태: 회색 테두리
  - 할당된 상태:
    - 카테고리 색상 배경 (투명도 적용)
    - 작업 번호 표시 (첫 칸만)
  - 현재 시간: 빨간 세로줄
  - 탭 제스처:
    - 빈 칸: TaskPickerSheet
    - 인접 칸: 블록 선택 다이얼로그
- Definition of Done:
  - 모든 상태 정상 표시
  - 탭 동작 정상
  - 투명도 차이로 작업 구별
- Test:
  - Preview에서 다양한 상태 확인
  - 색상 구별 테스트
- 참고 문서:
  - tech_spec.md#42-실행-스케줄링-do

---

### T-043 — TaskPickerSheet 구현
- 상태: [ ] TODO
- 목적: 작업 선택 시트를 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Views/TaskPickerSheet.swift 생성
  - 작업 목록 표시
  - 각 작업:
    - 동그라미 번호
    - 작업 정보
    - 선택 시 체크 표시
  - 블록 선택 로직:
    - 여러 블록 있으면 선택 다이얼로그
    - 사이 작업 있으면 경고 표시
  - 할당 제거 버튼 (이미 할당된 경우)
- Definition of Done:
  - 작업 선택 시 할당
  - 블록 선택 정상 동작
  - 경고 메시지 표시
- Test:
  - 다양한 시나리오 테스트
  - 경고 표시 확인
- 참고 문서:
  - tech_spec.md#42-실행-스케줄링-do

---

## 6. Presentation 레이어 - See (ViewModel TDD, View 일반 구현)

### T-050 — SeeViewModel 구현 (TDD + MVI)
- 상태: [ ] TODO
- 목적: See 화면의 상태 관리를 TDD로 구현한다
- 관련 Tech Spec 섹션: 6.1 MVI 패턴, 9.1 TDD
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Presentation/ViewModels/SeeViewModelTests.swift 생성
  - 테스트 작성:
    - `testCalculateCategoryStats()` - 카테고리별 시간 집계
    - `testUpdateReflectionIntent()` - 회고 업데이트
    - `testEvaluateTaskIntent()` - 작업 평가 (별점)
    - `testEmptyStats()` - 데이터 없을 때 처리
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Presentation/ViewModels/SeeViewModel.swift 생성
  - ViewState 정의 (categoryStats, tasks, reflection)
  - Intent 정의 (updateReflection, evaluateTask)
  - 카테고리별 시간 집계 로직
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 개선**:
  - 통계 계산 최적화
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ 카테고리 통계 정확
  - ✅ @Published var state: SeeViewState
- 참고 문서:
  - tech_spec.md#61-mvi-model-view-intent-패턴

---

### T-051 — SeeBlockView 구현
- 상태: [ ] TODO
- 목적: See 탭 UI를 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Views/SeeBlockView.swift 생성
  - 2단 레이아웃:
    - 왼쪽: 카테고리별 통계
    - 오른쪽: 작업별 평가
  - 카테고리 통계:
    - 카테고리별 시간 합계
    - ProgressBar
    - 색상 표시
  - 전체 회고 TextEditor
- Definition of Done:
  - 통계 정상 표시
  - 회고 작성 가능
  - 2단 레이아웃 정상 동작
- Test:
  - Preview에서 정상 표시
  - 다양한 데이터로 테스트
- 참고 문서:
  - tech_spec.md#43-회고-작성-see
  - FlowyDay2/Views/SeeBlockView.swift (참고)

---

### T-052 — TaskEvaluationCard 구현
- 상태: [ ] TODO
- 목적: 작업별 평가 카드를 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Components/TaskEvaluationCard.swift 생성
  - 작업 정보 표시
  - 별점 표시 (1-5)
  - 평가하기 버튼 (TaskEvaluationSheet)
  - 노트 표시
- Definition of Done:
  - 카드 정상 표시
  - 버튼 동작 정상
- Test:
  - Preview에서 확인
- 참고 문서:
  - tech_spec.md#43-회고-작성-see

---

### T-053 — TaskEvaluationSheet 구현
- 상태: [ ] TODO
- 목적: 작업 평가 시트를 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Views/TaskEvaluationSheet.swift 생성
  - 별점 선택 (1-5)
  - 느낀 점 TextEditor
  - 저장/취소 버튼
- Definition of Done:
  - 별점 선택 가능
  - 노트 작성 가능
  - 저장 시 ViewModel로 Intent 전달
- Test:
  - Preview에서 정상 표시
  - 저장 후 시트 닫힘
- 참고 문서:
  - tech_spec.md#43-회고-작성-see

---

## 7. 메인 화면 및 통합

### T-060 — MainViewModel 구현 (TDD)
- 상태: [ ] TODO
- 목적: 전체 앱의 상태 관리를 TDD로 구현한다
- 관련 Tech Spec 섹션: 6.1 MVI 패턴, 7.2 날짜 전환 흐름
- **TDD 작업 순서**:

  **[RED] 실패하는 테스트 작성**:
  - FlowyDayTests/Presentation/ViewModels/MainViewModelTests.swift 생성
  - Mock DayDataUseCase 생성
  - 테스트 작성:
    - `testGoToPreviousDay()` - 전날 이동
    - `testGoToNextDay()` - 다음날 이동
    - `testGoToToday()` - 오늘 이동
    - `testDateChangeAutoSaveLoad()` - 날짜 변경 시 자동 저장/로드
    - `testUndoStackResetOnDateChange()` - 날짜 변경 시 Undo/Redo 스택 초기화
  - 테스트 실행 → **실패 확인**

  **[GREEN] 최소 구현**:
  - Presentation/ViewModels/MainViewModel.swift 생성
  - selectedDate 관리
  - 날짜 전환 로직 (goToPreviousDay, goToNextDay, goToToday)
  - DayDataUseCase 주입
  - 날짜 변경 시 자동 저장/로드
  - 테스트 실행 → **통과 확인**

  **[REFACTOR] 개선**:
  - 테스트 실행 → **여전히 통과**

- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ 날짜 네비게이션 정상 동작
  - ✅ 자동 저장/로드 검증
- 참고 문서:
  - tech_spec.md#72-날짜-전환-흐름

---

### T-061 — ContentView 구현
- 상태: [ ] TODO
- 목적: 메인 레이아웃을 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Views/ContentView.swift 생성
  - 헤더:
    - FlowyDay 타이틀
    - 날짜 네비게이션 (◀ 날짜 ▶)
    - 캘린더 버튼
  - 메인 그리드:
    - 상단: Plan (왼쪽) + Do (오른쪽)
    - 하단: See (전체 너비)
  - GeometryReader로 반응형 레이아웃
- Definition of Done:
  - 3개 블록 정상 배치
  - 날짜 네비게이션 동작
  - iPad 가로/세로 모두 최적화
- Test:
  - iPad Pro 12.9" 시뮬레이터
  - 가로/세로 회전 테스트
- 참고 문서:
  - tech_spec.md#44-날짜-이동
  - FlowyDay2/ContentView.swift (참고)

---

### T-062 — CalendarBlockView 구현
- 상태: [ ] TODO
- 목적: 캘린더 시트를 구현한다
- 관련 Tech Spec 섹션: 4. 주요 시나리오 / 유저 플로우
- 작업 내용:
  - Presentation/Views/CalendarBlockView.swift 생성
  - DatePicker 표시
  - 날짜 선택 시 MainViewModel로 전달
  - 시트 닫기
- Definition of Done:
  - 캘린더 표시 정상
  - 날짜 선택 시 화면 업데이트
  - 시트 정상 동작
- Test:
  - Preview에서 확인
  - 날짜 선택 후 데이터 로드 확인
- 참고 문서:
  - tech_spec.md#44-날짜-이동

---

## 8. 통합 및 테스트

### T-070 — Dependency Injection 설정
- 상태: [ ] TODO
- 목적: 의존성 주입을 설정한다
- 관련 Tech Spec 섹션: 6. 아키텍처 & 계층 구조
- 작업 내용:
  - App/DependencyContainer.swift 생성
  - Repository 생성
  - UseCase 생성
  - ViewModel 생성
  - FlowyDayApp.swift에서 주입
- Definition of Done:
  - 모든 의존성 정상 주입
  - 컴파일 에러 없음
  - 앱 실행 가능
- Test:
  - 앱 실행 후 모든 화면 정상 동작
- 참고 문서:
  - tech_spec.md#63-의존성-규칙

---

### T-071 — 데이터 저장/로드 통합 테스트
- 상태: [ ] TODO
- 목적: 전체 데이터 흐름을 검증한다
- 관련 Tech Spec 섹션: 7. 데이터 흐름 & 에러 처리 규칙
- 작업 내용:
  - 작업 추가 → 저장 확인
  - 시간 할당 → 저장 확인
  - 회고 작성 → 저장 확인
  - 날짜 전환 → 저장/로드 확인
  - 앱 재시작 → 데이터 유지 확인
- Definition of Done:
  - 모든 데이터가 정상 저장/로드
  - 날짜별로 독립적 관리
  - 앱 재시작 후에도 데이터 유지
- Test:
  - Manual Test 수행
  - 다양한 시나리오 테스트
- 참고 문서:
  - tech_spec.md#71-데이터-저장-흐름-mvp
  - tech_spec.md#72-날짜-전환-흐름

---

### T-072 — Undo/Redo 통합 테스트
- 상태: [ ] TODO
- 목적: Undo/Redo 기능을 검증한다
- 관련 Tech Spec 섹션: 3.1 Scope
- 작업 내용:
  - 작업 할당 → Undo → 복원 확인
  - 여러 작업 → Undo/Redo 반복
  - 날짜 전환 → 스택 초기화 확인
  - 최대 50개 제한 확인
- Definition of Done:
  - Undo/Redo 정상 동작
  - 버튼 활성화/비활성화 정상
  - 스택 제한 동작
- Test:
  - Manual Test 수행
- 참고 문서:
  - tech_spec.md#31-scope-mvp-v10에-포함

---

### T-073 — UI 폴리싱
- 상태: [ ] TODO
- 목적: UI를 다듬고 다크모드를 최적화한다
- 관련 Tech Spec 섹션: 8. 비기능 요구사항
- 작업 내용:
  - 색상 일관성 확인
  - 폰트 크기 조정
  - 간격/패딩 조정
  - 다크모드 색상 최적화
  - 그림자/테두리 조정
- Definition of Done:
  - 라이트/다크 모드 모두 깔끔
  - 색상 대비 충분
  - 일관된 디자인 언어
- Test:
  - 라이트/다크 모드 전환 테스트
  - iPad 실기기 확인
- 참고 문서:
  - tech_spec.md#83-ux

---

### T-074 — 에러 처리 개선
- 상태: [ ] TODO
- 목적: 에러 상황을 사용자 친화적으로 처리한다
- 관련 Tech Spec 섹션: 7. 데이터 흐름 & 에러 처리 규칙
- 작업 내용:
  - 저장 실패 시 재시도 로직
  - 로드 실패 시 fallback (빈 상태)
  - 사용자에게 명확한 에러 메시지
  - Alert/Toast 표시
- Definition of Done:
  - 모든 에러 상황 처리
  - 사용자 메시지 명확
  - 앱 크래시 없음
- Test:
  - 강제 에러 발생 시나리오
  - 에러 메시지 확인
- 참고 문서:
  - tech_spec.md#73-에러-처리-규칙

---

## 9. 코드 정리 및 문서화

### T-080 — SwiftLint 설정
- 상태: [ ] TODO
- 목적: 코드 스타일을 일관되게 유지한다
- 관련 Tech Spec 섹션: 10. 제약사항
- 작업 내용:
  - .swiftlint.yml 생성
  - 기본 룰 설정
  - Xcode Build Phase에 추가
  - 경고 수정
- Definition of Done:
  - SwiftLint 실행 가능
  - 주요 경고 0개
  - 일관된 코드 스타일
- Test:
  - 빌드 시 SwiftLint 실행
- 참고 문서:
  - tech_spec.md#103-코딩-스타일

---

### T-081 — README.md 작성
- 상태: [ ] TODO
- 목적: 프로젝트 README를 작성한다
- 관련 Tech Spec 섹션: 전체
- 작업 내용:
  - 프로젝트 소개
  - 기능 목록
  - 스크린샷
  - 아키텍처 설명
  - 빌드 방법
  - 라이선스
- Definition of Done:
  - README.md 작성 완료
  - 스크린샷 포함
  - 포트폴리오 활용 가능
- Test:
  - GitHub에서 정상 표시
- 참고 문서:
  - overview.md
  - tech_spec.md

---

### T-082 — 전체 테스트 실행 및 커버리지 확인
- 상태: [ ] TODO
- 목적: 전체 테스트 스위트를 실행하고 커버리지를 확인한다
- 관련 Tech Spec 섹션: 9.6 테스트 커버리지 목표
- 작업 내용:
  - Xcode Test 실행 (Cmd+U)
  - 코드 커버리지 리포트 생성
  - 커버리지 목표 달성 확인:
    - Domain Layer: 90%+
    - Data Layer: 80%+
    - Presentation Layer: 70%+
    - 전체: 75%+
  - 미달 시 추가 테스트 작성
- Definition of Done:
  - ✅ 모든 테스트 통과
  - ✅ 커버리지 목표 달성
  - ✅ 실패하는 테스트 0개
- Test:
  - Xcode > Product > Test
  - Coverage Report 확인
- 참고 문서:
  - tech_spec.md#96-테스트-커버리지-목표
- **참고**: TDD 방식으로 개발했으므로 대부분의 테스트는 이미 작성되어 있음

---

## 10. MVP 완료 및 다음 단계

### T-090 — MVP 체크리스트 검증
- 상태: [ ] TODO
- 목적: MVP 요구사항 모두 충족했는지 확인한다
- 관련 Tech Spec 섹션: 3.1 Scope
- 작업 내용:
  - P0 기능 모두 동작 확인
  - P1 기능 모두 동작 확인
  - P2 기능 확인 (선택)
  - 버그 없음 확인
  - 성능 기준 충족 확인
- Definition of Done:
  - MVP 기능 100% 완료
  - 치명적 버그 0개
  - 성능 기준 충족
- Test:
  - 전체 시나리오 Manual Test
  - iPad 실기기 테스트
- 참고 문서:
  - tech_spec.md#11-mvp-기능-우선순위

---

### T-091 — error_logs.md 정리
- 상태: [ ] TODO
- 목적: 개발 중 발생한 이슈를 정리한다
- 관련 Tech Spec 섹션: 전체
- 작업 내용:
  - 발생한 에러/이슈 기록
  - 해결 방법 정리
  - Tech Spec/TODO 반영 사항 정리
  - 교훈 정리
- Definition of Done:
  - error_logs.md 작성 완료
  - 주요 이슈 모두 기록
  - 다음 프로젝트에 활용 가능
- Test:
  - 문서 가독성 확인
- 참고 문서:
  - howToMakeTechSpecAndTODO.md#7-실패에러를-기록하는-방법

---

### T-092 — v1.1 계획 수립
- 상태: [ ] TODO
- 목적: 다음 버전 계획을 수립한다
- 관련 Tech Spec 섹션: 3.2 Non-Scope
- 작업 내용:
  - v1.1 기능 목록 정리
  - 우선순위 설정
  - tech_spec.md 업데이트
  - todo.md 업데이트
- Definition of Done:
  - v1.1 문서 작성 완료
  - 우선순위 명확
- Test:
  - 문서 검토
- 참고 문서:
  - tech_spec.md#32-non-scope-v10에서-제외

---

## 상태 요약

### 완료 (DONE)
- T-001: 프로젝트 문서 작성 (부분 완료)

### 진행 중 (DOING)
- 없음

### 대기 (TODO)
- T-002 ~ T-092 (90개 작업)

---

**문서 버전**: 0.2.0 (TDD 적용)
**최종 수정일**: 2025-12-24
**주요 변경사항**: TDD (Test-Driven Development) 방식 적용, Red-Green-Refactor 사이클 명시
**다음 업데이트**: 개발 시작 후
