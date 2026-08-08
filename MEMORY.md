## GOTCHA

- Symptom: WebDAV accepts unauthenticated CRUD requests despite configured users. Cause: `hacdias/webdav` does not enable authentication merely because `users` is set. Fix: set `auth: true` whenever exposing credential-protected WebDAV access.

## TASTE

## CONVENTIONS
