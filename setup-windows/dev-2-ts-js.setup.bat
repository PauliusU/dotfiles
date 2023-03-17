@ECHO OFF &:: Clean output and hide path of running command

TITLE JavaScript and TypeScript ecosystem

ECHO **** Volta [JavaScript Tool Manager] *****
powershell scoop install volta
:: Install latest Node.js 18 version [e.g. 18.19.1]
volta install node@18
:: Update NPM (newer than the one with Node)
volta install npm
volta install yarn
:: Display current volta toolchain
volta list
volta list node
:: Check paths
volta which node
volta which npm
volta which yarn
:: Check installed versions
volta -v
node -v
npm -v
yarn -v

ECHO **** NPM and Yarn global modules ****
:: Directly run TypeScript on Node.js without precompiling
npm i -g ts-node
ts-node -v

yarn global add yarn-add-no-save

ECHO **** Deno ****
powershell scoop install deno
deno upgrade
deno --version

