
clang++ -c -DMX_COMPAT_32 -DMATLAB_MEX_FILE  -I"../../Software/casadi-osx-matlabR2014b-v3.3.0/include/"  -I"/Applications/MATLAB_R2014b.app/extern/include" -I"/Applications/MATLAB_R2014b.app/simulink/include" -fno-common -arch x86_64 -mmacosx-version-min=10.12 -fexceptions -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk -fobjc-arc -O2 -DNDEBUG /Users/jonas/Documents/repos/casadi_mex_callback/casadi_mex.cc -o casadi_mex.o -std=c++11

clang++ -L"../../Software/casadi-osx-matlabR2014b-v3.3.0/" -lcasadi -std=c++11 -Wl,-twolevel_namespace -undefined error -arch x86_64 -framework Cocoa -bundle  -Wl,-exported_symbols_list,"/Applications/MATLAB_R2014b.app/extern/lib/maci64/mexFunction.map" -L"/Applications/MATLAB_R2014b.app/bin/maci64" -lmx -lmex -lmat casadi_mex.o -o casadi_mex.mexmaci64