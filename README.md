# .NETZ - .NET Executables Compressor

### Usage: netz [-s] [-so] [exe file] [[-d] dll file]* [-a assemblyAttributes file]
            [-o outPutFolder]
            [-aw] [-p privatePath] [-i win32icon] [-n] [-c | -w] [-mta]
            [-pl platform] [-x86]
            ([-z] [-r compressLib] [-l redistributableCompressLib])
            ([-kf] [-kn] [-kd] | [-ka])
            [-sr] [-srp file]
            [-v] [-b] [-!]
            [-xr] name [[-d] dll file]*
            [-csc] string

### Where:

```
	-s   single exe, pack dll-s as resources      |
	-so  optimize single exe (valid with -s only) |
	-a   assemblyAttributes file, custom EXE assembly attributes
	     in the Visual Studio C# format
	-o   output folder, will be created if not exists, default exename.netz
	-aw  warn about unhandled EXE assembly attributes, default ignore
	-p   privatePath, optional private application domain path
	-i   win32icon, optional icon file
	-n   add version info to starter, default no info
	-c   console exe CUI, default is autodetect |
	-w   windows exe GUI, default is autodetect |
	-pl  supports /platform cross-compilation in 64 bit systems |
	-x86 shortcut for -pl x86                                   |
	-mta set MTAThread attribute to starter main (default STAThread)
```

### Compress options:

```
	-r   compressLib, compress provider dll, default defcomp.dll
	-z   pack redistributable compress DLL as resource, ignored if no
	     redistributable compress DLL
	-l   redistributableCompressLib, name of the redistributable
	     compress DLL, overwrites the one given by the provider
```

### Strong name (sign) options: (default no sign)

```
	-kf  keyFile, to use for signing the packed assembly |
	-kn  keyName, to use for signing the packed assembly |
	-kd  set delay sign true, default false              |
	-ka  get keyFile, keyName, delay sign, and algorithmId from EXE
	     attributes. The -kf, -kn and -kd are ignored when ka is specified

```

### Service options:

```
	-sr  creates a basic NT service from the input exe and dll files |
	-srp file, parameters file for -sr option |
```

### Debug options:

```
	-b   batch mode, generates a batch file and source code
	-v   print stack trace if error
	-!   print internal version
```

### The -xr option:

```
	-xr  the -xr should be used alone to create external DLL resources
```

### Other options:

```
	-csc string passes the string to csc compiler
```

### Input files:


```
	     At most one EXE file must be specified at [exe file].
	     The DLL files can be specified alone or with wildcards.     
	-d   If use before a DLL file, this option tells .NETZ that      
	     the next DLL will be loaded dynamically by the application. 
```

### Invoke-NetZ

```
    Invoke-NetZ -ExeFile "exe" -DllFiles @('dll1','dll2') -IconFile "ico" -DllResource	

```