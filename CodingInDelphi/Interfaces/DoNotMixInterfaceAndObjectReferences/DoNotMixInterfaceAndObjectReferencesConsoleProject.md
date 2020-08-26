### `FastMM` shows the issue in `DoNotMixInterfaceAndObjectReferencesConsoleProject.dpr`

`FastMM` in `FullDebugMode` will overwrite the released memory, the stock memory will not.

To show the `DoNotMixInterfaceAndObjectReferencesConsoleProject.dpr` effects, you now can switch between the `FastMM` and stock memory manager.

The dependency on `FastMM` is solved in these steps:

1. Download the latest `FastMM` and other dependencies by running `Dependencies-Clone.bat` once, and `Dependencies-Pull.bat` each time you want to update.
1. Run the Delphi IDE through `Run-Dependend-Delphi-From-Path.bat`. It will call `Depedencies-Set.bat` which sets the `FastMM` environment variable to point to the sources in the `FastMM` directory.
1. For each depending project, refer to the `FastMM` environment variable in in the `Project Options`' `Search Path` as `$(FastMM)`
1. In the depending projects, just use the units in `FastMM` where needed.
1. Switch to `FastMM` by setting the conditional defines `FastMM;FullDebugMode` in your project options. If you remove the `FastMM` define, the stock memory manager is used.

