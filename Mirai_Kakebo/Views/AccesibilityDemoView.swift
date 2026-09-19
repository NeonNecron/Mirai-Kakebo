import SwiftUI
import AVFoundation
import Speech

struct AccessibilityDemoView: View {
    
    @State private var respuesta = ""
    @State private var mostrarResultado = false
    @State private var escuchando = false

    private let speechRecognizer =
        SFSpeechRecognizer(locale: Locale(identifier: "es-MX"))

    private let audioEngine = AVAudioEngine()

    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView {
                
                if geometry.size.width >= 700 {
                    
                    iPadLayout
                    
                } else {
                    
                    iPhoneLayout
                }
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationTitle("CAM Visión")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // MARK: - iPhone Layout
    
    private var iPhoneLayout: some View {
        
        VStack(
            alignment: .leading,
            spacing: 24
        ) {
            
            header
            
            instructionCard
            
            answerSection
            
            progressSection
            
            resultSection
        }
        .padding(24)
    }
    
    
    // MARK: - iPad Layout
    
    private var iPadLayout: some View {
        
        HStack(
            alignment: .top,
            spacing: 32
        ) {
            
            header
                .frame(maxWidth: 350)
            
            VStack(
                alignment: .leading,
                spacing: 24
            ) {
                
                instructionCard
                
                answerSection
                
                progressSection
                
                resultSection
            }
            .frame(maxWidth: 550)
        }
        .frame(maxWidth: 1000)
        .frame(maxWidth: .infinity)
        .padding(40)
    }
    
    
    // MARK: - Header
    
    private var header: some View {
        
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            Image(systemName: "eye.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(Color.accentColor)
                .accessibilityHidden(true)
            
            
            Text("CAM Visión")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.primary)
                .dynamicTypeSize(
                    .large ... .accessibility5
                )
            
            
            Text("Actividad accesible")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.primary)
                .dynamicTypeSize(
                    .large ... .accessibility5
                )
            
            
            Text(
                "Lee la instrucción, escribe tu respuesta y comprueba tu resultado."
            )
            .font(.body)
            .foregroundStyle(Color.secondary)
            .dynamicTypeSize(
                .medium ... .accessibility5
            )
            .fixedSize(
                horizontal: false,
                vertical: true
            )
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "CAM Visión. Actividad accesible. Lee la instrucción, escribe tu respuesta y comprueba tu resultado."
        )
    }
    
    
    // MARK: - Instruction Card
    
    private var instructionCard: some View {
        
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            Label(
                "Instrucción",
                systemImage: "book.fill"
            )
            .font(.headline)
            .foregroundStyle(Color.primary)
            
            
            Text(
                "Si tienes 100 pesos y gastas 30 pesos, ¿cuánto dinero te queda?"
            )
            .font(.title3)
            .foregroundStyle(Color.primary)
            .dynamicTypeSize(
                .large ... .accessibility5
            )
            .fixedSize(
                horizontal: false,
                vertical: true
            )
            
            
            Button {
                escucharInstruccion()
            } label: {
                
                Label(
                    "Escuchar instrucción",
                    systemImage: "speaker.wave.2.fill"
                )
                .frame(
                    maxWidth: .infinity,
                    minHeight: 56
                )
            }
            .buttonStyle(.bordered)
            .tint(Color.accentColor)
            .accessibilityLabel(
                "Escuchar instrucción"
            )
            .accessibilityHint(
                "Reproduce en voz alta la instrucción de la actividad."
            )
            .accessibilityAddTraits(.isButton)
        }
        .padding(20)
        .background(
            Color(.secondarySystemGroupedBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
    
    
    // MARK: - Answer
    
    private var answerSection: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Tu respuesta")
                .font(.headline)
                .foregroundStyle(Color.primary)
                .dynamicTypeSize(.large ... .accessibility5)
            
            Button {
                if escuchando {
                    detenerEscucha()
                } else {
                    iniciarEscucha()
                }
            } label: {
                
                VStack(spacing: 12) {
                    
                    Image(systemName:
                            escuchando
                            ? "stop.circle.fill"
                            : "mic.circle.fill"
                    )
                    .font(.system(size: 50))
                    
                    Text(
                        escuchando
                        ? "Escuchando..."
                        : "Responder por voz"
                    )
                    .font(.headline)
                    
                    Text(
                        escuchando
                        ? "Di tu respuesta claramente."
                        : "Toca para responder usando el micrófono."
                    )
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(24)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.accentColor)
            .accessibilityLabel(
                escuchando
                ? "Detener respuesta por voz"
                : "Responder por voz"
            )
            .accessibilityHint(
                escuchando
                ? "Detiene la grabación de tu respuesta."
                : "Activa el micrófono para decir tu respuesta en voz alta."
            )
            .accessibilityAddTraits(.isButton)
            
            if !respuesta.isEmpty {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("Respuesta reconocida")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                    
                    Text(respuesta)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel(
                    "Respuesta reconocida: \(respuesta)"
                )
            }
        }
    }
    
    
    private func iniciarEscucha() {
        
        SFSpeechRecognizer.requestAuthorization { status in
            
            DispatchQueue.main.async {
                
                guard status == .authorized else {
                    respuesta = "Permiso de voz no concedido"
                    return
                }
                
                comenzarReconocimiento()
            }
        }
    }
    
    private func comenzarReconocimiento() {
        
        recognitionTask?.cancel()
        recognitionTask = nil
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                .record,
                mode: .measurement,
                options: .duckOthers
            )
            
            try audioSession.setActive(
                true,
                options: .notifyOthersOnDeactivation
            )
            
        } catch {
            print("Error configurando audio: \(error)")
            return
        }
        
        recognitionRequest =
            SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else {
            return
        }
        
        guard let speechRecognizer = speechRecognizer,
              speechRecognizer.isAvailable else {
            return
        }
        
        escuchando = true
        
        let inputNode = audioEngine.inputNode
        
        recognitionTask = speechRecognizer.recognitionTask(
            with: recognitionRequest
        ) { result, error in
            
            if let result = result {
                
                respuesta = result.bestTranscription
                    .formattedString
            }
            
            if error != nil || result?.isFinal == true {
                detenerEscucha()
            }
        }
        
        let recordingFormat =
            inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(
            onBus: 0,
            bufferSize: 1024,
            format: recordingFormat
        ) { buffer, _ in
            
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("No se pudo iniciar el micrófono: \(error)")
        }
    }
    
    private func detenerEscucha() {
        
        audioEngine.stop()
        
        audioEngine.inputNode.removeTap(onBus: 0)
        
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        
        recognitionRequest = nil
        recognitionTask = nil
        
        escuchando = false
    }
    
    
    // MARK: - Progress
    
    private var progressSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            HStack {
                
                Text("Progreso")
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                
                Spacer()
                
                Text("60 %")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
            }
            
            
            ProgressView(value: 0.6)
                .tint(Color.accentColor)
                .accessibilityLabel(
                    "Progreso de la actividad"
                )
                .accessibilityValue(
                    "60 por ciento"
                )
                .accessibilityHint(
                    "Indica cuánto has avanzado en la actividad."
                )
        }
        .padding(18)
        .background(
            Color(.secondarySystemGroupedBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
    
    
    // MARK: - Result
    
    @ViewBuilder
    private var resultSection: some View {
        
        if mostrarResultado {
            
            let correcta =
                respuesta.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ) == "70"
            
            VStack(
                alignment: .leading,
                spacing: 10
            ) {
                
                Label(
                    correcta
                    ? "¡Muy bien!"
                    : "Inténtalo nuevamente",
                    systemImage:
                        correcta
                        ? "checkmark.circle.fill"
                        : "arrow.clockwise.circle.fill"
                )
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(
                    correcta
                    ? Color.green
                    : Color.orange
                )
                
                
                Text(
                    correcta
                    ? "La respuesta es correcta. Te quedan 70 pesos."
                    : "Recuerda: 100 menos 30 es igual a 70."
                )
                .font(.body)
                .foregroundStyle(Color.primary)
                .dynamicTypeSize(
                    .medium ... .accessibility5
                )
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
            }
            .padding(20)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .background(
                Color(.secondarySystemGroupedBackground)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            .accessibilityElement(children: .combine)
            .accessibilityLabel(
                correcta
                ? "Respuesta correcta. Te quedan 70 pesos."
                : "Respuesta incorrecta. Recuerda que 100 menos 30 es igual a 70."
            )
            .accessibilityAddTraits(.isStaticText)
            
        } else {
            
            Button {
                comprobarRespuesta()
            } label: {
                
                Label(
                    "Comprobar respuesta",
                    systemImage: "checkmark.circle.fill"
                )
                .font(.headline)
                .frame(
                    maxWidth: .infinity,
                    minHeight: 60
                )
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.accentColor)
            .accessibilityLabel(
                "Comprobar respuesta"
            )
            .accessibilityHint(
                "Comprueba si tu respuesta es correcta."
            )
            .accessibilityAddTraits(.isButton)
        }
    }
    
    
    // MARK: - Actions
    
    private func escucharInstruccion() {
        
        let texto = """
        Si tienes 100 pesos y gastas 30 pesos, ¿cuánto dinero te queda?
        """
        
        let utterance = AVSpeechUtterance(string: texto)
        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
        utterance.rate = 0.45
        
        speechSynthesizer.speak(utterance)
    }
    
    
    private func comprobarRespuesta() {
        
        withAnimation(.easeInOut) {
            mostrarResultado = true
        }
    }
}


// MARK: - Previews

#Preview("iPhone SE") {
    NavigationStack {
        AccessibilityDemoView()
    }
    .previewDevice(
        PreviewDevice(
            rawValue: "iPhone SE (3rd generation)"
        )
    )
}


#Preview("iPad") {
    NavigationStack {
        AccessibilityDemoView()
    }
    .previewDevice(
        PreviewDevice(
            rawValue: "iPad Pro (11-inch) (M4)"
        )
    )
}
