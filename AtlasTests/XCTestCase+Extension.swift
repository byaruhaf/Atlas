//
//  XCTestCase+Extension .swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 06/02/2023.
//

import XCTest

// swiftlint:disable force_try
extension XCTestCase {
    
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
}
