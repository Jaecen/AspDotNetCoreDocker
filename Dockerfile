# Build code
FROM microsoft/dotnet:2.1-sdk AS build

COPY *.sln ./
COPY src/. ./src/
RUN ["dotnet", "restore"]
RUN ["dotnet", "publish", "--configuration", "Release", "--output", "../../deploy/"]

# Create app image
FROM microsoft/dotnet:2.1-aspnetcore-runtime

COPY --from=build /deploy/ /app

EXPOSE 80
ENTRYPOINT ["dotnet", "app/AspDotNetCoreDocker.Web.dll"]