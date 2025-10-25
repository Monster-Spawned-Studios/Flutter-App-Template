# Copyright © 2025 Monster Spawned Studios
# https://monsterspawned.studio/
# All rights reserved.

# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep classes that are used by reflection
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep Parcelable classes
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep R class
-keep class **.R
-keep class **.R$* {
    <fields>;
}

# Keep enum classes
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep annotation classes
-keep @interface *
-keep class * {
    @* <methods>;
}

# Keep classes with native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep classes that are referenced by native code
-keep class * extends java.lang.Exception

# Keep classes used by Flutter plugins
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep biometric authentication classes
-keep class androidx.biometric.** { *; }

# Keep notification classes
-keep class androidx.core.app.NotificationCompat** { *; }

# Keep permission handler classes
-keep class com.baseflow.permissionhandler.** { *; }

# Keep local auth classes
-keep class androidx.biometric.BiometricPrompt** { *; }

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}
