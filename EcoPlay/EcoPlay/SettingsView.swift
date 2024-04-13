import SwiftUI
import MediaPlayer

struct SettingsView: View {
    @Binding var isActive: Bool
    @State private var volume: Double = Double(AVAudioSession.sharedInstance().outputVolume)
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)){
            VStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            isActive.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.darkGreen)
                    }
                }
                Spacer()
                HStack(alignment: .center) {
                    Text("Volume").font(Font.custom("Play-bold", size: 14))
                        .foregroundStyle(Color.darkGreen)
                    CustomUISlider(
                        value: $volume,
                        minValue: 0.0,
                        maxValue: 1.0,
                        thumbColor: UIColor.backgroundGreen,
                        minTrackColor: UIColor(Color(red: 81/255, green: 139/255, blue: 84/255)),
                        maxTrackColor: UIColor(Color(red: 27/255, green: 51/255, blue: 28/255))
                    )
                }
                .padding(.bottom, 20)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(Color(red: 219/255, green: 225/255, blue: 169/255))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color(red: 27/255, green: 51/255, blue: 28/255), radius: 0, x: 0, y: 8)
            .padding(50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.35))
        .onChange(of: volume) {
            VolumeSlider.setVolume(volume)
        }
    }
}

struct CustomUISlider: UIViewRepresentable {
    @Binding var value: Double
    
    var minValue = 1.0
    var maxValue = 100.0
    var thumbColor: UIColor = .white
    var minTrackColor: UIColor = .blue
    var maxTrackColor: UIColor = .lightGray
    
    let slider = UISlider(frame: .zero)
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    func makeCoordinator() -> CustomUISlider.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}

struct VolumeSlider: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeUIView(context: Context) -> some UIView {
        MPVolumeView()
    }
    
    static func setVolume(_ volume: Double) {
        let volumeView = MPVolumeView()
        
        let slider = volumeView.subviews.first(where: {
            $0 is UISlider
        }) as? UISlider
                
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = Float(volume)
        }
    }
}

extension UIColor {
    static let darkGreen = UIColor(red: 27/255, green: 51/255, blue: 28/255, alpha: 1.0)
    
    static let acidGreen = UIColor(red: 103/255, green: 235/255, blue: 0/255, alpha: 1.0)
    
    static let backgroundGreen = UIColor(red: 153.0/255, green: 206.0/255, blue: 119.0/255, alpha: 1.0)
}

#Preview {
    SettingsView(isActive: .constant(true))
}
