# Rendering PPTX slides to images

Read this before taking screenshots or snapshots of a `.pptx` file.

- Use ONLYOFFICE Document Server (Docker: `onlyoffice/documentserver`). Its `/converter` API renders pptx natively: POST a reachable URL to the file and get back per-slide PNGs (a zip if multi-slide).
  - The container needs `-e ALLOW_PRIVATE_IP_ADDRESS=true`. Its SSRF guard blocks fetching from local/private IPs by default.
  - `host.docker.internal` resolves to IPv6 inside the container and fails to connect. Use the IPv4 gateway address instead (`docker exec <container> getent ahostsv4 host.docker.internal`).
