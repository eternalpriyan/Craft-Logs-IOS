import SwiftUI

struct ContentView: View {
    @EnvironmentObject var logManager: LogManager
    @State private var logText = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @FocusState private var isInputFocused: Bool
    @Binding var shouldFocusInput: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Recent logs preview
                if !logManager.recentLogs.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recent Logs")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        ForEach(logManager.recentLogs.prefix(5)) { log in
                            HStack {
                                Text(log.timestamp)
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundColor(.secondary)
                                Text(log.text)
                                    .font(.body)
                                    .lineLimit(1)
                                Spacer()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                
                Spacer()
                
                // Input area
                VStack(spacing: 12) {
                    HStack {
                        TextField("Quick log...", text: $logText, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .focused($isInputFocused)
                            .lineLimit(3...6)
                            .onSubmit {
                                submitLog()
                            }
                        
                        Button(action: {
                            // Voice input - Phase 3
                        }) {
                            Image(systemName: "mic.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Button(action: submitLog) {
                        HStack {
                            Image(systemName: "arrow.up.circle.fill")
                            Text("Log")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(logText.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(logText.isEmpty)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
            .padding()
            .navigationTitle("CraftLog")
            .navigationBarTitleDisplayMode(.large)
            .overlay(
                ToastView(message: toastMessage, isShowing: $showToast)
            )
            .onAppear {
                isInputFocused = true
            }
            .onChange(of: shouldFocusInput) { _, newValue in
                if newValue {
                    isInputFocused = true
                    shouldFocusInput = false
                }
            }
        }
    }
    
    private func submitLog() {
        guard !logText.isEmpty else { return }

        // Validate input length
        let trimmedText = logText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else {
            showToastMessage("Please enter some text")
            return
        }

        guard trimmedText.count <= Configuration.maxLogLength else {
            showToastMessage("Log too long (max \(Configuration.maxLogLength) characters)")
            return
        }

        Task {
            do {
                try await logManager.addLog(trimmedText)
                await MainActor.run {
                    logText = ""
                    showToastMessage("Logged ✓")
                }
            } catch {
                await MainActor.run {
                    if let logError = error as? LogError {
                        switch logError {
                        case .offline:
                            showToastMessage("Queued for sync")
                        case .failed(let message):
                            print("⚠️ Log failed: \(message)")
                            showToastMessage("Failed - will retry")
                        }
                    } else {
                        print("⚠️ Unexpected error: \(error.localizedDescription)")
                        showToastMessage("Error occurred")
                    }
                }
            }
        }
    }
    
    private func showToastMessage(_ message: String) {
        toastMessage = message
        showToast = true

        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
            await MainActor.run {
                showToast = false
            }
        }
    }
}

struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            if isShowing {
                Text(message)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            Spacer()
        }
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    ContentView(shouldFocusInput: .constant(false))
        .environmentObject(LogManager())
}
