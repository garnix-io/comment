# This file was @generated by cargo2nix 0.11.0.
# It is not intended to be manually edited.

args@{
  release ? true,
  rootFeatures ? [
    "comment/default"
  ],
  rustPackages,
  buildRustPackages,
  hostPlatform,
  hostPlatformCpu ? null,
  hostPlatformFeatures ? [],
  target ? null,
  codegenOpts ? null,
  profileOpts ? null,
  cargoUnstableFlags ? null,
  rustcLinkFlags ? null,
  rustcBuildFlags ? null,
  mkRustCrate,
  rustLib,
  lib,
  workspaceSrc,
  ignoreLockHash,
}:
let
  nixifiedLockHash = "9bca6cd6aae59acbbfa00a69aa0c6206ca1285dbc726641b3867f4c2d0850045";
  workspaceSrc = if args.workspaceSrc == null then ./. else args.workspaceSrc;
  currentLockHash = builtins.hashFile "sha256" (workspaceSrc + /Cargo.lock);
  lockHashIgnored = if ignoreLockHash
                  then builtins.trace "Ignoring lock hash" ignoreLockHash
                  else ignoreLockHash;
in if !lockHashIgnored && (nixifiedLockHash != currentLockHash) then
  throw ("Cargo.nix ${nixifiedLockHash} is out of sync with Cargo.lock ${currentLockHash}")
