struct TitleView: View {
  @State var driveInfoTextColor: Color = .mainBlue
  @State var gSensorTextColor: Color = .iconDark
  
  var body: some View {
    HStack(spacing: 5) {
      Text("Drive Info")
        .font(.subheadline)
        .fontWeight(.bold)
        .foregroundColor(driveInfoTextColor)
        .onTapGesture {
          driveInfoTextColor = .mainBlue
          gSensorTextColor = .iconDark
        }
      
      // vertical line
      Rectangle()
        .frame(width: 1, height: 12)
        .foregroundColor(.iconDark)
      
      Text("G-Sensor")
        .font(.subheadline)
        .fontWeight(.bold)
        .foregroundColor(gSensorTextColor)
        .onTapGesture {
          print("G-Sensor tapped")
          driveInfoTextColor = .iconDark
          gSensorTextColor = .mainBlue
        }
      
      Spacer()
      // X mark sfsymbol
      Image(systemName: "xmark.circle.fill")
        .foregroundColor(.iconDark)
    }
  }
}
