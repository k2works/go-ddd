const { src, dest, series, task } = require('gulp');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

/**
 * Task to generate API client from OpenAPI specification
 * This task replaces the functionality of generate-api.sh script
 * and works on both Unix-based systems and Windows
 */
function generateApi(cb) {
  // Check if OpenAPI Generator CLI is installed
  const packageJsonPath = path.join(__dirname, 'package.json');
  const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
  
  if (!packageJson.devDependencies['@openapitools/openapi-generator-cli']) {
    console.log('Installing @openapitools/openapi-generator-cli...');
    exec('npm install --save-dev @openapitools/openapi-generator-cli', (err) => {
      if (err) {
        console.error('Error installing OpenAPI Generator CLI:', err);
        return cb(err);
      }
      generateApiClient(cb);
    });
  } else {
    generateApiClient(cb);
  }
}

function generateApiClient(cb) {
  console.log('Generating API client...');
  
  // Path to the OpenAPI specification
  const specPath = path.join(__dirname, '../backend/docs/swagger.json');
  // Output directory for the generated API client
  const outputPath = path.join(__dirname, 'src/api');
  
  // Command to generate the API client
  const command = `npx openapi-generator-cli generate -i ${specPath} -g typescript-axios -o ${outputPath} --additional-properties=supportsES6=true,npmName=marketplace-api-client,npmVersion=1.0.0`;
  
  exec(command, (err, stdout, stderr) => {
    if (err) {
      console.error('Error generating API client:', err);
      return cb(err);
    }
    
    console.log(stdout);
    if (stderr) console.error(stderr);
    
    console.log('API client generated successfully!');
    cb();
  });
}

// Export the task
exports.generateApi = generateApi;
exports.default = generateApi;