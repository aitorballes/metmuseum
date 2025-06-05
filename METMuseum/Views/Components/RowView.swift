import SwiftUI

struct RowView: View {
    let artObject: ArtObjectModel
    
    var body: some View {
        VStack (spacing: 10) {
            HStack(alignment: .center) {
                CachedImageView(imageUrl: artObject.image, size: 100)
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(artObject.title)
                        .font(.headline)
                        .lineLimit(2)
                    
                    Text("Artist: \(artObject.artistName.isEmpty ? "Unknown" : artObject.artistName)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                
            }
            
            Divider()
        }
    }
}

#Preview {
    RowView(artObject: ArtObjectModel.testData)
}
