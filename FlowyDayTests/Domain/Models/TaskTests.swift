//
//  TaskTests.swift
//  FlowyDayTests
//
//  Created by TDD on 2025-12-30.
//

import XCTest
@testable import FlowyDay

/// Task 도메인 모델 테스트
/// TDD Red-Green-Refactor 사이클로 작성
final class TaskTests: XCTestCase {

    // MARK: - Test: Codable (JSON 인코딩/디코딩)

    func testTaskCodable() throws {
        // Given: Task 인스턴스 생성
        let task = Task(
            id: "test-id-123",
            text: "SwiftUI 학습하기",
            category: "학습",
            scheduledTime: "14:30",
            estimatedMinutes: 60,
            status: .notStarted,
            actualMinutes: nil,
            createdDate: Date(),
            qualityRating: nil,
            satisfactionNote: nil
        )

        // When: JSON으로 인코딩
        let encoder = JSONEncoder()
        let data = try encoder.encode(task)

        // Then: 다시 디코딩했을 때 같은 값
        let decoder = JSONDecoder()
        let decodedTask = try decoder.decode(Task.self, from: data)

        XCTAssertEqual(decodedTask.id, task.id)
        XCTAssertEqual(decodedTask.text, task.text)
        XCTAssertEqual(decodedTask.category, task.category)
        XCTAssertEqual(decodedTask.status, task.status)
    }

    // MARK: - Test: isActive 계산 속성

    func testTaskIsActive_WhenNotStarted_ReturnsTrue() {
        // Given: 미시작 상태의 Task
        let task = Task(
            id: "1",
            text: "작업",
            category: nil,
            scheduledTime: nil,
            estimatedMinutes: nil,
            status: .notStarted,
            actualMinutes: nil,
            createdDate: Date(),
            qualityRating: nil,
            satisfactionNote: nil
        )

        // Then: isActive는 true
        XCTAssertTrue(task.isActive)
    }

    func testTaskIsActive_WhenInProgress_ReturnsTrue() {
        // Given: 진행중 상태의 Task
        var task = Task(
            id: "1",
            text: "작업",
            category: nil,
            scheduledTime: nil,
            estimatedMinutes: nil,
            status: .notStarted,
            actualMinutes: nil,
            createdDate: Date(),
            qualityRating: nil,
            satisfactionNote: nil
        )
        task.status = .inProgress

        // Then: isActive는 true
        XCTAssertTrue(task.isActive)
    }

    func testTaskIsActive_WhenCompleted_ReturnsFalse() {
        // Given: 완료 상태의 Task
        var task = Task(
            id: "1",
            text: "작업",
            category: nil,
            scheduledTime: nil,
            estimatedMinutes: nil,
            status: .completed,
            actualMinutes: nil,
            createdDate: Date(),
            qualityRating: nil,
            satisfactionNote: nil
        )

        // Then: isActive는 false (완료됨)
        XCTAssertFalse(task.isActive)
    }

    func testTaskIsActive_WhenCancelled_ReturnsFalse() {
        // Given: 취소 상태의 Task
        var task = Task(
            id: "1",
            text: "작업",
            category: nil,
            scheduledTime: nil,
            estimatedMinutes: nil,
            status: .cancelled,
            actualMinutes: nil,
            createdDate: Date(),
            qualityRating: nil,
            satisfactionNote: nil
        )

        // Then: isActive는 false (취소됨)
        XCTAssertFalse(task.isActive)
    }

    // MARK: - Test: isCompleted 계산 속성

    func testTaskIsCompleted_WhenCompleted_ReturnsTrue() {
        // Given: 완료 상태의 Task
        var task = Task(
            id: "1",
            text: "작업",
            category: nil,
            scheduledTime: nil,
            estimatedMinutes: nil,
            status: .completed,
            actualMinutes: nil,
            createdDate: Date(),
            qualityRating: nil,
            satisfactionNote: nil
        )

        // Then: isCompleted는 true
        XCTAssertTrue(task.isCompleted)
    }

    func testTaskIsCompleted_WhenNotCompleted_ReturnsFalse() {
        // Given: 미완료 상태의 Task
        let task = Task(
            id: "1",
            text: "작업",
            category: nil,
            scheduledTime: nil,
            estimatedMinutes: nil,
            status: .notStarted,
            actualMinutes: nil,
            createdDate: Date(),
            qualityRating: nil,
            satisfactionNote: nil
        )

        // Then: isCompleted는 false
        XCTAssertFalse(task.isCompleted)
    }

    // MARK: - Test: 기본값 확인

    func testTaskInitialization_WithOptionalFields() {
        // Given & When: 선택적 필드 없이 Task 생성
        let task = Task(
            id: "1",
            text: "필수 필드만",
            category: nil,
            scheduledTime: nil,
            estimatedMinutes: nil,
            status: .notStarted,
            actualMinutes: nil,
            createdDate: Date(),
            qualityRating: nil,
            satisfactionNote: nil
        )

        // Then: 선택적 필드는 nil
        XCTAssertNil(task.category)
        XCTAssertNil(task.scheduledTime)
        XCTAssertNil(task.estimatedMinutes)
        XCTAssertNil(task.actualMinutes)
        XCTAssertNil(task.qualityRating)
        XCTAssertNil(task.satisfactionNote)
    }
}
