import CoreImage.CIFilterBuiltins
import Foundation
import Observation
import SwiftData
import UIKit

@Observable
final class MembershipViewModel {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    var firstName: String = ""
    var email: String = ""
    var selectedMembershipType: MembershipType = .personal
    var image: CIImage?
    var isAlertPresented = false
    var errorMessage = ""
    var membershipModel : MembershipModel?

    func validateIsEmpty(value: String) -> LocalizedStringResource? {
        return if value.isEmpty {
            "Cannot be empty"
        } else {
            nil
        }
    }

    func validateEmail(value: String) -> LocalizedStringResource? {
        let emailRegex =
            #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#

        do {
            let regex = try Regex(emailRegex)
            if (try regex.wholeMatch(in: value)) != nil {
                return nil
            } else {
                return "Is not a valid email."
            }
        } catch {
            return "Is not a valid email."
        }
    }

    func validate() -> Bool {
        var message = ""

        if let error = validateIsEmpty(value: firstName) {
            message +=
                "\(String(localized: "- First Name")): \(String(localized: error))\n"
        }

        if let error = validateEmail(value: email) {
            message +=
                "\(String(localized: "- Email")): \(String(localized: error))\n"
        }

        if !message.isEmpty {
            errorMessage = message
            isAlertPresented = true
            return false
        } else {
           return saveMembership()
        }
    }

    func saveMembership() -> Bool {
        let membershipModel = MembershipModel(
            firstName: firstName,
            email: email,
            membershipType: selectedMembershipType.rawValue
        )

        let qrCIImage = qrCode(inputMessage: membershipModel.fullData)
        if let qrData = ciImageToPNGData(qrCIImage) {
            membershipModel.qrImageData = qrData
        }
        
        do {
            modelContext.insert(membershipModel)
            try modelContext.save()
            return true
        } catch {            
            print("Error saving membership: \(error)")
            return false
        }
       
    }

    func ciImageToPNGData(_ ciImage: CIImage) -> Data? {
        let context = CIContext()
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            return uiImage.pngData()
        }
        return nil
    }

    func qrCode(inputMessage: String) -> CIImage {
        let qrCodeGenerator = CIFilter.qrCodeGenerator()
        qrCodeGenerator.message = inputMessage.data(using: .ascii)!
        qrCodeGenerator.correctionLevel = "M"
        return qrCodeGenerator.outputImage!
    }

}
