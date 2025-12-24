# FlowyDay 프로젝트 개요

## 메타 정보
- **프로젝트 이름**: FlowyDay
- **버전**: MVP v1.0
- **작성일**: 2025-12-24
- **작성자**: 방현석
- **타겟 플랫폼**: iPad (iOS 16.0+)
- **개발 목적**:
  - 개인 사용 (일일 플래너)
  - 포트폴리오 (SwiftUI, MVI 학습)
  - NextCreapps "하루 $1 버는 앱" 시리즈 첫 작품

## 문서 네비게이션

### 규칙 문서
- [howToMakeTechSpecAndTODO.md](./howToMakeTechSpecAndTODO.md) - 문서 작성 규칙 (전역)

### 기획 문서
- [requirements.md](./requirements.md) - 요구사항 정의
- [architecture.md](./architecture.md) - 아키텍처 설계
- [data_flow.md](./data_flow.md) - 데이터 흐름
- [ui_design.md](./ui_design.md) - UI/UX 설계

### 개발 문서
- [tech_spec.md](./tech_spec.md) - 기술 명세
- [todo.md](./todo.md) - 작업 계획
- [error_logs.md](./error_logs.md) - 에러/실패 기록

### 외부 참고
- [DA-008_FlowyDay.md](icloud://DA-008_FlowyDay.md) - 원본 기획서

## 프로젝트 개요

### 핵심 가치 제안
FlowyDay는 Plan-Do-See 워크플로우를 디지털에 최적화한 iPad 일일 플래너입니다.

**3가지 핵심 특징:**
1. **Plan**: 계획하기 (과거 항목 재사용, 여러 스타일 혼용)
2. **Do**: 실행하기 (타이머 통합, 전체 맥락 유지)
3. **See**: 돌아보기 (자동 요약, 데이터 분석)

### 문제 정의
- **현재 상황**: 5년간 PDS 다이어리 사용 (종이)
- **한계점**:
  - 검색 불가, 과거 기록 찾기 어려움
  - 데이터 분석 불가
  - 휴대 불편, 보관 곤란
- **디지털 플래너의 한계**:
  - Notion: 너무 복잡
  - Todoist: Plan-See 분리 안 됨
  - 포모도로 앱: 전체 맥락 상실

### 해결책
**PDS의 장점 유지 + 디지털 강점 추가**
- 과거 항목 재사용 (루틴 관리)
- 타이머 통합 (포모도로)
- 데이터 분석 (통계, 패턴)
- 스타일 혼용 (시간대별/불릿/블럭)

## 타겟 사용자
- **주 타겟**: PDS 다이어리 경험자 (디지털 전환 희망)
- **부 타겟**: iPad 활용 직장인/학생, 개발자

## 개발 목표

### 기간 및 마일스톤
- **MVP 개발**: 4주
- **출시 목표**: 2026년 1월
- **확장 계획**:
  1. iPad (MVP)
  2. iPhone 연동
  3. macOS 앱
  4. 웹사이트

### 수익 목표
- **최소 목표**: 하루 $1 (월 $30)
- **출시 3개월**: 하루 $3-5 (월 $90-150)
- **출시 6개월**: 하루 $10+ (월 $300+)

### 학습 목표
- SwiftUI 심화 학습
- MVI 아키텍처 구현
- Clean Architecture 적용
- Core Data, CloudKit 실전 경험
- StoreKit (IAP) 구현

## 기술 스택

### 플랫폼
- **iOS 16.0+** (iPad 전용)
- iPadOS 최적화

### 아키텍처
- **MVI (Model-View-Intent)** 패턴
- Clean Architecture
- Repository Pattern

### 주요 기술
- SwiftUI
- Core Data (로컬 저장)
- CloudKit (iCloud 동기화)
- UserNotifications (타이머)
- StoreKit (IAP)
- AdMob (광고)

## 프로젝트 단계

### Phase 1: MVP (4주)
- Plan-Do-See 기본 기능
- 로컬 저장
- 기본 타이머
- iPad UI 최적화

### Phase 2: 출시 준비 (1주)
- 수익화 (AdMob, IAP)
- iCloud 동기화
- 앱스토어 제출

### Phase 3: 확장 (2026 H1)
- iPhone 앱
- macOS 앱
- 웹사이트

## 문서 읽는 순서 (AI용)

1. **howToMakeTechSpecAndTODO.md** - 문서 규칙 이해
2. **overview.md** (현재 문서) - 프로젝트 맥락 파악
3. **requirements.md** - 요구사항 확인
4. **architecture.md** - 시스템 구조 이해
5. **tech_spec.md** - 기술 명세 확인
6. **todo.md** - 작업 계획 확인
7. **필요시**: data_flow.md, ui_design.md, error_logs.md

## 프로젝트 상태

### 현재 진행 상황
- [x] 기획서 작성 완료 (DA-008_FlowyDay.md)
- [x] 프로토타입 개발 (FlowyDay2 - MVVM 기반)
- [ ] 문서화 진행 중
- [ ] 정식 프로젝트 생성 예정

### 다음 단계
1. 문서화 완료 (Tech Spec, TODO)
2. 새 프로젝트 생성 (MVI 기반)
3. MVP 개발 시작

## 참고사항

### 법적 고려사항
- Plan-Do-See는 일반 방법론 (PDCA, OODA 계열)
- 저작권 보호 대상 아님
- PDS 오로다의 속지 디자인은 복사하지 않음

### NextCreapps 전략
- "하루 $1 버는 앱" 시리즈
- 10개 앱 × $1 = 월 $300 목표
- FlowyDay가 첫 번째 앱

---

**문서 버전**: 1.0.0
**최종 수정일**: 2025-12-24