else let
  inherit (rustLib) fetchCratesIo fetchCrateLocal fetchCrateGit fetchCrateAlternativeRegistry expandFeatures decideProfile genDrvsByProfile;
  profilesByName = {
  };
  rootFeatures' = expandFeatures rootFeatures;
  overridableMkRustCrate = f:
    let
      drvs = genDrvsByProfile profilesByName ({ profile, profileName }: mkRustCrate ({ inherit release profile hostPlatformCpu hostPlatformFeatures target profileOpts codegenOpts cargoUnstableFlags rustcLinkFlags rustcBuildFlags; } // (f profileName)));
    in { compileMode ? null, profileName ? decideProfile compileMode release }:
      let drv = drvs.${profileName}; in if compileMode == null then drv else drv.override { inherit compileMode; };
in
{
  cargo2nixVersion = "0.11.0";
  workspace = {
    comment = rustPackages.unknown.comment."0.0.0";
  };
  "registry+https://github.com/rust-lang/crates.io-index".anyhow."1.0.81" = overridableMkRustCrate (profileName: rec {
    name = "anyhow";
    version = "1.0.81";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "0952808a6c2afd1aa8947271f3a60f1a6763c7b912d210184c5149b5cf147247"; };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".bitflags."2.4.2" = overridableMkRustCrate (profileName: rec {
    name = "bitflags";
    version = "2.4.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "ed570934406eb16438a4e976b1b4500774099c13b8cb96eec99f620f05090ddf"; };
    features = builtins.concatLists [
      [ "std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".cfg-if."1.0.0" = overridableMkRustCrate (profileName: rec {
    name = "cfg-if";
    version = "1.0.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"; };
  });
  
  "unknown".comment."0.0.0" = overridableMkRustCrate (profileName: rec {
    name = "comment";
    version = "0.0.0";
    registry = "unknown";
    src = fetchCrateLocal workspaceSrc;
    dependencies = {
      anyhow = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".anyhow."1.0.81" { inherit profileName; }).out;
    };
    devDependencies = {
      tempfile = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".tempfile."3.10.1" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".errno."0.3.8" = overridableMkRustCrate (profileName: rec {
    name = "errno";
    version = "0.3.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "a258e46cdc063eb8519c00b9fc845fc47bcfca4130e2f08e88665ceda8474245"; };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      ${ if hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "hermit" || hostPlatform.parsed.kernel.name == "wasi" then "libc" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.153" { inherit profileName; }).out;
      ${ if hostPlatform.isWindows then "windows_sys" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows-sys."0.52.0" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".fastrand."2.0.1" = overridableMkRustCrate (profileName: rec {
    name = "fastrand";
    version = "2.0.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "25cbce373ec4653f1a01a31e8a5e5ec0c622dc27ff9c4e6606eefef5cbbed4a5"; };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "default" ]
      [ "std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".libc."0.2.153" = overridableMkRustCrate (profileName: rec {
    name = "libc";
    version = "0.2.153";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "9c198f91728a82281a64e1f4f9eeb25d82cb32a5de251c6bd1b5154d63a8e7bd"; };
    features = builtins.concatLists [
      [ "extra_traits" ]
      [ "std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".linux-raw-sys."0.4.13" = overridableMkRustCrate (profileName: rec {
    name = "linux-raw-sys";
    version = "0.4.13";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "01cda141df6706de531b6c46c3a33ecca755538219bd484262fa09410c13539c"; };
    features = builtins.concatLists [
      [ "elf" ]
      [ "errno" ]
      [ "general" ]
      [ "ioctl" ]
      [ "no_std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".rustix."0.38.31" = overridableMkRustCrate (profileName: rec {
    name = "rustix";
    version = "0.38.31";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "6ea3e1a662af26cd7a3ba09c0297a31af215563ecf42817c98df621387f4e949"; };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "default" ]
      [ "fs" ]
      [ "std" ]
      [ "use-libc-auxv" ]
    ];
    dependencies = {
      bitflags = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".bitflags."2.4.2" { inherit profileName; }).out;
      ${ if hostPlatform.parsed.kernel.name == "linux" && hostPlatform.parsed.cpu.significantByte == "littleEndian" && (hostPlatform.parsed.cpu.name == "armv6l" || hostPlatform.parsed.cpu.name == "armv7l" || hostPlatform.parsed.cpu.name == "aarch64" && hostPlatform.parsed.cpu.bits == 64 || hostPlatform.parsed.cpu.name == "riscv64" || hostPlatform.parsed.cpu.name == "i686" || hostPlatform.parsed.cpu.name == "x86_64" && hostPlatform.parsed.cpu.bits == 64) || !hostPlatform.isWindows && !(hostPlatform.parsed.kernel.name == "linux" && hostPlatform.parsed.cpu.significantByte == "littleEndian" && (hostPlatform.parsed.cpu.name == "armv6l" || hostPlatform.parsed.cpu.name == "armv7l" || hostPlatform.parsed.cpu.name == "aarch64" && hostPlatform.parsed.cpu.bits == 64 || hostPlatform.parsed.cpu.name == "riscv64" || hostPlatform.parsed.cpu.name == "i686" || hostPlatform.parsed.cpu.name == "x86_64" && hostPlatform.parsed.cpu.bits == 64)) || hostPlatform.isWindows then "libc_errno" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".errno."0.3.8" { inherit profileName; }).out;
      ${ if hostPlatform.parsed.kernel.name == "linux" && hostPlatform.parsed.cpu.significantByte == "littleEndian" && (hostPlatform.parsed.cpu.name == "armv6l" || hostPlatform.parsed.cpu.name == "armv7l" || hostPlatform.parsed.cpu.name == "aarch64" && hostPlatform.parsed.cpu.bits == 64 || hostPlatform.parsed.cpu.name == "riscv64" || hostPlatform.parsed.cpu.name == "i686" || hostPlatform.parsed.cpu.name == "x86_64" && hostPlatform.parsed.cpu.bits == 64) || !hostPlatform.isWindows && !(hostPlatform.parsed.kernel.name == "linux" && hostPlatform.parsed.cpu.significantByte == "littleEndian" && (hostPlatform.parsed.cpu.name == "armv6l" || hostPlatform.parsed.cpu.name == "armv7l" || hostPlatform.parsed.cpu.name == "aarch64" && hostPlatform.parsed.cpu.bits == 64 || hostPlatform.parsed.cpu.name == "riscv64" || hostPlatform.parsed.cpu.name == "i686" || hostPlatform.parsed.cpu.name == "x86_64" && hostPlatform.parsed.cpu.bits == 64)) then "libc" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.153" { inherit profileName; }).out;
      ${ if hostPlatform.parsed.kernel.name == "linux" && hostPlatform.parsed.cpu.significantByte == "littleEndian" && (hostPlatform.parsed.cpu.name == "armv6l" || hostPlatform.parsed.cpu.name == "armv7l" || hostPlatform.parsed.cpu.name == "aarch64" && hostPlatform.parsed.cpu.bits == 64 || hostPlatform.parsed.cpu.name == "riscv64" || hostPlatform.parsed.cpu.name == "i686" || hostPlatform.parsed.cpu.name == "x86_64" && hostPlatform.parsed.cpu.bits == 64) || (hostPlatform.parsed.kernel.name == "android" || hostPlatform.parsed.kernel.name == "linux") && !(hostPlatform.parsed.kernel.name == "linux" && hostPlatform.parsed.cpu.significantByte == "littleEndian" && (hostPlatform.parsed.cpu.name == "armv6l" || hostPlatform.parsed.cpu.name == "armv7l" || hostPlatform.parsed.cpu.name == "aarch64" && hostPlatform.parsed.cpu.bits == 64 || hostPlatform.parsed.cpu.name == "riscv64" || hostPlatform.parsed.cpu.name == "i686" || hostPlatform.parsed.cpu.name == "x86_64" && hostPlatform.parsed.cpu.bits == 64)) then "linux_raw_sys" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".linux-raw-sys."0.4.13" { inherit profileName; }).out;
      ${ if hostPlatform.isWindows then "windows_sys" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows-sys."0.52.0" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".tempfile."3.10.1" = overridableMkRustCrate (profileName: rec {
    name = "tempfile";
    version = "3.10.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "85b77fafb263dd9d05cbeac119526425676db3784113aa9295c88498cbf8bff1"; };
    dependencies = {
      cfg_if = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."1.0.0" { inherit profileName; }).out;
      fastrand = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".fastrand."2.0.1" { inherit profileName; }).out;
      ${ if hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "wasi" then "rustix" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".rustix."0.38.31" { inherit profileName; }).out;
      ${ if hostPlatform.isWindows then "windows_sys" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows-sys."0.52.0" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows-sys."0.52.0" = overridableMkRustCrate (profileName: rec {
    name = "windows-sys";
    version = "0.52.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"; };
    features = builtins.concatLists [
      [ "Win32" ]
      [ "Win32_Foundation" ]
      [ "Win32_NetworkManagement" ]
      [ "Win32_NetworkManagement_IpHelper" ]
      [ "Win32_Networking" ]
      [ "Win32_Networking_WinSock" ]
      [ "Win32_Storage" ]
      [ "Win32_Storage_FileSystem" ]
      [ "Win32_System" ]
      [ "Win32_System_Diagnostics" ]
      [ "Win32_System_Diagnostics_Debug" ]
      [ "Win32_System_Threading" ]
      [ "default" ]
    ];
    dependencies = {
      windows_targets = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows-targets."0.52.4" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows-targets."0.52.4" = overridableMkRustCrate (profileName: rec {
    name = "windows-targets";
    version = "0.52.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "7dd37b7e5ab9018759f893a1952c9420d060016fc19a472b4bb20d1bdd694d1b"; };
    dependencies = {
      ${ if hostPlatform.config == "aarch64-pc-windows-gnullvm" then "windows_aarch64_gnullvm" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows_aarch64_gnullvm."0.52.4" { inherit profileName; }).out;
      ${ if hostPlatform.parsed.cpu.name == "aarch64" && hostPlatform.parsed.abi.name == "msvc" then "windows_aarch64_msvc" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows_aarch64_msvc."0.52.4" { inherit profileName; }).out;
      ${ if hostPlatform.parsed.cpu.name == "i686" && hostPlatform.parsed.abi.name == "gnu" then "windows_i686_gnu" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows_i686_gnu."0.52.4" { inherit profileName; }).out;
      ${ if hostPlatform.parsed.cpu.name == "i686" && hostPlatform.parsed.abi.name == "msvc" then "windows_i686_msvc" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows_i686_msvc."0.52.4" { inherit profileName; }).out;
      ${ if hostPlatform.parsed.cpu.name == "x86_64" && hostPlatform.parsed.abi.name == "gnu" then "windows_x86_64_gnu" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows_x86_64_gnu."0.52.4" { inherit profileName; }).out;
      ${ if hostPlatform.config == "x86_64-pc-windows-gnullvm" then "windows_x86_64_gnullvm" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows_x86_64_gnullvm."0.52.4" { inherit profileName; }).out;
      ${ if hostPlatform.parsed.cpu.name == "x86_64" && hostPlatform.parsed.abi.name == "msvc" then "windows_x86_64_msvc" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".windows_x86_64_msvc."0.52.4" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows_aarch64_gnullvm."0.52.4" = overridableMkRustCrate (profileName: rec {
    name = "windows_aarch64_gnullvm";
    version = "0.52.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "bcf46cf4c365c6f2d1cc93ce535f2c8b244591df96ceee75d8e83deb70a9cac9"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows_aarch64_msvc."0.52.4" = overridableMkRustCrate (profileName: rec {
    name = "windows_aarch64_msvc";
    version = "0.52.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "da9f259dd3bcf6990b55bffd094c4f7235817ba4ceebde8e6d11cd0c5633b675"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows_i686_gnu."0.52.4" = overridableMkRustCrate (profileName: rec {
    name = "windows_i686_gnu";
    version = "0.52.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "b474d8268f99e0995f25b9f095bc7434632601028cf86590aea5c8a5cb7801d3"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows_i686_msvc."0.52.4" = overridableMkRustCrate (profileName: rec {
    name = "windows_i686_msvc";
    version = "0.52.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "1515e9a29e5bed743cb4415a9ecf5dfca648ce85ee42e15873c3cd8610ff8e02"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows_x86_64_gnu."0.52.4" = overridableMkRustCrate (profileName: rec {
    name = "windows_x86_64_gnu";
    version = "0.52.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "5eee091590e89cc02ad514ffe3ead9eb6b660aedca2183455434b93546371a03"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows_x86_64_gnullvm."0.52.4" = overridableMkRustCrate (profileName: rec {
    name = "windows_x86_64_gnullvm";
    version = "0.52.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "77ca79f2451b49fa9e2af39f0747fe999fcda4f5e241b2898624dca97a1f2177"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".windows_x86_64_msvc."0.52.4" = overridableMkRustCrate (profileName: rec {
    name = "windows_x86_64_msvc";
    version = "0.52.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "32b752e52a2da0ddfbdbcc6fceadfeede4c939ed16d13e648833a61dfb611ed8"; };
  });
  
}
