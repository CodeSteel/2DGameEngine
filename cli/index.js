#! /usr/bin/env node
const { program } = require("commander");
const chalk = require("chalk");
const { spawn } = require("child_process");
const path = require("path");
const dotenv = require("dotenv");
dotenv.config();
const fs = require("fs");

const log = (log) => console.log(`${chalk.red("[SteelEngine]")} ${log}`);

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
  .option("-c --console", "Runs the game in console mode")
  .action((string, options) => {
    log("🚀 Building project!");

    let lovePath;
    let enginePath;
    let buildPath;

    if (process.env.NODE_ENV === "production") {
      lovePath = "C:\\Program Files\\LOVE\\love.exe";
      enginePath = "C:\\Program Files\\steelengine-1.0";
      buildPath = "C:\\Program Files\\steelengine-1.0\\build";
    } else {
      lovePath = "C:\\Program Files\\LOVE\\love.exe";
      enginePath = "F:\\Projects\\Love2D\\2DGameEngine\\src";
      buildPath = "F:\\Projects\\Love2D\\2DGameEngine\\src\\build";
    }

    const gamemodePath = path.resolve(string);

    // clear directory first
    if (fs.existsSync(buildPath)) {
      fs.rmdirSync(buildPath, { recursive: true });
    }

    copyDirectory(gamemodePath, buildPath);

    const arguments = [enginePath];

    if (options.console) {
      arguments.push("--console");
    }

    const loveProcess = spawn(lovePath, arguments);

    loveProcess.on("error", (err) => {
      log(`⚠️ Failed to start process: ${err}`);
    });

    loveProcess.on("close", (code) => {
      if (code === 0) {
        log("Process exited successfully! ❤️");
      } else {
        log(`📢 Process exited with code: ${code}`);
      }
    });
  });

program.parse(process.argv);

module.exports = { program };
