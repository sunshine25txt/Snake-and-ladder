#!/bin/bash
# ============================================================
# setup_android.sh - Setup script for Snadder Game Android Build
# Run this ONCE to prepare the project for building
# ============================================================

set -e

PROJ_DIR="$(cd "$(dirname "$0")" && pwd)"
ANDROID_DIR="$PROJ_DIR/android-project"
JNI_DIR="$ANDROID_DIR/app/jni"
ASSETS_DIR="$ANDROID_DIR/app/src/main/assets"

echo "======================================"
echo " Snadder Game Android Build Setup"
echo "======================================"

# Step 1: Copy game source and headers to JNI
echo "[1/4] Copying game source..."
mkdir -p "$JNI_DIR/src"
cp "$PROJ_DIR/75.cpp" "$JNI_DIR/src/75.cpp"
cp "$PROJ_DIR/features.hpp" "$JNI_DIR/src/features.hpp"
echo "  ✓ 75.cpp and features.hpp copied to jni/src/"

# Step 2: Copy game assets
echo "[2/4] Copying game assets..."

mkdir -p "$ASSETS_DIR"

rm -rf "$ASSETS_DIR/assets" "$ASSETS_DIR/questions.csv"

cp -r "$PROJ_DIR/assets" "$ASSETS_DIR/assets"
cp "$PROJ_DIR/questions.csv" "$ASSETS_DIR/questions.csv"

echo "  ✓ Assets copied (fonts, sounds, questions.csv)"

# Step 3: Check and Setup SDL2 Android Libraries from source (skip if already cloned by CI)
echo "[3/4] Checking and setting up SDL2 Android libraries from source..."

for lib in SDL2 SDL2_ttf SDL2_mixer; do
    if [ ! -d "$JNI_DIR/$lib" ] || [ ! -f "$JNI_DIR/$lib/Android.mk" ]; then
        echo "  → Downloading/Cloning $lib source..."
        rm -rf "$JNI_DIR/$lib"
        if [ "$lib" = "SDL2" ]; then
            git clone --depth 1 -b release-2.28.x https://github.com/libsdl-org/SDL.git "$JNI_DIR/SDL2"
        elif [ "$lib" = "SDL2_ttf" ]; then
            git clone --depth 1 --recursive -b SDL2 https://github.com/libsdl-org/SDL_ttf.git "$JNI_DIR/SDL2_ttf"
        elif [ "$lib" = "SDL2_mixer" ]; then
            git clone --depth 1 --recursive -b SDL2 https://github.com/libsdl-org/SDL_mixer.git "$JNI_DIR/SDL2_mixer"
        fi
        echo "  ✓ $lib downloaded."
    else
        echo "  ✓ Found: $lib (skipping clone)"
    fi
done

# Step 4: Check and copy SDLActivity.java (skip if already copied by CI)
SDL_ACTIVITY="$ANDROID_DIR/app/src/main/java/org/libsdl/app/SDLActivity.java"
if [ ! -f "$SDL_ACTIVITY" ]; then
    echo "[4/4] Copying SDLActivity.java..."
    mkdir -p "$ANDROID_DIR/app/src/main/java/org/libsdl/app/"
    cp "$JNI_DIR/SDL2/android-project/app/src/main/java/org/libsdl/app/"*.java "$ANDROID_DIR/app/src/main/java/org/libsdl/app/"
    echo "  ✓ SDLActivity.java copied."
else
    echo "[4/4] ✓ SDLActivity.java found (skipping copy)"
fi

echo ""
echo "======================================"
echo " Setup Complete!"
echo "======================================"
echo ""
echo "To build the APK:"
echo "  cd $ANDROID_DIR"
echo "  ./gradlew assembleDebug"
echo ""
echo "APK will be at:"
echo "  $ANDROID_DIR/app/build/outputs/apk/debug/app-debug.apk"
echo ""
