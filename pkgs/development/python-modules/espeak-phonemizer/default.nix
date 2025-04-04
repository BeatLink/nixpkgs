{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  replaceVars,
  espeak-ng,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "espeak-phonemizer";
  version = "1.3.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "rhasspy";
    repo = "espeak-phonemizer";
    tag = "v${version}";
    hash = "sha256-K0s24mzXUqG0Au40jjGbpKNAznBkMHQzfh2/CDBN0F8=";
  };

  patches = [
    (replaceVars ./cdll.patch {
      libespeak_ng = "${lib.getLib espeak-ng}/lib/libespeak-ng.so";
    })
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  meta = with lib; {
    changelog = "https://github.com/rhasspy/espeak-phonemizer/releases/tag/v${version}";
    description = "Uses ctypes and libespeak-ng to transform test into IPA phonemes";
    mainProgram = "espeak-phonemizer";
    homepage = "https://github.com/rhasspy/espeak-phonemizer";
    license = licenses.mit;
    maintainers = with maintainers; [ hexa ];
    platforms = platforms.linux;
  };
}
