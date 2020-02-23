#!/usr/bin/env node

const { Transform } = require('stream');

const defaultRegex = "[^A-Za-z0-9]";
const regex = new RegExp(process.argv[2] || defaultRegex, 'g');

function encode(character) {
  const code = character.charCodeAt(0);

  return `%${code.toString(16).padStart(2, '0')}`;
}

const urlencoder = new Transform({
  transform(chunk, encoding, callback) {
    const string = chunk.toString();
    callback(null, string.replace(regex, encode));
  }
});

process.stdin
  .pipe(urlencoder)
  .pipe(process.stdout);
