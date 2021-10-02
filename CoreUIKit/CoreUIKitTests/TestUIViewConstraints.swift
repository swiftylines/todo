//
//  TestUIViewConstraints.swift
//  CoreUIKitTests
//
//  Created by Manish on 19/09/21.
//

@testable import CoreUIKit
import XCTest

class TestUIViewConstraints: XCTestCase {
    
    private var sut: UIView!
    private var testVC: UIViewController!
    
    override func setUp() {
        super.setUp()
        
        self.sut = UIView()
        self.testVC = UIViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.sut = nil
        self.testVC = nil
    }
    
}

extension TestUIViewConstraints {
    
    func test_UIView_addInVCView_success() {
        
        self.sut
            .add(to: self.testVC.view)
            
        self.testVC.loadViewIfNeeded()
        
        XCTAssertTrue(self.sut.isDescendant(of: self.testVC.view))
        
    }
    
    func test_UIView_addInVCView_WithSameSize_success() {
        
        self.sut
            .add(to: self.testVC.view)
            .allAnchorsSame(on: self.testVC.view)
        
        self.testVC.view.layoutIfNeeded()
        
        XCTAssertTrue(self.sut.isDescendant(of: self.testVC.view))
        XCTAssertEqual(self.sut.bounds, self.testVC.view.bounds)
    }
    
    func test_UIView_addInVCView_FixedWidthAndHeight_success() {
        
        let fixedSize: CGFloat = 200
        
        self.sut
            .add(to: self.testVC.view)
            .top(with: self.testVC.view.topAnchor)
            .leading(with: self.testVC.view.leadingAnchor)
            .with(width: fixedSize, height: fixedSize)
        
        self.testVC.view.layoutIfNeeded()
        
        XCTAssertTrue(self.sut.isDescendant(of: self.testVC.view))
        XCTAssertEqual(self.sut.bounds.width, fixedSize)
        XCTAssertEqual(self.sut.bounds.height, fixedSize)
    }
    
}
