{ lib
, buildPythonPackage
, fetchFromGitHub
, networkx
, rhasspy-asr
, rhasspy-nlu
, pythonOlder
, fetchpatch
}:

buildPythonPackage rec {
  pname = "rhasspy-asr-kaldi";
  version = "0.6.0";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "rhasspy";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-D+x/gNU9It5SFrPrvV2qoaHzJPbAa7JFp+2X9zYEqpw=";
  };

  propagatedBuildInputs = [
    networkx
    rhasspy-asr
    rhasspy-nlu
  ];

  postPatch = ''
    patchShebangs ./configure
    sed -i "s/networkx==.*/networkx/" requirements.txt
  '';

  # misses files
  doCheck = false;

  meta = with lib; {
    description = "Speech to text library for Rhasspy using Kaldi";
    homepage = "https://github.com/rhasspy/rhasspy-asr-kaldi";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
