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
  nixifiedLockHash = "524f1fce7b52ef885906340ebdd079a81a7370fefaff14b3334764cde7e6b2c9";
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
  "registry+https://github.com/rust-lang/crates.io-index".anstyle."1.0.7" = overridableMkRustCrate (profileName: rec {
    name = "anstyle";
    version = "1.0.7";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "038dfcf04a5feb68e9c60b21c9625a54c2c0616e79b72b0fd87075a056ae1d1b"; };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".assert_cmd."2.0.14" = overridableMkRustCrate (profileName: rec {
    name = "assert_cmd";
    version = "2.0.14";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "ed72493ac66d5804837f480ab3766c72bdfab91a65e565fc54fa9e42db0073a8"; };
    dependencies = {
      anstyle = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".anstyle."1.0.7" { inherit profileName; }).out;
      bstr = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".bstr."1.9.1" { inherit profileName; }).out;
      doc_comment = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".doc-comment."0.3.3" { inherit profileName; }).out;
      predicates = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".predicates."3.1.0" { inherit profileName; }).out;
      predicates_core = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".predicates-core."1.0.6" { inherit profileName; }).out;
      predicates_tree = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".predicates-tree."1.0.9" { inherit profileName; }).out;
      wait_timeout = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".wait-timeout."0.2.0" { inherit profileName; }).out;
    };
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
  
  "registry+https://github.com/rust-lang/crates.io-index".bstr."1.9.1" = overridableMkRustCrate (profileName: rec {
    name = "bstr";
    version = "1.9.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "05efc5cfd9110c8416e471df0e96702d58690178e206e61b7173706673c93706"; };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "default" ]
      [ "std" ]
      [ "unicode" ]
    ];
    dependencies = {
      memchr = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.7.2" { inherit profileName; }).out;
      regex_automata = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex-automata."0.4.7" { inherit profileName; }).out;
      serde = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.203" { inherit profileName; }).out;
    };
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
      signal_hook = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".signal-hook."0.3.17" { inherit profileName; }).out;
    };
    devDependencies = {
      assert_cmd = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".assert_cmd."2.0.14" { inherit profileName; }).out;
      tempfile = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".tempfile."3.10.1" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".difflib."0.4.0" = overridableMkRustCrate (profileName: rec {
    name = "difflib";
    version = "0.4.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "6184e33543162437515c2e2b48714794e37845ec9851711914eec9d308f6ebe8"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".doc-comment."0.3.3" = overridableMkRustCrate (profileName: rec {
    name = "doc-comment";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"; };
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
      [ "default" ]
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
  
  "registry+https://github.com/rust-lang/crates.io-index".memchr."2.7.2" = overridableMkRustCrate (profileName: rec {
    name = "memchr";
    version = "2.7.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "6c8640c5d730cb13ebd907d8d04b52f55ac9a2eec55b440c8892f40d56c76c1d"; };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".predicates."3.1.0" = overridableMkRustCrate (profileName: rec {
    name = "predicates";
    version = "3.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "68b87bfd4605926cdfefc1c3b5f8fe560e3feca9d5552cf68c466d3d8236c7e8"; };
    features = builtins.concatLists [
      [ "diff" ]
    ];
    dependencies = {
      anstyle = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".anstyle."1.0.7" { inherit profileName; }).out;
      difflib = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".difflib."0.4.0" { inherit profileName; }).out;
      predicates_core = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".predicates-core."1.0.6" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".predicates-core."1.0.6" = overridableMkRustCrate (profileName: rec {
    name = "predicates-core";
    version = "1.0.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "b794032607612e7abeb4db69adb4e33590fa6cf1149e95fd7cb00e634b92f174"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".predicates-tree."1.0.9" = overridableMkRustCrate (profileName: rec {
    name = "predicates-tree";
    version = "1.0.9";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "368ba315fb8c5052ab692e68a0eefec6ec57b23a36959c14496f0b0df2c0cecf"; };
    dependencies = {
      predicates_core = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".predicates-core."1.0.6" { inherit profileName; }).out;
      termtree = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".termtree."0.4.1" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.85" = overridableMkRustCrate (profileName: rec {
    name = "proc-macro2";
    version = "1.0.85";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "22244ce15aa966053a896d1accb3a6e68469b97c7f33f284b99f0d576879fc23"; };
    features = builtins.concatLists [
      [ "proc-macro" ]
    ];
    dependencies = {
      unicode_ident = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-ident."1.0.12" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".quote."1.0.36" = overridableMkRustCrate (profileName: rec {
    name = "quote";
    version = "1.0.36";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"; };
    features = builtins.concatLists [
      [ "proc-macro" ]
    ];
    dependencies = {
      proc_macro2 = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.85" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".regex-automata."0.4.7" = overridableMkRustCrate (profileName: rec {
    name = "regex-automata";
    version = "0.4.7";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "38caf58cc5ef2fed281f89292ef23f6365465ed9a41b7a7754eb4e26496c92df"; };
    features = builtins.concatLists [
      [ "dfa-search" ]
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
  
  "registry+https://github.com/rust-lang/crates.io-index".serde."1.0.203" = overridableMkRustCrate (profileName: rec {
    name = "serde";
    version = "1.0.203";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "7253ab4de971e72fb7be983802300c30b5a7f0c2e56fab8abfc6a214307c0094"; };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "std" ]
    ];
    dependencies = {
      ${ if false then "serde_derive" else null } = (buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.203" { profileName = "__noProfile"; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.203" = overridableMkRustCrate (profileName: rec {
    name = "serde_derive";
    version = "1.0.203";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "500cbc0ebeb6f46627f50f3f5811ccf6bf00643be300b4c3eabc0ef55dc5b5ba"; };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
      proc_macro2 = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.85" { inherit profileName; }).out;
      quote = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.36" { inherit profileName; }).out;
      syn = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".syn."2.0.66" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".signal-hook."0.3.17" = overridableMkRustCrate (profileName: rec {
    name = "signal-hook";
    version = "0.3.17";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "8621587d4798caf8eb44879d42e56b9a93ea5dcd315a6487c357130095b62801"; };
    features = builtins.concatLists [
      [ "channel" ]
      [ "default" ]
      [ "iterator" ]
    ];
    dependencies = {
      libc = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.153" { inherit profileName; }).out;
      signal_hook_registry = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".signal-hook-registry."1.4.2" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".signal-hook-registry."1.4.2" = overridableMkRustCrate (profileName: rec {
    name = "signal-hook-registry";
    version = "1.4.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "a9e9e0b4211b72e7b8b6e85c807d36c212bdb33ea8587f7569562a84df5465b1"; };
    dependencies = {
      libc = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.153" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".syn."2.0.66" = overridableMkRustCrate (profileName: rec {
    name = "syn";
    version = "2.0.66";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"; };
    features = builtins.concatLists [
      [ "clone-impls" ]
      [ "derive" ]
      [ "parsing" ]
      [ "printing" ]
      [ "proc-macro" ]
    ];
    dependencies = {
      proc_macro2 = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.85" { inherit profileName; }).out;
      quote = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.36" { inherit profileName; }).out;
      unicode_ident = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-ident."1.0.12" { inherit profileName; }).out;
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
  
  "registry+https://github.com/rust-lang/crates.io-index".termtree."0.4.1" = overridableMkRustCrate (profileName: rec {
    name = "termtree";
    version = "0.4.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "3369f5ac52d5eb6ab48c6b4ffdc8efbcad6b89c765749064ba298f2c68a16a76"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-ident."1.0.12" = overridableMkRustCrate (profileName: rec {
    name = "unicode-ident";
    version = "1.0.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".wait-timeout."0.2.0" = overridableMkRustCrate (profileName: rec {
    name = "wait-timeout";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"; };
    dependencies = {
      ${ if hostPlatform.isUnix then "libc" else null } = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.153" { inherit profileName; }).out;
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
