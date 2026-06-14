package com.snadder.game;

import org.libsdl.app.SDLActivity;

/**
 * SDLActivity subclass for Snadder Game.
 * SDL2 handles everything - this just launches the native code.
 */
public class SnadderGame extends SDLActivity {

    /**
     * Return the name of the native shared library.
     * This MUST match LOCAL_MODULE in Android.mk
     */
    @Override
    protected String[] getLibraries() {
        return new String[]{
            "SDL2",
            "SDL2_ttf",
            "SDL2_mixer",
            "main"    // Our game library
        };
    }

    /**
     * Keep screen on while playing
     */
    @Override
    protected void onResume() {
        super.onResume();
        getWindow().addFlags(android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
    }
}
