const esbuild = require('esbuild');
const { stimulusPlugin } = require('esbuild-plugin-stimulus');
const path = require('node:path');

const currentDir = path.resolve(__dirname);
const isWatch = process.argv.includes('--watch');

const buildOptions = {
  entryPoints: [path.resolve(currentDir, 'application.js')],
  bundle: true,
  sourcemap: true,
  outdir: 'app/assets/builds',
  define: {
    global: 'window',
  },
  plugins: [stimulusPlugin()],
};

async function build() {
  if (isWatch) {
    const ctx = await esbuild.context(buildOptions);
    ctx.watch();
  } else {
    await esbuild
      .build(buildOptions)
      .catch(() => process.exit(1));
  }
}

build();
