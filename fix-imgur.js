    import * as fs from 'fs';
//  import * as fs from 'fs';
    import * as path from 'path';
//  import * as path from 'path';
    import { fileURLToPath } from 'url';
//  import { fileURLToPath } from 'url';

    const __filename = fileURLToPath(import.meta.url);
//  const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);
//  const __dirname = path.dirname(__filename);

    // Target the package.json inside node_modules
//  // Target the package.json inside node_modules

    const pkgPath = path.resolve(__dirname, 'node_modules/imgur/package.json');
//  const pkgPath = path.resolve(__dirname, 'node_modules/imgur/package.json');

    // Handle case where script is inside a subdirectory (e.g., /scripts/fix-imgur.js)
//  // Handle case where script is inside a subdirectory (e.g., /scripts/fix-imgur.js)

    const altPkgPath = path.resolve(__dirname, '../node_modules/imgur/package.json');
//  const altPkgPath = path.resolve(__dirname, '../node_modules/imgur/package.json');

    const targetPath = fs.existsSync(pkgPath) ? pkgPath : (fs.existsSync(altPkgPath) ? altPkgPath : null);
//  const targetPath = fs.existsSync(pkgPath) ? pkgPath : (fs.existsSync(altPkgPath) ? altPkgPath : null);

    if (!targetPath) {
//  if (!targetPath) {
        console.warn('⚠️  [fix-imgur] Could not find node_modules/imgur/package.json. Skipping patch.');
//      console.warn('⚠️  [fix-imgur] Could not find node_modules/imgur/package.json. Skipping patch.');
        process.exit(0);
//      process.exit(0);
    }
//  }

    try {
//  try {
        const fileContent = fs.readFileSync(targetPath, 'utf8');
//      const fileContent = fs.readFileSync(targetPath, 'utf8');
        const pkg = JSON.parse(fileContent);
//      const pkg = JSON.parse(fileContent);

        // Ensure exports['.'] exists
//      // Ensure exports['.'] exists
        if (pkg.exports && pkg.exports['.']) {
//      if (pkg.exports && pkg.exports['.']) {
            const currentExports = pkg.exports['.'];
//          const currentExports = pkg.exports['.'];

            // Check if patch is already applied
//          // Check if patch is already applied
            if (currentExports.types === './dist/index.d.ts') {
//          if (currentExports.types === './dist/index.d.ts') {
                console.log('✅ [fix-imgur] Types already patched.');
//              console.log('✅ [fix-imgur] Types already patched.');
                process.exit(0);
//              process.exit(0);
            }
//          }

            console.log('🔧 [fix-imgur] Patching "types" into exports...');
//          console.log('🔧 [fix-imgur] Patching "types" into exports...');

            // We create a new object to ensure "types" is the FIRST key.
//          // We create a new object to ensure "types" is the FIRST key.
            // Order matters for TypeScript resolution in "exports".
//          // Order matters for TypeScript resolution in "exports".
            pkg.exports['.'] = {
//          pkg.exports['.'] = {
                types: "./dist/index.d.ts",
//              types: "./dist/index.d.ts",
                ...currentExports
//              ...currentExports
            };
//          };

            fs.writeFileSync(targetPath, JSON.stringify(pkg, null, 2));
//          fs.writeFileSync(targetPath, JSON.stringify(pkg, null, 2));
            console.log('✨ [fix-imgur] Successfully patched imgur/package.json');
//          console.log('✨ [fix-imgur] Successfully patched imgur/package.json');
        } else {
//      } else {
            console.log('⚠️  [fix-imgur] Unexpected package structure. Exports field not found.');
//          console.log('⚠️  [fix-imgur] Unexpected package structure. Exports field not found.');
        }
//      }
    } catch (err) {
//  } catch (err) {
        console.error('❌ [fix-imgur] Error patching file:', err);
//      console.error('❌ [fix-imgur] Error patching file:', err);
        process.exit(1);
//      process.exit(1);
    }
//  }
