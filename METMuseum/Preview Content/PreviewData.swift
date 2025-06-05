import SwiftUI
import CoreImage.CIFilterBuiltins

extension ArtObjectModel {
    static let testData = ArtObjectModel(
        id: 41209,
        title: "Snuff bottle with eagle and bear",
        artistName: "Vincent van Gogh",
        objectDate: "1889",
        image: URL(string: "https://images.metmuseum.org/CRDImages/as/original/DP319168.jpg"),
        imageSmall: URL(string: "https://images.metmuseum.org/CRDImages/as/original/DP319168.jpg")
    )
}

extension MembershipModel {
     static func testData() -> MembershipModel {
       let model = MembershipModel(
        firstName: "Steve Jobs",
        email: "steve.jobs@gmail.com",
        membershipType: MembershipType.personal.rawValue)
         let qrCIImage = qrCode(inputMessage: model.fullData)
         if let qrData = ciImageToPNGData(qrCIImage) {
             model.qrImageData = qrData
         }
        
        return model
    }
    
    static private func ciImageToPNGData(_ ciImage: CIImage) -> Data? {
        let context = CIContext()
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            return uiImage.pngData()
        }
        return nil
    }

    static private func qrCode(inputMessage: String) -> CIImage {
        let qrCodeGenerator = CIFilter.qrCodeGenerator()
        qrCodeGenerator.message = inputMessage.data(using: .ascii)!
        qrCodeGenerator.correctionLevel = "M"
        return qrCodeGenerator.outputImage!
    }
    
}
