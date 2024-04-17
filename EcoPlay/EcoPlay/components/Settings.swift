import SwiftUI
import MediaPlayer

struct Settings: View {
    @Binding var isActive: Bool
    @Binding var isActiveSoundEffects: Bool
    @Binding var isActiveMusic: Bool
    private let backgroundMusic = BackgroundMusicClass.getBackgroundMusic()
    private let soundEffects = SoundEffectsClass.getSoundEffects()
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            Color.primary.opacity(0.35).ignoresSafeArea()
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    Text("settings".uppercased())
                        .font(Font.custom("Play-bold", size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.darkGreen)
                        .kerning(1)
                        .padding(.leading, 20)
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
                    VStack {
                        Toggle(isOn: $isActiveSoundEffects) {
                            Text("Sound Effects")
                                .font(Font.custom("Play-bold", size: 18))
                                .foregroundStyle(Color.darkGreen)
                        }
                        .tint(Color.backgroundTextGreen)
                        Toggle(isOn: $isActiveMusic) {
                            Text("Music")
                                .font(Font.custom("Play-bold", size: 18))
                                .foregroundStyle(Color.darkGreen)
                        }
                        .tint(Color.backgroundTextGreen)
                        .onChange(of: isActiveMusic) { oldValue, newValue in
                            if newValue {
                                backgroundMusic.play()
                            } else {
                                backgroundMusic.stop()
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(color: Color.darkGreen, radius: 0, x: 0, y: 8)
            .overlay {
                RoundedRectangle(cornerRadius: 25.0).stroke(.white, lineWidth: 3)
            }
            .padding(50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Settings(isActive: .constant(true), isActiveSoundEffects: .constant(true), isActiveMusic: .constant(true))
}
