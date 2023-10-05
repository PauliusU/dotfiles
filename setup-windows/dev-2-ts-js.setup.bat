@ECHO OFF &:: Clean output and hide path of running command

TITLE JavaScript and TypeScript ecosystem

ECHO **** Volta [JavaScript Tool Manager] *****
powershell scoop install volta
:: Install latest Node.js 18 version [e.g. 18.19.1]
volta install node@18
:: Update NPM (newer than the one with Node)
volta install npm
volta install yarn
volta install pnpm
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
pnpm -v

ECHO **** NPM and Yarn global packages ****
:: TypeScript compiler for ts-node and other tools
npm i -g typescript
tsc -v
:: Directly run TypeScript on Node.js without precompiling
npm i -g ts-node
ts-node -v
:: Upgrade package.json dependencies
npm i -g npm-check-updates
npm list -g --depth 0

yarn global add yarn-add-no-save
yarn global list

ECHO **** Deno ****
powershell scoop install deno
deno upgrade
deno --version
