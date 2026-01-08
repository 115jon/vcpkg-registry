# Custom vcpkg Registry

A custom vcpkg registry for hosting private or modified ports.

## Ports

| Port | Description |
|------|-------------|
| `certify` | Boost.ASIO-based TLS certificate verification library |

## Usage

Add to your `vcpkg-configuration.json`:

```json
{
  "registries": [
    {
      "kind": "git",
      "repository": "https://github.com/115jon/vcpkg-registry",
      "baseline": "<COMMIT_SHA>",
      "packages": ["certify"]
    }
  ],
  "default-registry": {
    "kind": "git",
    "repository": "https://github.com/microsoft/vcpkg",
    "baseline": "<VCPKG_BASELINE>"
  }
}
```

Replace `<COMMIT_SHA>` with a commit from this repository and `<VCPKG_BASELINE>` with your desired vcpkg baseline.

## Adding New Ports

1. Create port files in `ports/<port-name>/`
2. Add version entry to `versions/<first-letter>-/<port-name>.json`
3. Update `versions/baseline.json`
4. Commit and get the git-tree SHA: `git rev-parse HEAD:ports/<port-name>`
5. Update the version file with the git-tree SHA
