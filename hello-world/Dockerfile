FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# We need some dependencies for native AOT Compilation on linux
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       clang zlib1g-dev
WORKDIR /source
# Publish the app for linux x64
# Because we are compiling directly to an executable, we need to specify the target os and architecture with the -r flag 
# For windows this could be win-x64, and osx-x64 for mac (assuming x64 architecture)
COPY . .
RUN dotnet publish -c release -r linux-x64 -o /app
# Build the image
# Note that we only need /dotnet/runtime-deps, and not the full runtime image
FROM mcr.microsoft.com/dotnet/runtime-deps:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["/app/HelloWorld"]