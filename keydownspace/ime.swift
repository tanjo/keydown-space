//
//  ime.swift
//  keydownspace
//

import Foundation

// MARK: - no pid

func keyboardDown(key: CGKeyCode) {
    let source = CGEventSource(stateID: .hidSystemState)
    let event = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: true)
    event?.post(tap: .cghidEventTap)
    print("key \(key) is down")
}

func keyboardUp(key: CGKeyCode) {
    let source = CGEventSource(stateID: .hidSystemState)
    let event = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: false)
    event?.post(tap: .cghidEventTap)
    print("key \(key) is up")
}

func clickSpace() {
    keyboardDown(key: 0x31)
    keyboardUp(key: 0x31)
}

func loopClickSpace(count: Int) {
    print("count: \(count)")
    clickSpace()
    Thread.sleep(forTimeInterval: 10)
    loopClickSpace(count: count+1)
}

// MARK: - pid

func keyboardDown(key: CGKeyCode, pid: pid_t) {
    let event = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: true)
    event?.postToPid(pid)
    print("key \(key) is down")
}

func keyboardUp(key: CGKeyCode, pid: pid_t) {
    let event = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: false)
    event?.postToPid(pid)
    print("key \(key) is up")
}

func clickSpace(pid: pid_t) {
    keyboardDown(key: 0x31, pid: pid)
    keyboardUp(key: 0x31, pid: pid)
}

func loopClickSpace(pid: pid_t) {
    clickSpace(pid: pid)
    Thread.sleep(forTimeInterval: 10)
    loopClickSpace(pid: pid)
}
