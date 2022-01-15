//
//  LinkedList.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//  Pulled from https://github.com/SergeyKuryanov/Swift-Data-Structures-and-Algorithms/tree/master/Linked%20List
//

import Foundation

class DoubleLinkedList<T> {
    typealias ListNode = Node<T>

    class Node<T> {
        var next: Node<T>?
        var prev: Node<T>?
        let value: T

        init(_ value: T) {
            self.value = value
        }

        public var description: String {
            return String(describing: value)
        }
    }

    var head: ListNode?
    var tail: ListNode?

    func isEmpty() -> Bool {
        return head == nil
    }

    func appendHead(_ value: T) {
        let newNode = ListNode(value)
        head?.prev = newNode
        newNode.next = head
        head = newNode

        if tail == nil {
            tail = head
        }
    }

    func appendTail(_ value: T) {

        let newNode = ListNode(value)
        tail?.next = newNode
        newNode.prev = tail
        tail = newNode

        if head == nil {
            head = tail
        }
    }

    func removeHead() -> ListNode? {
        if head == nil && tail != nil {
            return removeTail()
        }

        let headNode = head
        head = head?.next
        head?.prev = nil

        return headNode
    }

    func removeTail() -> ListNode? {
        if tail == nil && head != nil {
            return removeHead()
        }

        let tailNode = tail
        tail = tailNode?.prev
        tail?.next = nil

        if tail == nil {
            head?.next = nil
        }

        return tailNode
    }

    func remove(at index: Int) -> ListNode? {
        guard index > 0 else {
            return removeHead()
        }

        var node = head

        for _ in 0..<index {
            node = node?.next
        }

        node?.prev?.next = node?.next
        node?.next?.prev = node?.prev

        return node
    }

    func removeAfter(_ node: ListNode) -> ListNode? {
        defer {
            node.next = node.next?.next
            node.next?.prev = node
        }

        return node.next
    }

    func insert(_ node: ListNode?, after anotherNode: ListNode?) {
        guard let node = node, let anotherNode = anotherNode else { return }
        node.next = anotherNode.next
        node.prev = anotherNode

        anotherNode.next = node
        node.next?.prev = node
    }
}

extension DoubleLinkedList: Sequence {
    struct ListItetator: IteratorProtocol {
        private var current: ListNode?

        init(current: ListNode?) {
            self.current = current
        }

        mutating func next() -> ListNode? {
            defer {
                current = current?.next
            }

            return current
        }
    }

    func makeIterator() -> ListItetator {
        return ListItetator(current: head)
    }
}
