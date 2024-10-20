# Create by Antonio Thomacelli Gomes to install simple React App with Typescript
# has option to install Material UI to increment this App

#!/bin/bash

# Create necessary directories
mkdir -p src public

# Initialize yarn project
yarn init -y

# Install dependencies
yarn add react react-dom
yarn add --dev typescript @types/react @types/react-dom

# Install CSS Loader
yarn add --save-dev style-loader css-loader

# Install Webpack and related tools
yarn add --dev webpack webpack-cli webpack-dev-server html-webpack-plugin ts-loader

# Create basic files
cat <<EOT >> src/index.tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root') as HTMLElement);
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOT

#cat <<EOT >> src/App.tsx
#import React from 'react';
#import { Button } from '@mui/material';
#
#const App: React.FC = () => {
#    return (
#        <div>
#            <h1>Hello, React with Material UI!</h1>
#            <Button variant="contained" color="primary">
#                Click Me
#            </Button>
#        </div>
#    );
#};
#
#export default App;
#EOT

cat <<EOT >> src/App.tsx
import React from 'react';

const App: React.FC = () => {
  return (
    <div>
      <h1>Hello, React with TypeScript!</h1>
    </div>
  );
};

export default App;
EOT

cat <<EOT >> public/index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My React App</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>
EOT

# Create tsconfig.json
npx tsc --init --jsx react-jsx

# Create webpack.config.js
cat <<EOT >> webpack.config.js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: './src/index.tsx',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js',
    clean: true
  },
  resolve: {
    extensions: ['.ts', '.tsx', '.js']
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/
      },
      {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader'
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html'
    })
  ],
  devServer: {
    static: path.join(__dirname, 'public'),
    port: 3000,
    open: true
  }
};
EOT

# Add "start" script to package.json using jq
if command -v jq > /dev/null 2>&1; then
    jq '.scripts.start = "webpack serve --config webpack.config.js --mode development"' package.json > tmp.json && mv tmp.json package.json
else
    echo '"start" script was not added because jq is not installed. Please install jq or add the script manually.'
fi

## Add Material UI
#yarn add @mui/material @emotion/react @emotion/styled
#yarn add @mui/icons-material

# Done
echo "Setup completed. Run 'yarn start' to launch the project."
