//
//  ViewModel.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import Foundation
import Combine

protocol ViewModel<State, Action, Destination>: AnyObject {
    associatedtype State: StateProtocol
    associatedtype Action
    associatedtype Destination

    var state: State { get }
    var destinationPublisher: AnyPublisher<Destination, Never> { get }
    var statePublisher: AnyPublisher<State, Never> { get }

    func handle(action: Action)
}
