@ECHO OFF &:: Clean output and hide path of running command

ECHO **** Python ****
:: REM winget install Python.Python.3.14
scoop install uv
python --version

ECHO **** pip ****
python -m ensurepip --upgrade --user
python -m pip install --upgrade --user pip
python -m pip --version
pip -V

ECHO **** Python global user packages via PIP ****
python -m pip install --upgrade --user setuptools
MKLINK /J "%USERPROFILE%\.virtualenvs" "%USER_BAK%\.virtualenvs"
:: HTTP/HTTPS requests
python -m pip install --upgrade --user requests
:: GoldenDict's Google Translate integration
python -m pip install --upgrade --user google-translate-for-goldendict

