//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// The conforming type supports canceling an in-process operation. The exact semantics of "canceling" are not defined
/// in the protocol. Specifically, there is no guarantee that a `cancel` results in immediate cessation of activity.
public protocol Cancellable {
    func cancel()
}
