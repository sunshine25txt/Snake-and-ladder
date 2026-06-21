# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in ${sdk.dir}/tools/proguard/proguard-android.txt

# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Keep SDL classes
-keep class org.libsdl.app.** { *; }
-keep class com.snadder.game.** { *; }
