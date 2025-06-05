import CoreImage.CIFilterBuiltins
import SwiftUI

struct CardView: View {
    let model: MembershipModel

    var body: some View {
        //        HStack {
        //            VStack(alignment: .leading) {
        //                Text(model.firstName)
        //                    .font(.headline)
        //
        //                Text(model.email)
        //                    .font(.footnote)
        //                    .foregroundStyle(.secondary)
        //
        //                Text(model.membershipType)
        //                    .font(.caption)
        //                    .foregroundStyle(.secondary)
        //            }
        //            .frame(maxWidth: .infinity, alignment: .leading)
        //
        //            if let data = model.qrImageData, let uiImage = UIImage(data: data) {
        //                Image(uiImage: uiImage)
        //                    .interpolation(.none)
        //                    .resizable()
        //                    .scaledToFit()
        //                    .frame(height: 80)
        //                    .padding()
        //            }
        //        }
        VStack {
            HStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)

                Spacer()

                VStack(alignment: .trailing) {
                    Text("CATEGORY")
                        .font(.caption)
                        .foregroundStyle(.orange)

                    Text(model.membershipType)
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text("MET NUMBER")
                        .font(.caption)
                        .foregroundStyle(.orange)

                    Text(model.metNumber)
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }

            HStack {
                VStack(alignment: .leading) {
                    Text(model.firstName)
                        .font(.title)
                        .foregroundStyle(.white)

                    Text(model.email)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()

                if let data = model.qrImageData,
                    let uiImage = UIImage(data: data)
                {
                    Image(uiImage: uiImage)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                }

            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    .linearGradient(
                        colors: [
                            Color.accentColor, Color.accentColor.opacity(0.7),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
}

#Preview {
    CardView(model: MembershipModel.testData())

}
