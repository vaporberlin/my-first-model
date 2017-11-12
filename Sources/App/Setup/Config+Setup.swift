import LeafProvider
import FluentProvider

extension Config {
  public func setup() throws {
    try setupProviders()
    try setupPreparations()
  }
    
  /// Configure providers
  private func setupProviders() throws {
    try addProvider(LeafProvider.Provider.self)
    try addProvider(FluentProvider.Provider.self)
  }
    
  /// Add all models that should have their
  /// schemas prepared before the app boots
  private func setupPreparations() throws {
    preparations.append(User.self)
  }
}
