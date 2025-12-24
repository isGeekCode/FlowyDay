# FlowyDay

> **Plan-Do-See 워크플로우를 디지털에 최적화한 iPad 일일 플래너**

[![Platform](https://img.shields.io/badge/Platform-iPadOS%2016.0%2B-blue.svg)](https://www.apple.com/ipados/)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS%2016.0%2B-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

## 프로젝트 개요

FlowyDay는 5년간 사용한 PDS 다이어리의 검증된 워크플로우를 디지털로 진화시킨 앱입니다.

### 핵심 가치
- **Plan**: 할 일을 계획하고, 과거 항목을 재사용하며, 예상 시간을 설정
- **Do**: 타이머로 실행하고, 전체 일정 맥락을 유지하며, 실제 소요 시간을 기록
- **See**: 완료 항목을 확인하고, 통계를 분석하며, 회고를 작성

### 개발 목적
- 개인 사용 (일일 플래너)
- 포트폴리오 (SwiftUI + MVI 학습)
- NextCreapps "하루 $1 버는 앱" 시리즈 첫 작품

## 주요 기능 (MVP v1.0)

### Plan - 계획하기
- ✅ 작업 추가/수정/삭제
- ✅ 카테고리 지정 (학습/건강/업무/취미/기타)
- ✅ 예상 시간 설정
- ✅ 작업 상태 관리 (미시작/진행중/연기/취소/완료)
- ✅ 날짜별 작업 관리

### Do - 실행하기
- ✅ 시간대별 그리드 (3:00-23:00, 10분 단위)
- ✅ 작업을 시간대에 할당
- ✅ 작업 번호 표시 (①②③... ⒶⒷⒸ...)
- ✅ 카테고리별 색상 표시
- ✅ 현재 시간 표시 (빨간 선)
- ✅ Undo/Redo 기능
- ✅ 날짜 네비게이션

### See - 돌아보기
- ✅ 완료/미완료 항목 표시
- ✅ 카테고리별 시간 통계
- ✅ 작업별 평가 (별점 1-5)
- ✅ 전체 회고 작성

## 기술 스택

### 아키텍처
- **MVI (Model-View-Intent)** 패턴
- **Clean Architecture**
- Repository Pattern

### 주요 기술
- SwiftUI (UI 프레임워크)
- Combine (반응형 프로그래밍)
- UserDefaults (로컬 저장)
- Core Data (v1.1+)
- CloudKit (v1.1+)

### 학습 목표
- SwiftUI + MVI 아키텍처 실전 경험
- Clean Architecture 적용
- Core Data, CloudKit 실전 사용
- StoreKit IAP 구현

## 프로젝트 구조

```
FlowyDay/
├── docs/                           # 프로젝트 문서
│   ├── overview.md                 # 전체 개요
│   ├── tech_spec.md                # 기술 명세
│   ├── todo.md                     # 작업 계획
│   ├── error_logs.md               # 에러 기록
│   └── howToMakeTechSpecAndTODO.md # 문서 작성 규칙
│
├── FlowyDay/                       # 소스 코드 (TBD)
│   ├── App/                        # 앱 진입점
│   ├── Presentation/               # UI 계층
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Components/
│   ├── Domain/                     # 도메인 계층
│   │   ├── Models/
│   │   ├── UseCases/
│   │   └── Repositories/
│   └── Data/                       # 데이터 계층
│       ├── Repositories/
│       └── DataSources/
│
└── README.md                       # 현재 파일
```

## 시작하기

### 요구사항
- Xcode 15.0+
- iOS 16.0+
- iPad

### 빌드 방법
```bash
# 프로젝트 클론 (TBD)
git clone https://github.com/yourusername/FlowyDay.git

# Xcode에서 열기
cd FlowyDay
open FlowyDay.xcodeproj

# iPad 시뮬레이터에서 실행
# Xcode: Product > Run (Cmd+R)
```

## 개발 로드맵

### MVP (4주) - 진행 중
- [ ] Week 1-2: Core System
  - [ ] Plan 탭 (CRUD, 상태 관리)
  - [ ] Do 탭 (시간 그리드, 작업 할당)
  - [ ] See 탭 (통계, 회고)
  - [ ] 로컬 저장/로드
- [ ] Week 3: 기능 완성
  - [ ] Undo/Redo
  - [ ] 날짜 네비게이션
  - [ ] UI 폴리싱
- [ ] Week 4: 테스트 & 문서
  - [ ] Unit Test
  - [ ] UI Test
  - [ ] 문서화

### v1.1 (출시 준비)
- [ ] 타이머 기능
- [ ] iCloud 동기화
- [ ] AdMob 광고
- [ ] IAP (Pro/Premium)
- [ ] 앱스토어 제출

### v2.0+ (확장)
- [ ] iPhone 앱
- [ ] macOS 앱
- [ ] 웹사이트

## 문서

### 개발 문서
- [Overview](docs/overview.md) - 프로젝트 전체 개요
- [Tech Spec](docs/tech_spec.md) - 기술 명세서
- [TODO](docs/todo.md) - 작업 계획 및 진행 상황
- [Error Logs](docs/error_logs.md) - 에러 및 이슈 기록

### 규칙 문서
- [howToMakeTechSpecAndTODO](docs/howToMakeTechSpecAndTODO.md) - 문서 작성 규칙

### 기획 문서
- [DA-008_FlowyDay](https://icloud) - 원본 기획서 (Private)

## 라이선스

MIT License

## 작성자

**방현석** - NextCreapps
- Portfolio: TBD
- Blog: TBD
- Email: TBD

## 감사의 말

- PDS 다이어리 (오로다) - 워크플로우 영감
- SwiftUI Community
- Clean Architecture Community

---

**"Plan, Do, See - 디지털로 진화하다"**
**"하루 $1 버는 앱" 시리즈**

---

_현재 상태: 문서화 완료, MVP 개발 준비 중_
_최종 업데이트: 2025-12-24_
