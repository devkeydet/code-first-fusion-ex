# Power Platform CLI (pac) Code First / Fusion Test
Example of starting with pac cli, then incorporating things that only happen in the service / solution.

Code first elements include:
* PCF Component
* .NET Plugin

Elements autored in the service:
* Table
* Model-driven app
* Custom API

[TODO: Document more detailed repro steps to build from scratch using pac.]

# At a high level, the proces was:

update gitignore to ensure we don't commit files we don't want in the repo
```
# certain unpacked dataverse solution files
**/Controls/*/*
!**/Controls/*/ControlManifest.xml.data.xml
**/PluginAssemblies/**/*.dll

# export-unpack.ps1 puts things in a temp directory ignore in case delete part of script fails
/temp
```

create folders: src/solutions/CodeFirstFusionExample

**pac solution init** in the CodeFirstFusionExample solution folder

rename 'src' subdirectory to 'unpacked-solution' (preference for clarity)

edit CodeFirstFusionExample.cdsproj: replace 'src' text in SolutionRootPath element to 'unpacked-solution'

edit CodeFirstFusionExample.cdsproj: enable SolutionPackageType to Both

**dotnet build** in the CodeFirstFusionExample solution folder

**pac solution import** of the unmanaged zip file in the bin/debug folder

create folders: src/solutions/plugins/CodeFirstFusionExample.Plugins

**pac plugin init**

author plugin in VSCode

**dotnet build** in the CodeFirstFusionExample.Plugins folder

deploy plugin with plugin registration tool

add plugin assembly to unmanaged solution in make.powerapps.com

in powershell set:
```
$solutionName = "CodeFirstFusionExample"
```

Export/Unpack metadata from changes made in make.powerapps.com
```
. .\export-unpack.ps1
```

**pac solution add-reference** (to plugin)

author plugin in VSCode

run **dotnet build** in plugin folder

deploy plugin with plugin registration tool

manually add plugin assembly to imported solution

**pac solution unpack** (to get plugin metadata)

use plugin registration tool to register messages

pac solution export

pac solution unpack (to get message metadata back in unpacked format)