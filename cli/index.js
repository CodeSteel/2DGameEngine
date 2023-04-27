#! /usr/bin/env node
const { program } = require("commander");
const chalk = require("chalk");
const { spawn } = require("child_process");
const path = require("path");
const fs = require("fs");

const lovePath = "C:\\Program Files\\LOVE\\love.exe";
const enginePath = "F:\\Projects\\Love2D\\2DGameEngine\\src";
const buildPath = "F:\\Projects\\Love2D\\2DGameEngine\\src\\build";

const log = (log) => console.log(`${chalk.red("[BOOM]")} ${log}`);

const copyDirectory = (src, dest) => {
  // Create the destination directory if it doesn't exist
  if (!fs.existsSync(dest)) {
    fs.mkdirSync(dest);
  }

  // Get the list of files and directories in the source directory
  const files = fs.readdirSync(src);

  // Copy each file or directory recursively
  for (const file of files) {
    const srcPath = path.join(src, file);
    const destPath = path.join(dest, file);

    if (fs.statSync(srcPath).isDirectory()) {
      // Recursively copy directories
      copyDirectory(srcPath, destPath);
    } else {
      // Copy files
      fs.copyFileSync(srcPath, destPath);
    }
  }
};

program.addHelpCommand("help [command]", "Displays help for command.");
program.addHelpText(
  "afterAll",
  `\nMore information at ${chalk.red(
    "https://github.com/CodeSteel/SteelEngine"
  )}.`
);

const buildProgram = program
  .command("build")
  .description("Builds a project directory.")
  .argument("<path>", "Path to the project directory")
  .action((string, options) => {
    log("Building project...");

    const gamemodePath = path.resolve(string);

    // clear directory first
    if (fs.existsSync(buildPath)) {
      fs.rmdirSync(buildPath, { recursive: true });
    }

    copyDirectory(gamemodePath, buildPath);

    const loveProcess = spawn(lovePath, [enginePath]);

    loveProcess.on("error", (err) => {
      console.error(`Failed to start Love2D: ${err}`);
    });

    loveProcess.on("close", (code) => {
      console.log(`Love2D process exited with code ${code}`);
    });
  });

program.parse(process.argv);

module.exports = { program };
