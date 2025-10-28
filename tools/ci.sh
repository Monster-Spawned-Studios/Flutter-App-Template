# Copyright © 2025 Monster Spawned Studios
# https://monsterspawned.studio/
# All rights reserved.

# Log that the CI script is starting
echo "Starting CI script..."

# Build and test the project
flutter test

# Log that the tests are complete
echo "Tests complete!"

# Build the project
flutter build apk
flutter build appbundle
flutter build ipa
flutter build web
flutter build windows
flutter build macos

# Log that the builds are complete
echo "Builds complete!"

# Log that the CI script is complete
echo "CI script complete!"