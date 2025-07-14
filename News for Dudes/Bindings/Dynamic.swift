//
//  Dynamic.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation

class Dynamic<T>{
    typealias Listener = (T) -> Void
    private var listener:Listener?
    
    func bind(_ listener: Listener? ){
        self.listener = listener
    }
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    init( value: T) {
        self.value = value
    }
}

