# Language Server Protocol for Matlab

# Structures

## Request

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "textDocument/definition",
  "params": {
    "textDocument": {
      "uri": "file:///p%3A/mseng/VSCode/Playgrounds/cpp/use.cpp"
    },
    "position": {
      "line": 3,
      "character": 12
    }
  }
}
```

## Response

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "uri": "file:///p%3A/mseng/VSCode/Playgrounds/cpp/provide.cpp",
    "range": {
      "start": {
        "line": 0,
        "character": 4
      },
      "end": {
        "line": 0,
        "character": 11
      }
    }
  }
}
```

# TODO

- [x] Add basic RPC
- [ ] Add basic testing
- [ ] Add autocompletion for blocks of code(function() ... end)
- [ ] Add non-matching blocks
- [ ] Add syntax highlighting for treesitter queries
- [ ] Add scope checking for unknown variables or functions
