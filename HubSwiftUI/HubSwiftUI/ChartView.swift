struct ChartView: View {
  var body: some View {
    VStack {
      Rectangle()
        .frame(width: .infinity, height: 1)
        .foregroundColor(.line)

      Rectangle()
        .frame(width: .infinity, height: 1)
        .foregroundColor(.line)

      Rectangle()
        .frame(width: .infinity, height: 1)
        .foregroundColor(.line)
      
      HStack {
        Spacer()
        Text("X 0.12345")
          .font(.caption2)
          .foregroundColor(.mainRed)

        Text("Y 0.12345")
          .font(.caption2)
          .foregroundColor(.mainBlue)

        Text("Z 0.12345")
          .font(.caption2)
          .foregroundColor(.green)
      }
    }
  }
}
