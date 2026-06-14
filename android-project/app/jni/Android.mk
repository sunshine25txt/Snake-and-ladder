# Android.mk - Top level NDK build file for Snadder Game
# This file compiles SDL2 libraries and the game source from source

LOCAL_PATH := $(call my-dir)

# Include SDL2 modules first (must be defined before game module references them)
include $(LOCAL_PATH)/SDL2/Android.mk
include $(LOCAL_PATH)/SDL2_ttf/Android.mk
include $(LOCAL_PATH)/SDL2_mixer/Android.mk

# Reset LOCAL_PATH after SDL includes (they modify it)
LOCAL_PATH := $(call my-dir)

# Build the game
include $(CLEAR_VARS)
LOCAL_MODULE := main

LOCAL_C_INCLUDES := $(LOCAL_PATH)/SDL2/include \
                    $(LOCAL_PATH)/SDL2_ttf/include \
                    $(LOCAL_PATH)/SDL2_mixer/include

LOCAL_SRC_FILES := src/75.cpp

LOCAL_SHARED_LIBRARIES := SDL2 SDL2_ttf SDL2_mixer

LOCAL_LDLIBS := -lGLESv1_CM -lGLESv2 -lOpenSLES -llog -landroid

LOCAL_CPPFLAGS := -std=c++17

include $(BUILD_SHARED_LIBRARY)
