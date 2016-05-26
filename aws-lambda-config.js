dotenv = require('dotenv').config()

aws_role = process.env.AWS_ROLE

var packageJson = require("./package.json")

module.exports = {
  functionName: packageJson.name,
  description: "v" + packageJson.version + ": " + packageJson.description,
  region: "ap-northeast-1",
  role: aws_role,
  memorySize: 128,
  timeout: 3,
  runtime: "nodejs4.3",
  handler: "index.handler"
}
