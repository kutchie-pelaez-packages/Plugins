import PackagePlugin

@main
struct AssetsPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        guard let target = target as? SourceModuleTarget else { return [] }

        return try target
            .sourceFiles(withSuffix: "xcassets")
            .map { try buildCommand(for: $0, context: context) }
    }

    private func buildCommand(for assetCatalog: File, context: PluginContext) throws -> Command {
        let assetCatalogPath = assetCatalog.path
        let assetCatalogName = assetCatalogPath.lastComponent
        let generatedFileName = assetCatalogPath.stem + ".swift"
        let generatedFilePath = context.pluginWorkDirectory.appending(generatedFileName)
        let executablePath = try context.tool(named: "AssetsPluginTool").path

        return .buildCommand(
            displayName: "Generating \(generatedFileName) for \(assetCatalogName)",
            executable: executablePath,
            arguments: [assetCatalogPath, generatedFilePath],
            inputFiles: [assetCatalogPath],
            outputFiles: [generatedFilePath]
        )
    }
}
