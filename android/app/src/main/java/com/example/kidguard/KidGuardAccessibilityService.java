package com.example.kidguard;

import android.accessibilityservice.AccessibilityService;
import android.view.accessibility.AccessibilityEvent;
import android.util.Log;

public class KidGuardAccessibilityService extends AccessibilityService {

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        final int eventType = event.getEventType();
        String packageName = event.getPackageName() != null ? event.getPackageName().toString() : "";
        Log.d("KidGuardAccessibility", "Event from package: " + packageName + " | Type: " + eventType);
    }

    @Override
    public void onInterrupt() {
        Log.d("KidGuardAccessibility", "Service Interrupted");
    }

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();
        Log.d("KidGuardAccessibility", "KidGuard Accessibility Service Connected Successfully");
    }
}
