#! /usr/bin/env node
process.env["NODE_OPTIONS"] = "--no-deprecation";
const { program } = require("commander");
const chalk = require("chalk");
const { spawn, exec } = require("child_process");
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

    if (file == "build") {
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
  .description("Builds the project.")
  .argument("<path>", "Path to the project directory")
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
      enginePath = "F:\\Projects\\Love2D\\SteelEngine\\src";
      buildPath = enginePath + "\\build";
      assetsPath = enginePath + "\\assets";
    }

    const gamemodePath = path.resolve(string);

    // clear build directory
    if (fs.existsSync(buildPath)) {
      fs.rmSync(buildPath, { recursive: true });
    }

    // clear assets directory
    if (fs.existsSync(assetsPath)) {
      fs.rmSync(assetsPath, { recursive: true });
    }

    // copy files
    copyDirectory(gamemodePath, buildPath);

    let gamemodeAssets = path.join(gamemodePath, "assets");

    if (fs.existsSync(gamemodeAssets)) {
      copyDirectory(gamemodeAssets, assetsPath);
    }

    // remove the makelove.toml file if it exists
    const makelovePath = path.join(enginePath, "makelove.toml");
    if (fs.existsSync(makelovePath)) {
      fs.unlinkSync(makelovePath);
    }

    // remove makelove-build directory if it exists
    const makeloveBuildPath = path.join(enginePath, "makelove-build");
    if (fs.existsSync(makeloveBuildPath)) {
      fs.rmSync(makeloveBuildPath, { recursive: true });
    }

    // start love process
    const initProcess = spawn("makelove", ["--init"], {
      cwd: enginePath,
      stdio: "inherit",
    });

    initProcess.on("close", (code) => {
      if (code == 0) {
        log("Config file built!");

        const arguments = [enginePath];
        const loveProcess = spawn("makelove", [], {
          cwd: enginePath,
          stdio: "inherit",
        });

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
      } else {
        log(`📢 Process exited with code: ${code}`);
      }
    });

    initProcess.on("error", (err) => {
      log(`⚠️ Failed to start process: ${err}`);
    });
  });

const runProgram = program
  .command("run")
  .description("Runs the project.")
  .argument("<path>", "Path to the project directory")
  .option("-c --console", "Runs the game in console mode")
  .action((string, options) => {
    log("🚀 Running project!");

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
      enginePath = "F:\\Projects\\Love2D\\SteelEngine\\src";
      buildPath = enginePath + "\\build";
      assetsPath = enginePath + "\\assets";
    }

    const gamemodePath = path.resolve(string);

    // clear build directory
    if (fs.existsSync(buildPath)) {
      fs.rmSync(buildPath, { recursive: true });
    }

    // clear assets directory
    if (fs.existsSync(assetsPath)) {
      fs.rmSync(assetsPath, { recursive: true });
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
