@ECHO OFF &:: Clean output and hide path of running command

TITLE JavaScript and TypeScript ecosystem

ECHO **** Volta [JavaScript Tool Manager] *****
powershell scoop install volta
:: Install latest Node.js 22 version
volta install node@22
:: Update NPM (newer than the one with Node)
volta install npm
:: Create a symlink to the config file
MKLINK "%USERPROFILE%\.npmrc" "d:\Dropbox\dev\config\.npmrc"
volta install pnpm
REM pnpm config set store-dir %USERPROFILE%\.cache\.pnpm-store
REM pnpm store path
volta install bun
:: Display current volta toolchain
volta list
volta list node
:: Check paths
volta which node
volta which npm
:: Check installed versions
volta -v
node -v
npm -v
pnpm -v

ECHO **** NPM global packages ****
:: TypeScript compiler for ts-node and other tools
npm i -g typescript
tsc -v
:: Directly run TypeScript on Node.js without precompiling
npm i -g ts-node
ts-node -v
:: Directly run TypeScript on Node.js without precompiling
npm i -g tsx
tsx -v
:: Upgrade package.json dependencies
npm i -g npm-check-updates
npm list -g --depth 0
