//
//  TestBaseTableView.swift
//  CoreUIKitTests
//
//  Created by Manish on 19/09/21.
//

@testable import CoreUIKit
import XCTest

class TestBaseTableView: XCTestCase {
    
    private var sut: BaseTableView!
    
    override func setUp() {
        super.setUp()
        
        self.sut = BaseTableView()
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.sut = nil
    }
    
}

// MARK: - Initial test
extension TestBaseTableView {
    
    func test_BaseTableView_default_init_success() {
        XCTAssertFalse(self.sut.bounces)
        XCTAssertEqual(self.sut.separatorStyle, .none)
    }
    
}

// MARK: - Register cells
extension TestBaseTableView {
    
    func test_BaseTableView_cellRegistration_success() {
        // Register a new cell
        self.sut.register(UITableViewCell.self)
        
        // Dequeu registered cell
        let _dequeuedCell = self.sut.dequeue(UITableViewCell.self)
        
        XCTAssertNotNil(_dequeuedCell)
    }
    
}

// MARK: - Dequeue cells
extension TestBaseTableView {
    
    func test_BaseTableView_cellDequeue_success() {
        // Register a new cell
        self.sut.register(UITableViewCell.self)
        
        // Dequeu registered cell
        let _dequeuedCell = self.sut.dequeue(UITableViewCell.self)
        
        XCTAssertNotNil(_dequeuedCell)
        XCTAssertTrue(_dequeuedCell!.isKind(of: UITableViewCell.self))
    }
    
    func test_BaseTableView_cellDequeue_failed() {
        // Don't register cell
        
        // Dequeu cell
        let _dequeuedCell = self.sut.dequeue(UITableViewCell.self)
        
        XCTAssertNil(_dequeuedCell)
        XCTAssertFalse(_dequeuedCell?.isKind(of: UITableViewCell.self) ?? false)
    }
    
}
