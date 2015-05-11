//
//  ReWheelyTests.swift
//  ReWheelyTests
//
//  Created by Arsen Gasparyan on 11/05/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit
import Quick
import Nimble


class CarSpec: QuickSpec {
    override func spec() {
        describe("the 'Documentation' directory") {
            it("has everything you need to get started") {
                expect(1 + 1).to(equal(2))
            }
            
            context("if it doesn't have what you're looking for") {
                it("needs to be updated") {
                    expect(1 + 1).to(equal(2))
                }
            }
        }
    }
}