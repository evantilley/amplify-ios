//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Amplify

public class AWSAuthForgetDeviceOperation: AmplifyOperation<
    AuthForgetDeviceRequest,
    Void,
    AuthError
>, AuthForgetDeviceOperation {

    let deviceService: AuthDeviceServiceBehavior

    init(_ request: AuthForgetDeviceRequest,
         deviceService: AuthDeviceServiceBehavior,
         resultListener: ResultListener?) {

        self.deviceService = deviceService
        super.init(categoryType: .auth,
                   eventName: HubPayload.EventName.Auth.forgetDeviceAPI,
                   request: request,
                   resultListener: resultListener)
    }

    override public func main() {
        if isCancelled {
            finish()
            return
        }
        deviceService.forgetDevice(request: request) { [weak self] result in
            guard let self = self else { return }

            defer {
                self.finish()
            }

            if self.isCancelled {
                return
            }

            switch result {
            case .failure(let error):
                self.dispatch(error)
            case .success:
                self.dispatchSuccess()
            }
        }
    }

    private func dispatchSuccess() {
        let result = OperationResult.success(())
        dispatch(result: result)
    }

    private func dispatch(_ error: AuthError) {
        let result = OperationResult.failure(error)
        dispatch(result: result)
    }
}
