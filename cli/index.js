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
  if (!fs.existsSync(dest)) {
    fs.mkdirSync(dest);
  }

  const files = fs.readdirSync(src);

  for (const file of files) {
    const srcPath = path.join(src, file);
    const destPath = path.join(dest, file);

    if (file == "assets") {
      continue;
    }

    if (fs.statSync(srcPath).isDirectory()) {
      copyDirectory(srcPath, destPath);
    } else {
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
    let assetsPath;

    if (process.env.NODE_ENV === "production") {
      lovePath = "C:\\Program Files\\LOVE\\love.exe";
      enginePath = "C:\\Program Files\\steelengine-1.0";
      buildPath = enginePath + "\\build";
      assetsPath = enginePath + "\\assets";
    } else {
      lovePath = "C:\\Program Files\\LOVE\\love.exe";
      enginePath = "F:\\Projects\\Love2D\\2DGameEngine\\src";
      buildPath = enginePath + "\\build";
      assetsPath = enginePath + "\\assets";
    }

    const gamemodePath = path.resolve(string);

    // clear build directory
    if (fs.existsSync(buildPath)) {
      fs.rmdirSync(buildPath, { recursive: true });
    }

    // clear assets directory
    if (fs.existsSync(assetsPath)) {
      fs.rmdirSync(assetsPath, { recursive: true });
    }

    // copy files
    copyDirectory(gamemodePath, buildPath);

    let gamemodeAssets = path.join(gamemodePath, "assets");

    if (fs.existsSync(gamemodeAssets)) {
      copyDirectory(gamemodeAssets, assetsPath);
    }

    // start love process
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
