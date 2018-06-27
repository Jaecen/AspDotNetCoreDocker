# Build code
FROM microsoft/dotnet:2.1-sdk as build

COPY src/ ./src
RUN ["dotnet", "restore", "src"]
RUN ["dotnet", "publish", "src", "--configuration", "Release", "--output", "../../deploy/"]

# Create app image
FROM microsoft/dotnet:2.1-aspnetcore-runtime

COPY --from=build /deploy/ .

ENTRYPOINT ["dotnet", "AspNetCoreDocker.dll"]