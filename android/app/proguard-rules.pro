# Flutter Stripe
-keep class com.stripe.android.** { *; }
-keep interface com.stripe.android.** { *; }
-dontwarn com.stripe.android.**

# Kotlin Parcelize
-keep class kotlinx.parcelize.Parcelize
-keep class kotlinx.parcelize.Parceler
-dontwarn kotlinx.parcelize.Parcelize
-dontwarn kotlinx.parcelize.Parceler

# Generic keep for missing classes reported
-keep class com.stripe.android.pushProvisioning.** { *; }
