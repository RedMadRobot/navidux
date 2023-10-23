//
//  PayloadStub.swift
//
//
//  Created by Stanislav Anatskii on 09.10.2023.
//

@testable import Navidux

struct PayloadStub {
    let value: Int

    init(value: Int) {
        self.value = value
    }
}

extension PayloadStub: Payload {
    var data: some Hashable {
        self
    }
}
