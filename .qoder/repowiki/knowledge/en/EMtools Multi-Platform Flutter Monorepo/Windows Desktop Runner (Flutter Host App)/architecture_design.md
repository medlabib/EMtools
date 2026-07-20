Top-level `windows/CMakeLists.txt` defines the C++17 project, configures Debug/Profile/Release build types, includes the Flutter toolchain via `add_subdirectory(flutter)`, then adds the `runner/` subproject. The `flutter/` directory is Flutter-managed scaffolding containing generated plugin registration (`generated_plugin_registrant.{cc,h}`, `generated_plugins.cmake`) and its own `CMakeLists.txt`; it is not hand-edited.

The `runner/` subdirectory is the only hand-written code:
- `main.cpp` — `wWinMain` entry point: attaches to parent console when present, initializes COM, constructs a `DartProject(L"data")`, parses command-line arguments, creates a `FlutterWindow`, runs the Win32 message loop, and uninitializes COM.
- `win32_window.{h,cpp}` — reusable `Win32Window` abstraction over HWND creation, DPI-aware sizing, theme updates, and message routing; subclasses override `OnCreate`/`OnDestroy`/`MessageHandler`.
- `flutter_window.{h,cpp}` — subclass of `Win32Window` that hosts the Flutter view controller inside the Win32 window.
- `utils.{h,cpp}` — helper utilities (e.g. `GetCommandLineArguments`, `CreateAndAttachConsole`).
- `Runner.rc` / `resource.h` / `app_icon.ico` / `runner.exe.manifest` — Windows resource files for icon, version info, and manifest.

Dependency direction is one-way: `main` → `FlutterWindow` → `Win32Window` → Win32 API + Flutter C++ client headers. The install rules in the top CMake file copy the executable, Flutter runtime library, ICU data, bundled plugin DLLs, native assets, and the AOT snapshot (Profile/Release only) into a flat bundle next to the binary so Visual Studio can run from the IDE without a separate packaging step.